import 'dart:async';

import 'package:build/build.dart';
import 'package:commit_info/src/commit_info.dart';
import 'package:path/path.dart' as p;

class GitBuilder implements Builder {
  final BuilderOptions options;

  GitBuilder(this.options);

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    print("reading git commit info for ${buildStep.inputId.path}");

    final assetId = AssetId(buildStep.inputId.package, p.join("lib", "commit_info.g.dart"));
    final info = PartialCommitInfo();
    await buildStep.writeAsString(assetId, info.toString());
  }

  @override
  final buildExtensions = const {
    r'$lib$': ['commit_info.g.dart']
  };
}
