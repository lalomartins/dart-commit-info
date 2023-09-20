import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:build/build.dart';
import 'package:commit_info/src/commit_info.dart';
import 'package:path/path.dart' as p;

const branchPrefix = "HEAD -> ".length;

class GitBuilder implements Builder {
  final BuilderOptions options;

  GitBuilder(this.options);

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final info = PartialCommitInfo();

    try {
      final commitRes = ((await Process.run("git", ["show", "--format=%H%n%h%n%at%n%D", "-s", "--no-show-signature"],
                  stdoutEncoding: utf8))
              .stdout as String)
          .trimRight()
          .split("\n");
      info.commitId = commitRes[0];
      info.commitIdShort = commitRes[1];
      info.timestamp = (int.tryParse(commitRes[2]) ?? 0) * 1000;
      info.branch = commitRes[3].substring(branchPrefix);
    } catch (e) {
      // TODO(lalomartins): report errors
    }

    try {
      final statusRes =
          ((await Process.run("git", ["status", "--porcelain"], stdoutEncoding: utf8)).stdout as String).trimRight();
      info.localChanges = statusRes.length > 0;
    } catch (e) {
      // TODO(lalomartins): report errors
    }

    final assetId = AssetId(buildStep.inputId.package, p.join("lib", "commit_info.g.dart"));
    await buildStep.writeAsString(assetId, info.toString());
  }

  @override
  final buildExtensions = const {
    r'$lib$': ['commit_info.g.dart']
  };
}
