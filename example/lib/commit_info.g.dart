// Dummy CommitInfo file which you can commit with your source code, so that your editor
// won't complain about missing files or declarations
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

const CommitInfo? commitInfo = null;
