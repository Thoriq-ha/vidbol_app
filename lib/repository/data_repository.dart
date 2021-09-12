import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vidbol_app/models/footbal_data.dart';

class DataRepository {
  Future<List<FootballData>> fetchData() async {
    final String url = "https://www.scorebat.com/video-api/v3/";
    List<FootballData> footballData = [];
    try {
      await http.get(Uri.parse(url)).then((response) {
        var it = jsonDecode(response.body)['response'];
        footballData =
            it.map<FootballData>((e) => FootballData.fromJson(e)).toList();
      });
      return footballData;
    } catch (e) {
      print(e);
    }
    return [];
  }
}
