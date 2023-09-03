library commit_info;

import 'package:build/build.dart';
import 'package:commit_info/src/git_builder.dart';

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

class GetCommitInfo {
  const GetCommitInfo();
}

Builder gitBuilder(BuilderOptions options) => GitBuilder(options);
