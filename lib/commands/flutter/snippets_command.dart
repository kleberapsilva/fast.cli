//Copyright 2020 Pedro Bissonho
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.

import 'package:fast/core/home_path.dart';
import 'package:flunt_dart/flunt_dart.dart';
import '../../config_storage.dart';
import '../../snippet_manager.dart';
import '../../yaml_manager.dart';
import '../command_base.dart';

class SnippetsCommand extends CommandBase {
  @override
  String get description => 'Create Visual Studio Code Snippets';

  @override
  String get name => 'snip';

  SnippetsCommand();

  @override
  Future<void> run() async {
    validate(Contract('', ''));
    var config = await ConfigStorage().getConfig();
    var templates = await YamlManager.loadTemplates(config.templatesPath);

    final globalSnippetsPath =
        '${homePath()}/.config/Code/User/snippets/created.code-snippets';
    await SnippetGenerator(
            templates.where((template) => template.hasSnippets()).toList(),
            config,
            globalSnippetsPath)
        .generateSnippedFile();
  }
}