enum CourseCounterField {
  lessons('lessonsCount'),
  tests('testsCount'),
  feedbacks('feedBacksCount'),
  students('studentsCount');

  final String key;
  const CourseCounterField(this.key);
}
