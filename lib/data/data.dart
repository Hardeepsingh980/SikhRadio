import 'package:shared_preferences/shared_preferences.dart';
import 'package:sikh_radio/data/model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

loadJson(String filepath) async {
  String data = await rootBundle.loadString(filepath);
  var jsonResult = json.decode(data);
  return jsonResult;
}

class DataApi {
  List<RadioObject> radioList;
  List<RadioObject> gRadioList;

  Future<List<RadioObject>> getRadioList() async {
    if (radioList == null) {
      var jsonData = await loadJson('assets/radio1.json');
      radioList = jsonData
          .map<RadioObject>((json) => RadioObject.fromJson(json))
          .toList();
    }
    return radioList;
  }

  Future<List<RadioObject>> getGRadioList() async {
    if (gRadioList == null) {
      var jsonData = await loadJson('assets/radio2.json');
      gRadioList = jsonData
          .map<RadioObject>((json) => RadioObject.fromJson(json))
          .toList();
    }
    return gRadioList;
  }

  Future<RadioObject> getInitialRadio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString('history') ?? null;

    if (data == null) {
      return RadioObject.fromJson({
        "name": "Sri Harimandir Sahib ",
        "description": "Amritsar, Punjab, India",
        "img":
            "https://www.sikhnet.com/files/styles/radio-channel-thumb/public/radio/images/channels/radio-icon-9-large.jpg?itok=tU1VYI2S",
        "url": "https://radio.sikhnet.com/accounts/channel9/live"
      });
    }
    var jsonData = jsonDecode(data.toString());
    RadioObject radio = RadioObject.fromJson(jsonData);

    return radio;
  }

  Future<RadioObject> addHistory(RadioObject radio) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('history', jsonEncode(radio.toJson()));
    return radio;
  }
}
