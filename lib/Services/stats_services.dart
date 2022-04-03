import 'dart:convert';

import 'package:covid_tracker/Models/world_stats_model.dart';
import 'package:covid_tracker/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatsServices {
  Future<WorldStatsModel> fetchWorldStats() async {
    final response = await http.get(
      Uri.parse(AppUrl.worldStatesApi),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> fetchCountriesStats() async {
    final response = await http.get(
      Uri.parse(AppUrl.countriesList),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Error");
    }
  }
}
