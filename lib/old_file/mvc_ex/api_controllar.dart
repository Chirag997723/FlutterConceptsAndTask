import 'package:flutter_practice_app/old_file/model.dart';
import 'package:flutter_practice_app/old_file/mvc_ex/api_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ApiControllar extends ControllerMVC {
  CountryResponse countryResponse = CountryResponse();
  Map<String, Country> country = {};
  List<dynamic> countries = [];

  List<dynamic> newsModel = [];

  Future<void> getCountryList() async {
    try {
      getResponse().then(
        (value) {
          if (value != null) {
            setState(
              () {
                countryResponse = value;
                country = value.countries!;
              },
            );
          } else {
            Fluttertoast.showToast(msg: 'list faild');
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>?> getCountriesList() async {
    try {
      getSecondApi().then(
        (value) {
          if (value != null) {
            setState(
              () {
                countries = value;
              },
            );
            print('002--> $countries');
            return countries;
          } else {
            Fluttertoast.showToast(msg: 'list faild');
          }
        },
      );
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> getNewsList() async {
    try {
      getTrendingNews().then(
        (value) {
          if (value != null) {
            setState(
              () {
                newsModel = value;
              },
            );
          } else {
            Fluttertoast.showToast(msg: 'list faild');
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
