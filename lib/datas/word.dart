import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert'; // 用于处理 JSON 数据

class Word {
  int id;
  String name;
  String sound;
  String explanation;
  String provenance;
  String emotionalColor;
  String structure;
  String synonyms;
  String antonym;
  String example;
  int collected;
  Word(
      {this.id = -1,
      this.name = "",
      this.sound = "",
      this.explanation = "",
      this.provenance = "",
      this.emotionalColor = "",
      this.structure = "",
      this.synonyms = "",
      this.antonym = "",
      this.example = "",
      this.collected = 0});

  // 从 JSON 转换为 Word 对象
  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['id'] as int,
      name: json['name'] as String,
      sound: json['sound'] as String,
      explanation: json['explanation'] as String,
      provenance: json['provenance'] as String,
      emotionalColor: json['emotional_color'] as String,
      structure: json['structure'] as String,
      synonyms: json['synonyms'] as String,
      antonym: json['antonym'] as String,
      example: json['example'] as String,
      collected:
          (json['collected'] ?? 0) as int, // SQLite 中 `BOOLEAN` 常用 0/1 表示
    );
  }

  // 将 Word 对象转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sound': sound,
      'explanation': explanation,
      'provenance': provenance,
      'emotional_color': emotionalColor,
      'structure': structure,
      'synonyms': synonyms,
      'antonym': antonym,
      'example': example,
      'collected': collected, // SQLite 兼容性处理
    };
  }

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
    late int collected;

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
      collected = response2.body == "true" ? 1 : 0;
    } else {
      print(response2.body);
      data = 'Failed to load data';
    }

    return Word(
        id: id,
        name: name,
        sound: sound,
        explanation: explanation,
        provenance: provenance,
        emotionalColor: emotional_color,
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
    late int collected;

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
      collected = response2.body == "true" ? 1 : 0;
    } else {
      print(response2.body);
      data = 'Failed to load data';
    }

    return Word(
        id: id,
        name: name,
        sound: sound,
        explanation: explanation,
        provenance: provenance,
        emotionalColor: emotional_color,
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

final Word DEFAULTWORD = Word(
    id: -1,
    name: "空空如也",
    sound: "成语发音：kōng kōng rú yě",
    explanation: "成语解释：（空空如：虚心的样子）形容一无所知，也用来形容一无所有。",
    provenance: "成语出处：春秋·孔子《论语·子罕》：“有鄙夫问于我，空空如也，我叩其两端而竭焉。”",
    emotionalColor: "感情色彩：中性成语",
    structure: "成语结构：单纯式成语",
    synonyms: "近义词：空洞无物",
    antonym: "",
    example: "成语例句：明·冯梦龙《东周列国志》六六回：“比入由堂，直望内室，窗户门闼，空空如也”",
    collected: 0);
