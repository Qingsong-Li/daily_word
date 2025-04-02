import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert'; // 用于处理 JSON 数据

class Word {
  late int id;
  late String name;
  late String sound;
  late String explanation;
  late String provenance;
  // ignore: non_constant_identifier_names
  late String emotional_color;
  late String structure;
  late String synonyms;
  late String antonym;
  late String example;
  late bool collected;
  Word._(
      {required this.id,
      required this.name,
      required this.sound,
      required this.explanation,
      required this.provenance,
      required this.emotional_color,
      required this.structure,
      required this.synonyms,
      required this.antonym,
      required this.example,
      required this.collected});

  Word.empty() : name = "";

  static Future<Word> getRandom(String token) async {
    late int id;
    late String name;
    late String sound;
    late String explanation;
    late String provenance;
    // ignore: non_constant_identifier_names
    late String emotional_color;
    late String structure;
    late String synonyms;
    late String antonym;
    late String example;
    late bool collected;

    var data;
    token = token.replaceAll('"', ''); // 去掉双引号
    String Authorization = 'Bearer $token';
    final response1 = await http.get(
        Uri.parse("http://118.178.254.29:8888/idiom/getRandom"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": Authorization
        });
    if (response1.statusCode == 200) {
      final jsonResponse = json.decode(response1.body);
      data = jsonResponse;
      // print(jsonResponse);
      id = data["id"] ?? "";
      name = data["name"] ?? "";
      sound = data["sound"] ?? "";
      explanation = data["explanation"] ?? "";
      provenance = data["provenance"] ?? "";
      emotional_color = data["emotional_color"] ?? "";
      structure = data["structure"] ?? "";
      synonyms = data["synonyms"] ?? "";
      antonym = data["antonym"] ?? "";
      example = data["example"] ?? "";
    } else {
      print(response1.body);
      data = 'Failed to load data';
    }

    final response2 = await http.get(
        Uri.parse("http://118.178.254.29:8888/collect/check?idiomId=${id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": Authorization
        });
    if (response1.statusCode == 200) {
      collected = response2.body == "true" ? true : false;
    } else {
      print(response2.body);
      data = 'Failed to load data';
    }

    return Word._(
        id: id,
        name: name,
        sound: sound,
        explanation: explanation,
        provenance: provenance,
        emotional_color: emotional_color,
        structure: structure,
        synonyms: synonyms,
        antonym: antonym,
        example: example,
        collected: collected);
  }

  static Future<Word> getById(String token, int Id) async {
    late int id;
    late String name;
    late String sound;
    late String explanation;
    late String provenance;
    // ignore: non_constant_identifier_names
    late String emotional_color;
    late String structure;
    late String synonyms;
    late String antonym;
    late String example;
    late bool collected;

    var data;
    token = token.replaceAll('"', ''); // 去掉双引号
    String Authorization = 'Bearer $token';
    final response1 = await http.get(
        Uri.parse("http://118.178.254.29:8888/idiom/getByid?idiomId=$Id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": Authorization
        });
    if (response1.statusCode == 200) {
      final jsonResponse = json.decode(response1.body);
      data = jsonResponse;
      id = data["id"] ?? "";
      name = data["name"] ?? "";
      sound = data["sound"] ?? "";
      explanation = data["explanation"] ?? "";
      provenance = data["provenance"] ?? "";
      emotional_color = data["emotional_color"] ?? "";
      structure = data["structure"] ?? "";
      synonyms = data["synonyms"] ?? "";
      antonym = data["antonym"] ?? "";
      example = data["example"] ?? "";
    } else {
      data = 'Failed to load data';
    }

    final response2 = await http.get(
        Uri.parse("http://118.178.254.29:8888/collect/check?idiomId=${id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": Authorization
        });
    if (response1.statusCode == 200) {
      collected = response2.body == "true" ? true : false;
    } else {
      print(response2.body);
      data = 'Failed to load data';
    }

    return Word._(
        id: id,
        name: name,
        sound: sound,
        explanation: explanation,
        provenance: provenance,
        emotional_color: emotional_color,
        structure: structure,
        synonyms: synonyms,
        antonym: antonym,
        example: example,
        collected: collected);
  }

  static Future<bool> shouCang(Word word, String token) async {
    token = token.replaceAll('"', ''); // 去掉双引号
    String Authorization = 'Bearer $token';

    final response = await http.post(
        Uri.parse("http://118.178.254.29:8888/collect/get?idiomId=${word.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": Authorization
        });
    if (response.statusCode == 200) {
      // ignore: unused_local_variable
      final jsonResponse = json.decode(response.body);
      return true;
    } else {
      print("collect error:" + response.body);
      return false;
    }
  }

  static Future<bool> cancelShouCang(Word word, String token) async {
    token = token.replaceAll('"', ''); // 去掉双引号
    String Authorization = 'Bearer $token';
    final response = await http.delete(
        Uri.parse(
            "http://118.178.254.29:8888/collect/delete?idiomId=${word.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": Authorization
        });
    if (response.statusCode == 200) {
      // ignore: unused_local_variable
      final jsonResponse = json.decode(response.body);
      
      return true;
    } else {
      print("cancel collect error:" + response.body);
      return false;
    }
  }

  static Future<List<Word>> searchByWord(String word, String token) async {
    List<Word> result = [];

    late int id;

    token = token.replaceAll('"', ''); // 去掉双引号
    String Authorization = 'Bearer $token';
    print("搜索$word的结果：");
    final response = await http.get(
        Uri.parse('http://118.178.254.29:8888/idiom/getByword?word=${word}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": Authorization
        });
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      for (var data in jsonResponse) {
        
        print(jsonResponse);
        // 获取每个元素中的属性值
        id = data["id"] ?? "";
        Word word = await getById(token, id);
        result.add(word);
      }
    } else {
      print("Search error:" + response.body);
    }
    return result;
  }

  static Future<List<Word>> getCollectedWords(String token) async {
    List<Word> collectedWords = [];
    token = token.replaceAll('"', ''); // 去掉双引号
    String Authorization = 'Bearer $token';

    final response = await http.get(
        Uri.parse('http://118.178.254.29:8888/collect/show'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": Authorization
        });

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse == null) {
        return collectedWords;
      }
      // print("收藏的成语:");
      // print(jsonResponse);
      for (var data in jsonResponse) {
        int id;
        // 获取每个元素中的属性值
        id = data["Id"];
        Word word = await getById(token, id);
        collectedWords.add(word);
      }
    } else {
      print("Search error:" + response.body);
    }
    return collectedWords;
  }

  static Future<bool> checkCollectdById(int id, String token) async {
    bool result = false;
    token = token.replaceAll('"', ''); // 去掉双引号
    String Authorization = 'Bearer $token';
    final response = await http.get(
        Uri.parse("http://118.178.254.29:8888/collect/check?idiomId=${id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": Authorization
        });
    if (response.statusCode == 200) {
      result = response.body == "true" ? true : false;
    } else {
      print("checkCollected Error:" + response.body);
    }
    return result;
  }
}
