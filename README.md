# commit_info

Safely get version control information in a Dart project.

## Features

Sometimes, especially in prototype or development phases, you need your app to
include information about the exact commit it was built from. But due to how
the Flutter build system works, that can be challenging, possibly even get a
little hacky.

Enter `commit_info`. This little codegen will create a file
`commit_info.g.dart` in your cache, in this format:

```dart
class CommitInfo {
  final String commitId;
  final String commitIdShort;
  final int? timestamp;
  final String? branch;
  final bool? localChanges;

  const CommitInfo({
    required this.commitId,
    required this.commitIdShort,
    required this.timestamp,
    required this.branch,
    this.localChanges = false,
  });

  DateTime? get dateTime => timestamp == null ? null : DateTime.fromMicrosecondsSinceEpoch(timestamp!);
}

const CommitInfo? commitInfo = CommitInfo(
  commitId: "2685ecba8f68feae8f42acb3bc001e73a9290cc5",
  commitIdShort: "2685ecb",
  timestamp: 1693745311,
  branch: "main",
  localChanges: true,
);
```

You can find a (barely) more involved example in the `example` folder in this
library's git repository.

It currently supports git only, but it's designed to be agnostic, and support
for other VC systems should be easy to add.

Of course, it has no Flutter dependencies, so you can also use it in any Dart
projects. In fact, if you build your project with `build`, it should be even
more useful, as it will integrate seamlessly.

## Getting started

`flutter pub add dev:commit_info`

The only real prerequisite is, the command line tools for the VC system you
want to use have to be available in any environment where you want to run this
(including CI).

If you _don't_ want to run it in CI though, just run this:

`dart run commit_info:initialize`

This will create a `commit_info.g.dart` in your _source_ tree (not cache) with
a `null` CommitInfo. You can then commit this to VC, and the app will build
fine without the `commit_info` step, including on CI. Just be careful that if
it gets deleted by the build system, you revert the deletion before committing.
Yeah I know, bothersome, but I don't know how to avoid it.

## Usage

To consume the commit info, just import it and use the `commitInfo` const.

```dart
import 'commit_info.g.dart';

class CommitInfoWidget extends StatelessWidget {
  const CommitInfoWidget({super.key});

  @override
  Widget build(BuildContext context) => Text((commitInfo == null)
      ? "unknown"
      : "commit ${commitInfo!.commitIdShort} on ${commitInfo!.branch}, from ${commitInfo!.timestamp}${commitInfo!.localChanges ? " (with local changes)" : ""}");
}
```

Unfortunately, since [the Flutter build tool is not
extensible](https://github.com/flutter/flutter/issues/25377) as of this
writing, you need to run the builder yourself before building your app. Do it
with this command line:

`dart run build_runner build`

On CI, just add that before your `flutter build` step. On development, there's
no need to run it for each build; it should be sufficient to do it once per
coding session, or if you want the info to be accurate, once per commit. If you
prefer to run Flutter from your editor or IDE, you can add an action to run it
for you.
