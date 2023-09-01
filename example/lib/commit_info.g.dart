class CommitInfo {
  final String commitId;
  final String commitIdShort;
  final DateTime timestamp;
  final String? branch;
  final bool localChanges;

  CommitInfo(
      {required this.commitId,
      required this.commitIdShort,
      required this.timestamp,
      required this.branch,
      this.localChanges = false});
}

final commitInfo = CommitInfo(
  commitId: "commitId",
  commitIdShort: "commit",
  timestamp: DateTime(2023, 09, 01, 23, 30),
  branch: "main",
);
