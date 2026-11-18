// Firestore rules tests. Run with `npm install && npm test` (needs Java 11+).
import { after, before, beforeEach, describe, test } from "node:test";
import { readFileSync } from "node:fs";
import {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
} from "@firebase/rules-unit-testing";
import {
  collection,
  deleteDoc,
  deleteField,
  doc,
  getDoc,
  getDocs,
  query,
  serverTimestamp,
  setDoc,
  updateDoc,
  where,
  writeBatch,
} from "firebase/firestore";

let env;

const COURSE = "math-101";
const SECTION = "s1";
const TEST = "t1";
const itemPath = `Courses/${COURSE}/Sections/${SECTION}/Items/${TEST}`;
const keyPath = `${itemPath}/Private/answerKey`;

const users = {
  teacher: { uid: "teacher", role: "Teacher", status: "Active", teacherExtraData: { subject: "Math", workExperience: "5", wallet: { balance: 120, total_earned: 300, payout_pending: 0, status: "active" } } },
  otherTeacher: { uid: "otherTeacher", role: "Teacher", status: "Active", teacherExtraData: { subject: "Math", workExperience: "1", wallet: { balance: 0 } } },
  student: { uid: "student", role: "Student", status: "Active", teacherExtraData: null, studentExtraData: { educationLevel: "1" } },
  outsider: { uid: "outsider", role: "Student", status: "Active", teacherExtraData: null },
  blocked: { uid: "blocked", role: "Student", status: "Blocked", teacherExtraData: null },
  admin: { uid: "admin", role: "Admin", status: "Active", teacherExtraData: null },
  manager: { uid: "manager", role: "CoursesManager", status: "Active", teacherExtraData: null },
  support: { uid: "support", role: "Support", status: "Active", teacherExtraData: null },
};

const db = (name) => env.authenticatedContext(name).firestore();

function courseData(state = "Published", extra = {}) {
  return {
    id: COURSE,
    title: "Algebra",
    description: "d",
    posterUrl: "",
    price: 100,
    language: "ar",
    subject: "Math",
    level: "1",
    state,
    studentsCount: 1,
    lessonsCount: 1,
    testsCount: 1,
    feedBacksCount: 0,
    contentcreaterentity: { id: "teacher", name: "Mr T" },
    ...extra,
  };
}

async function seed(state = "Published") {
  await env.withSecurityRulesDisabled(async (ctx) => {
    const f = ctx.firestore();
    for (const user of Object.values(users)) {
      await setDoc(doc(f, `Users/${user.uid}`), user);
    }
    await setDoc(doc(f, `Courses/${COURSE}`), courseData(state));
    await setDoc(doc(f, `Courses/${COURSE}/Subscribers/student`), { id: "student" });
    await setDoc(doc(f, `Users/student/Courses/${COURSE}`), courseData(state));
    await setDoc(doc(f, `Courses/${COURSE}/Sections/${SECTION}`), { id: SECTION, title: "Unit 1" });
    await setDoc(doc(f, itemPath), { id: TEST, type: "Test", title: "Quiz", questions: [{ questionId: "q1", solutions: [{ answer: "4" }] }] });
    await setDoc(doc(f, keyPath), { questions: [{ questionId: "q1", solutions: [{ answer: "4", isCorrect: true }] }] });
    await setDoc(doc(f, `${itemPath}/Results/student-attempt-1`), { joinedby: { uid: "student" }, result: 1, teacherId: "teacher", courseId: COURSE });
    await setDoc(doc(f, `Users/student/MyResults/student-attempt-1`), { joinedby: { uid: "student" }, result: 1, teacherId: "teacher", courseId: COURSE });
    await setDoc(doc(f, `Courses/${COURSE}/Coupons/SAVE10`), { code: "SAVE10", discountPercentage: 10, usageLimit: 5, usedCount: 2, reservedCount: 1, status: "active" });
    await setDoc(doc(f, "Tickets/ticket1"), { id: "ticket1", sender: { uid: "student" }, status: "OPEN" });
  });
}

before(async () => {
  env = await initializeTestEnvironment({
    projectId: "demo-sintir",
    firestore: { rules: readFileSync(new URL("../firestore.rules", import.meta.url), "utf8") },
  });
});

after(async () => {
  await env?.cleanup();
});

beforeEach(async () => {
  await env.clearFirestore();
  await seed();
});

describe("users", () => {
  test("signed-out visitors read nothing", async () => {
    const anon = env.unauthenticatedContext().firestore();
    await assertFails(getDoc(doc(anon, `Courses/${COURSE}`)));
    await assertFails(getDoc(doc(anon, "Users/student")));
  });

  test("users read only their own profile", async () => {
    await assertSucceeds(getDoc(doc(db("student"), "Users/student")));
    await assertFails(getDoc(doc(db("student"), "Users/teacher")));
    await assertFails(getDocs(query(collection(db("student"), "Users"), where("role", "==", "Teacher"))));
    await assertSucceeds(getDoc(doc(db("support"), "Users/teacher")));
  });

  test("sign-up cannot pick a privileged role or status", async () => {
    await assertSucceeds(setDoc(doc(db("new1"), "Users/new1"), { uid: "new1", role: "Student", status: "Active", teacherExtraData: null }));
    await assertSucceeds(setDoc(doc(db("new2"), "Users/new2"), { uid: "new2", role: "Teacher", status: "Pending", teacherExtraData: { subject: "Math", wallet: { balance: 0, total_earned: 0, payout_pending: 0, status: "suspended" } } }));
    await assertSucceeds(setDoc(doc(db("new3"), "Users/new3"), { uid: "new3", role: "Support", status: "Pending", teacherExtraData: null }));
    await assertFails(setDoc(doc(db("new4"), "Users/new4"), { uid: "new4", role: "Admin", status: "Active", teacherExtraData: null }));
    await assertFails(setDoc(doc(db("new5"), "Users/new5"), { uid: "new5", role: "Teacher", status: "Active", teacherExtraData: { wallet: { balance: 0 } } }));
    await assertFails(setDoc(doc(db("new6"), "Users/new6"), { uid: "new6", role: "Teacher", status: "Pending", teacherExtraData: { wallet: { balance: 5000 } } }));
  });

  test("profile edits cannot touch role, status or the wallet", async () => {
    await assertSucceeds(updateDoc(doc(db("student"), "Users/student"), { fullName: "New Name", deviceId: "d1" }));
    await assertSucceeds(updateDoc(doc(db("teacher"), "Users/teacher"), { "teacherExtraData.subject": "Physics" }));
    await assertFails(updateDoc(doc(db("student"), "Users/student"), { role: "Admin" }));
    await assertFails(updateDoc(doc(db("student"), "Users/student"), { status: "Active", role: "Teacher" }));
    await assertFails(updateDoc(doc(db("teacher"), "Users/teacher"), { "teacherExtraData.wallet.balance": 99999 }));
    await assertFails(updateDoc(doc(db("student"), "Users/student"), { teacherExtraData: { wallet: { balance: 1 } } }));
  });

  test("staff powers are split by role", async () => {
    await assertSucceeds(updateDoc(doc(db("support"), "Users/student"), { status: "Blocked" }));
    await assertFails(updateDoc(doc(db("support"), "Users/student"), { role: "Admin" }));
    await assertFails(updateDoc(doc(db("manager"), "Users/student"), { status: "Blocked" }));
    await assertSucceeds(updateDoc(doc(db("admin"), "Users/student"), { role: "Support" }));
  });
});

describe("courses", () => {
  test("published courses are public to signed-in users, others only to the owner and buyers", async () => {
    await assertSucceeds(getDoc(doc(db("outsider"), `Courses/${COURSE}`)));
    await env.withSecurityRulesDisabled((ctx) => setDoc(doc(ctx.firestore(), `Courses/${COURSE}`), courseData("Pending")));
    await assertFails(getDoc(doc(db("outsider"), `Courses/${COURSE}`)));
    await assertSucceeds(getDoc(doc(db("teacher"), `Courses/${COURSE}`)));
    await assertSucceeds(getDoc(doc(db("student"), `Courses/${COURSE}`)));
    await assertSucceeds(getDocs(query(collection(db("outsider"), "Courses"), where("state", "==", "Published"))));
    await assertSucceeds(getDocs(query(collection(db("teacher"), "Courses"), where("contentcreaterentity.id", "==", "teacher"))));
    await assertFails(getDocs(query(collection(db("outsider"), "Courses"), where("contentcreaterentity.id", "==", "teacher"))));
  });

  test("checking whether a course id is free works", async () => {
    await assertSucceeds(getDoc(doc(db("teacher"), "Courses/brand-new")));
  });

  test("new courses start in review with clean counters", async () => {
    const fresh = { ...courseData("Pending"), id: "c2", studentsCount: 0, lessonsCount: 0, testsCount: 0 };
    await assertSucceeds(setDoc(doc(db("teacher"), "Courses/c2"), fresh));
    await assertFails(setDoc(doc(db("teacher"), "Courses/c3"), { ...fresh, id: "c3", state: "Published" }));
    await assertFails(setDoc(doc(db("teacher"), "Courses/c4"), { ...fresh, id: "c4", studentsCount: 500 }));
    await assertFails(setDoc(doc(db("student"), "Courses/c5"), { ...fresh, id: "c5", contentcreaterentity: { id: "student" } }));
    await assertFails(setDoc(doc(db("teacher"), "Courses/c6"), { ...fresh, id: "c6", contentcreaterentity: { id: "otherTeacher" } }));
  });

  test("editing what students see sends the course back to review", async () => {
    const ref = doc(db("teacher"), `Courses/${COURSE}`);
    await assertFails(updateDoc(ref, { price: 0 }));
    await assertFails(updateDoc(ref, { price: 0, state: "Published" }));
    await assertSucceeds(updateDoc(ref, { price: 0, state: "Pending" }));
  });

  test("teachers cannot approve themselves or fake stats", async () => {
    await env.withSecurityRulesDisabled((ctx) => setDoc(doc(ctx.firestore(), `Courses/${COURSE}`), courseData("Pending")));
    const ref = doc(db("teacher"), `Courses/${COURSE}`);
    await assertFails(updateDoc(ref, { state: "Published" }));
    await assertFails(updateDoc(ref, { studentsCount: 9999 }));
    await assertFails(updateDoc(ref, { ratingsSum: 50, ratingsCount: 10 }));
    await assertFails(updateDoc(doc(db("otherTeacher"), `Courses/${COURSE}`), { title: "x", state: "Pending" }));
  });

  test("archive and restore toggle only between published and archived", async () => {
    const ref = doc(db("teacher"), `Courses/${COURSE}`);
    await assertSucceeds(updateDoc(ref, { state: "DeletedByTeacher" }));
    await assertSucceeds(updateDoc(ref, { state: "Published" }));
    await env.withSecurityRulesDisabled((ctx) => setDoc(doc(ctx.firestore(), `Courses/${COURSE}`), courseData("Declined")));
    await assertFails(updateDoc(ref, { state: "DeletedByTeacher" }));
    await assertFails(updateDoc(ref, { state: "Published" }));
    await assertSucceeds(updateDoc(ref, { title: "Fixed", state: "Pending" }));
  });

  test("courses taken down by the admin are frozen for the teacher", async () => {
    await env.withSecurityRulesDisabled((ctx) => setDoc(doc(ctx.firestore(), `Courses/${COURSE}`), courseData("Archived")));
    await assertFails(updateDoc(doc(db("teacher"), `Courses/${COURSE}`), { title: "x", state: "Pending" }));
    await assertSucceeds(updateDoc(doc(db("manager"), `Courses/${COURSE}`), { state: "Published" }));
  });

  test("lesson and test counters stay non-negative", async () => {
    const ref = doc(db("teacher"), `Courses/${COURSE}`);
    await assertSucceeds(updateDoc(ref, { lessonsCount: 2 }));
    await assertFails(updateDoc(ref, { testsCount: -1 }));
  });
});

describe("paid content", () => {
  test("curriculum is visible before buying, answer keys never are", async () => {
    await assertSucceeds(getDocs(collection(db("outsider"), `Courses/${COURSE}/Sections`)));
    await assertSucceeds(getDoc(doc(db("outsider"), itemPath)));
    await assertFails(getDoc(doc(db("outsider"), keyPath)));
    await assertFails(getDoc(doc(db("student"), keyPath)));
    await assertSucceeds(getDoc(doc(db("teacher"), keyPath)));
    await assertFails(getDoc(doc(db("otherTeacher"), keyPath)));
  });

  test("enrolled students keep access while an edited course is in review", async () => {
    await env.withSecurityRulesDisabled((ctx) => setDoc(doc(ctx.firestore(), `Courses/${COURSE}`), courseData("Pending")));
    await assertSucceeds(getDoc(doc(db("student"), itemPath)));
    await assertFails(getDoc(doc(db("outsider"), itemPath)));
  });

  test("an admin take-down removes student access", async () => {
    await env.withSecurityRulesDisabled((ctx) => setDoc(doc(ctx.firestore(), `Courses/${COURSE}`), courseData("DeletedByAdmin")));
    await assertFails(getDoc(doc(db("student"), itemPath)));
    await assertSucceeds(getDoc(doc(db("teacher"), itemPath)));
  });

  test("only the owner writes content and answer keys", async () => {
    const teacher = db("teacher");
    const batch = writeBatch(teacher);
    batch.set(doc(teacher, keyPath), { questions: [] });
    batch.set(doc(teacher, itemPath), { id: TEST, type: "Test", questions: [] });
    await assertSucceeds(batch.commit());
    await assertFails(setDoc(doc(db("otherTeacher"), `${itemPath}2`), { type: "File" }));
    await assertFails(setDoc(doc(db("student"), keyPath), { questions: [] }));
  });

  test("students cannot write or forge results", async () => {
    await assertFails(setDoc(doc(db("student"), `${itemPath}/Results/fake`), { joinedby: { uid: "student" }, result: 100 }));
    await assertFails(setDoc(doc(db("student"), "Users/student/MyResults/fake"), { result: 100, teacherId: "teacher" }));
    await assertFails(updateDoc(doc(db("student"), "Users/student/MyResults/student-attempt-1"), { result: 100 }));
    await assertSucceeds(setDoc(doc(db("student"), "Users/student/MyResults/practice-1"), { result: 3 }));
  });

  test("students read their own results; teachers read their course results", async () => {
    await assertSucceeds(getDocs(query(collection(db("student"), `${itemPath}/Results`), where("joinedby.uid", "==", "student"))));
    await assertFails(getDocs(query(collection(db("outsider"), `${itemPath}/Results`), where("joinedby.uid", "==", "student"))));
    await assertSucceeds(getDocs(collection(db("teacher"), `${itemPath}/Results`)));
    await assertSucceeds(getDocs(query(collection(db("teacher"), "Users/student/MyResults"), where("courseId", "==", COURSE), where("teacherId", "==", "teacher"))));
    await assertFails(getDocs(query(collection(db("otherTeacher"), "Users/student/MyResults"), where("courseId", "==", COURSE))));
  });

  test("enrollment cannot be faked from the app", async () => {
    await assertFails(setDoc(doc(db("outsider"), `Courses/${COURSE}/Subscribers/outsider`), { id: "outsider" }));
    await assertFails(setDoc(doc(db("outsider"), `Users/outsider/Courses/${COURSE}`), courseData()));
  });

  test("progress markers and notes need access to the course", async () => {
    const joined = { uid: "student", name: "S", joinedDate: new Date() };
    await assertSucceeds(setDoc(doc(db("student"), `${itemPath}/JoinedBy/student`), joined));
    await assertFails(setDoc(doc(db("outsider"), `${itemPath}/JoinedBy/outsider`), { ...joined, uid: "outsider" }));
    await assertFails(setDoc(doc(db("student"), `${itemPath}/JoinedBy/someoneElse`), { ...joined, uid: "someoneElse" }));
    await assertSucceeds(setDoc(doc(db("student"), `${itemPath}/VideoNotes/n1`), { user: { uid: "student" }, note: "hi" }));
    await assertFails(setDoc(doc(db("student"), `${itemPath}/VideoNotes/n2`), { user: { uid: "teacher" }, note: "spoof" }));
  });
});

describe("coupons, reports, money", () => {
  test("coupons are private to the teacher and usage counters are server-only", async () => {
    const ref = doc(db("teacher"), `Courses/${COURSE}/Coupons/SAVE10`);
    await assertFails(getDoc(doc(db("student"), `Courses/${COURSE}/Coupons/SAVE10`)));
    await assertSucceeds(updateDoc(ref, { discountPercentage: 20 }));
    await assertFails(updateDoc(ref, { usedCount: 0 }));
    await assertFails(updateDoc(ref, { discountPercentage: 150 }));
    await assertSucceeds(setDoc(doc(db("teacher"), `Courses/${COURSE}/Coupons/NEW`), { code: "NEW", discountPercentage: 15, usageLimit: 10, usedCount: 0, status: "active" }));
    await assertFails(setDoc(doc(db("teacher"), `Courses/${COURSE}/Coupons/BAD`), { code: "BAD", discountPercentage: 15, usageLimit: 10, usedCount: 9 }));
  });

  test("anyone signed in can report; only the owner updates the status", async () => {
    const report = { reporterId: "outsider", status: "open", resolvedAt: null, description: "broken video", type: "other" };
    await assertSucceeds(setDoc(doc(db("outsider"), `Courses/${COURSE}/Reports/r1`), report));
    await assertFails(setDoc(doc(db("outsider"), `Courses/${COURSE}/Reports/r2`), { ...report, reporterId: "student" }));
    await assertFails(setDoc(doc(db("outsider"), `Courses/${COURSE}/Reports/r3`), { ...report, status: "resolved" }));
    await assertSucceeds(updateDoc(doc(db("teacher"), `Courses/${COURSE}/Reports/r1`), { status: "resolved", resolvedAt: new Date() }));
    await assertFails(updateDoc(doc(db("teacher"), `Courses/${COURSE}/Reports/r1`), { description: "edited" }));
  });

  test("ratings and transactions are server-only", async () => {
    await assertFails(setDoc(doc(db("student"), `Courses/${COURSE}/Feedbacks/student`), { rating: 5 }));
    await assertSucceeds(getDocs(collection(db("outsider"), `Courses/${COURSE}/Feedbacks`)));
    await assertFails(setDoc(doc(db("teacher"), `Courses/${COURSE}/Transactions/t1`), { amount: 1000 }));
    await assertFails(setDoc(doc(db("student"), "Users/student/Transactions/t1"), { amount: 1 }));
    await assertFails(getDoc(doc(db("student"), "Transactions/t1")));
  });
});

describe("review decisions and replies", () => {
  const feedbackPath = `Courses/${COURSE}/Feedbacks/student`;

  async function seedReview() {
    await env.withSecurityRulesDisabled((ctx) =>
      setDoc(doc(ctx.firestore(), feedbackPath), { uid: "student", name: "S", rating: 2, fedBack: "meh", datePosted: new Date() })
    );
  }

  test("a declined course goes back to review as it is, the reason stays staff-only", async () => {
    await env.withSecurityRulesDisabled((ctx) =>
      setDoc(doc(ctx.firestore(), `Courses/${COURSE}`), courseData("Declined", { declineReason: "Poster is blurry", declinedAt: new Date() }))
    );
    const ref = doc(db("teacher"), `Courses/${COURSE}`);
    await assertFails(updateDoc(ref, { declineReason: "" }));
    await assertFails(updateDoc(ref, { state: "Pending", resubmittedAt: new Date(2020, 1, 1) }));
    await assertFails(updateDoc(ref, { state: "Published", resubmittedAt: serverTimestamp() }));
    await assertSucceeds(updateDoc(ref, { state: "Pending", resubmittedAt: serverTimestamp() }));
    await assertSucceeds(updateDoc(doc(db("manager"), `Courses/${COURSE}`), { state: "Declined", declineReason: "Still blurry", declinedAt: serverTimestamp() }));
  });

  test("only declined courses can be resubmitted", async () => {
    await assertFails(updateDoc(doc(db("teacher"), `Courses/${COURSE}`), { state: "Pending", resubmittedAt: serverTimestamp() }));
  });

  test("the course owner adds, edits and removes one reply and nothing else", async () => {
    await seedReview();
    const ref = doc(db("teacher"), feedbackPath);
    const reply = (text) => ({ text, authorId: "teacher", createdAt: serverTimestamp(), updatedAt: serverTimestamp() });
    await assertSucceeds(updateDoc(ref, { teacherReply: reply("Thanks, we fixed the audio.") }));
    const created = (await env.withSecurityRulesDisabled(async (ctx) => (await getDoc(doc(ctx.firestore(), feedbackPath))).data())).teacherReply.createdAt;
    await assertFails(updateDoc(ref, { teacherReply: reply("Edited") }));
    await assertSucceeds(updateDoc(ref, { teacherReply: { text: "Edited", authorId: "teacher", createdAt: created, updatedAt: serverTimestamp() } }));
    await assertFails(updateDoc(ref, { rating: 5 }));
    await assertFails(updateDoc(ref, { teacherReply: { ...reply("x".repeat(1001)), createdAt: created } }));
    await assertFails(updateDoc(ref, { teacherReply: { text: "", authorId: "teacher", createdAt: created, updatedAt: serverTimestamp() } }));
    await assertSucceeds(updateDoc(ref, { teacherReply: deleteField() }));
  });

  test("other teachers, students and removed courses cannot reply", async () => {
    await seedReview();
    const reply = (uid) => ({ teacherReply: { text: "hi", authorId: uid, createdAt: serverTimestamp(), updatedAt: serverTimestamp() } });
    await assertFails(updateDoc(doc(db("otherTeacher"), feedbackPath), reply("otherTeacher")));
    await assertFails(updateDoc(doc(db("student"), feedbackPath), reply("student")));
    await assertFails(updateDoc(doc(db("teacher"), feedbackPath), reply("otherTeacher")));
    await env.withSecurityRulesDisabled((ctx) => setDoc(doc(ctx.firestore(), `Courses/${COURSE}`), courseData("DeletedByAdmin")));
    await assertFails(updateDoc(doc(db("teacher"), feedbackPath), reply("teacher")));
  });

  test("an abusive review can be reported once per person, and only staff see the reports", async () => {
    await seedReview();
    const id = `${COURSE}_student_teacher`;
    const report = { courseId: COURSE, reviewUid: "student", reportedBy: "teacher", reporterRole: "Teacher", reason: "offensive", details: "Insults", status: "open", createdAt: serverTimestamp() };
    await assertFails(setDoc(doc(db("teacher"), `ReviewReports/wrong-id`), report));
    await assertFails(setDoc(doc(db("teacher"), `ReviewReports/${id}`), { ...report, reason: "dislike" }));
    await assertFails(setDoc(doc(db("teacher"), `ReviewReports/${id}`), { ...report, reporterRole: "Admin" }));
    await assertFails(setDoc(doc(db("teacher"), `ReviewReports/${id}`), { ...report, status: "closed" }));
    await assertSucceeds(setDoc(doc(db("teacher"), `ReviewReports/${id}`), report));
    await assertFails(setDoc(doc(db("teacher"), `ReviewReports/${id}`), report));
    await assertSucceeds(getDoc(doc(db("teacher"), `ReviewReports/${id}`)));
    await assertFails(getDoc(doc(db("outsider"), `ReviewReports/${id}`)));
    await assertSucceeds(getDocs(query(collection(db("manager"), "ReviewReports"), where("status", "==", "open"))));
    await assertFails(getDocs(collection(db("teacher"), "ReviewReports")));
    await assertSucceeds(updateDoc(doc(db("manager"), `ReviewReports/${id}`), { status: "dismissed" }));
    await assertFails(setDoc(doc(db("student"), `ReviewReports/${COURSE}_student_student`), { ...report, reportedBy: "student", reporterRole: "Student" }));
    await assertFails(setDoc(doc(db("teacher"), `ReviewReports/${COURSE}_nobody_teacher`), { ...report, reviewUid: "nobody" }));
  });
});

describe("support", () => {
  test("tickets are private to their sender and support staff", async () => {
    await assertSucceeds(getDoc(doc(db("student"), "Tickets/ticket1")));
    await assertFails(getDoc(doc(db("outsider"), "Tickets/ticket1")));
    await assertSucceeds(getDoc(doc(db("support"), "Tickets/ticket1")));
    await assertSucceeds(setDoc(doc(db("student"), "Tickets/ticket1/Messages/m1"), { sender: { uid: "student" }, message: "hi" }));
    await assertFails(setDoc(doc(db("outsider"), "Tickets/ticket1/Messages/m2"), { sender: { uid: "outsider" }, message: "hi" }));
    await assertSucceeds(setDoc(doc(db("support"), "Tickets/ticket1/Messages/m3"), { sender: { uid: "support" }, message: "hello" }));
    await assertFails(setDoc(doc(db("student"), "Tickets/t9"), { id: "t9", sender: { uid: "teacher" } }));
  });

  test("blocked users cannot open tickets or courses", async () => {
    await assertFails(setDoc(doc(db("blocked"), "Tickets/t10"), { id: "t10", sender: { uid: "blocked" } }));
  });
});

describe("fallback", () => {
  test("unknown collections are closed except to staff reads and admin writes", async () => {
    await assertFails(getDoc(doc(db("teacher"), "MuxVideoIndex/x")));
    await assertSucceeds(getDoc(doc(db("support"), "MuxVideoIndex/x")));
    await assertFails(setDoc(doc(db("support"), "Anything/x"), { a: 1 }));
    await assertSucceeds(setDoc(doc(db("admin"), "Anything/x"), { a: 1 }));
    await assertSucceeds(deleteDoc(doc(db("admin"), "Anything/x")));
  });
});
