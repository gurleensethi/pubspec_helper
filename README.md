# pubspec_helper

A command line utiltiy written in Dart.

# Installation/Setup

Go to the [release section](https://github.com/gurleensethi/pubspec_helper/releases) and download the latest `pubspec_helper.dart.aot` file.

(Optional: Place it into the root of your project).

#### `pubspec_helper` requires `dartaotruntime` command line tool to run properly, so make sure to install `Dart` command line tools.

# Features

## Update Checker

Check which of your dependencies needs update and to get its latest version.

Run the following command:
```shell
dartaotruntime pubspec_helper.dart.aot update -f pubspec.yaml
```