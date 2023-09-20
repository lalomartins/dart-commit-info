library commit_info;

class PartialCommitInfo {
  String? commitId;
  String? commitIdShort;
  int? timestamp;
  String? branch;
  bool? localChanges;

  PartialCommitInfo({
    this.commitId,
    this.commitIdShort,
    this.timestamp,
    this.branch,
    this.localChanges,
  });

  @override
  String toString() => """
class CommitInfo {
  final String commitId;
  final String commitIdShort;
  final int? timestamp;
  final String? branch;
  final bool localChanges;

  const CommitInfo({
    required this.commitId,
    required this.commitIdShort,
    required this.timestamp,
    required this.branch,
    this.localChanges = false,
  });

  DateTime? get dateTime => timestamp == null ? null : DateTime.fromMillisecondsSinceEpoch(timestamp!);
}

// ignore: unnecessary_nullable_for_final_variable_declarations
const CommitInfo? commitInfo = CommitInfo(
  commitId: "$commitId",
  commitIdShort: "$commitIdShort",
  timestamp: $timestamp,
  branch: "${branch?.replaceAll('"', r'\"')}",
  localChanges: $localChanges,
);
""";
}
