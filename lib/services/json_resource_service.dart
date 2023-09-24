import 'dart:convert';

import 'package:filter/data_model/country_state.dart';
import 'package:filter/data_model/states_response.dart';
import 'package:flutter/services.dart';

class JsonResourceService {
  Future<List<CountryState>?> loadStatesFromAsset() async {
    try {
      String jsonString = await rootBundle.loadString("assets/states.json");
      final json = jsonDecode(jsonString);
      final StatesResponse statesResponse = StatesResponse.fromJson(json);
      return statesResponse.states;
    } catch (e) {
      return null;
    }
  }
}
