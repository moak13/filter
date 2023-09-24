import 'package:filter/data_model/country_state.dart';

class StatesResponse {
  List<CountryState>? states;

  StatesResponse({this.states});

  StatesResponse.fromJson(Map<String, dynamic> json) {
    if (json['states'] != null) {
      states = <CountryState>[];
      json['states'].forEach((v) {
        states!.add(CountryState.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (states != null) {
      data['states'] = states!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
