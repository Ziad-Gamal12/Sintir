part of 'teacher_workspace_insights_cubit.dart';

class TeacherWorkspaceInsightsState {
  const TeacherWorkspaceInsightsState({
    this.status = WorkspaceLoadStatus.initial,
    this.summary,
    this.errorMessage,
  });

  final WorkspaceLoadStatus status;
  final TeacherWorkspaceSummary? summary;
  final String? errorMessage;

  int openReportsFor(String courseId) =>
      summary?.openReportsFor(courseId) ?? 0;
}
