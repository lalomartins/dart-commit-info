class CommitInfo {
  final String commitId;
  final String commitIdShort;
  final int timestamp;
  final String? branch;
  final bool localChanges;

  const CommitInfo({
    required this.commitId,
    required this.commitIdShort,
    required this.timestamp,
    required this.branch,
    this.localChanges = false,
  });

  DateTime get dateTime => DateTime.fromMicrosecondsSinceEpoch(timestamp);
}

// ignore: unnecessary_nullable_for_final_variable_declarations
const CommitInfo? commitInfo = CommitInfo(
  commitId: "null",
  commitIdShort: "null",
  timestamp: 0,
  branch: "null",
);
