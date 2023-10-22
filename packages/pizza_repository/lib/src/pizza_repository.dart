import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'models/pizza_set.dart';


abstract class IPizzaRepository {
  Future<PizzaListModel> readPizzaList();

  Future<void> writePizzaList(PizzaListModel pizzaList);
}

class PizzaFromLocalJsonFileRepository extends IPizzaRepository {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/pizza_list.json');
  }

  Future<void> createLocalJsonOnDevice() async {
    final file = File("${await _localPath}/pizza_list.json").create(recursive: true);
    var content = await rootBundle.loadString('assets/json/pizza_list.json');
    debugPrint("Content in root bundle: $content");
    final writer = await file;
    writer.writeAsString(content.toString());
  }

  @override
  Future<PizzaListModel> readPizzaList() async {
    var file = await _localFile;
    final bool existFile = await file.exists();
    if (!existFile) {
      await createLocalJsonOnDevice();
      file = await _localFile;
      return read(file);
    } else {
      return read(file);
    }
  }

  Future<PizzaListModel> read(File file) async {
    final content = file.readAsStringSync();
    var jsonResponse = jsonDecode(content);
    PizzaListModel pizzaList = PizzaListModel.fromJson(jsonResponse);
    return pizzaList;
  }

  @override
  Future<void> writePizzaList(PizzaListModel pizzaList) async {
    setJsonContent('');
    setJsonContent(jsonEncode(pizzaList));
  }

  Future<void> setJsonContent(String content) async {
    File file = await _localFile;
    file.writeAsStringSync(content);
  }
}