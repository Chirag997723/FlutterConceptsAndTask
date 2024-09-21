
import 'package:dio/dio.dart';
import 'package:flutter_practice_app/models/model.dart';
import 'package:flutter_practice_app/models/productModel.dart';
import 'package:fluttertoast/fluttertoast.dart';

final dio = Dio();

Future<CountryResponse?> getResponse() async {
  try {
    var response = await dio.get('https://api.first.org/data/v1/countries');
    if (response.statusCode == 200) {
      var countryResponse = CountryResponse.fromJson(response.data);
      return countryResponse;
    } else {
      Fluttertoast.showToast(msg: 'falid to load data');
    }
  } catch (e) {
    print('Apicall $e');
  }
  return null;
}

Future<List<dynamic>?> getSecondApi() async {
  try {
    var response =
        await dio.get('https://api.sampleapis.com/countries/countries');
    if (response.statusCode == 200) {
      List<dynamic> countries = response.data;
      print('001--> $countries');
      return countries;
    } else {
      Fluttertoast.showToast(msg: 'faild to load api');
    }
  } catch (e) {
    print('Apicall $e');
  }
  return null;
}

Future<List<dynamic>> fetchUserData() async {
  var response = await dio.get('https://jsonplaceholder.typicode.com/users');
  if (response.statusCode == 200) {
    return response.data;
  } else {
    throw Exception('network error');
  }
}

Future<List<ProductModel>?> fetchProductData() async {
  var response = await dio.get('https://fakestoreapi.com/products');
  if (response.statusCode == 200) {
    print('...3--> ${response.data}');
    List<ProductModel> json = [];
    for (var i = 0; i < response.data.length; i++) {
      json.add(ProductModel.fromJson(response.data[i]));
    }
    return json;
  } else {
    throw Exception('network error');
  }
}

Future<List<PostsModel>?> fetchPostData() async {
  var response = await dio.get('https://jsonplaceholder.typicode.com/posts');
  if (response.statusCode == 200) {
    final body = response.data as List;

    List<PostsModel> list = body.map(
      (e) {
        return PostsModel.fromJson(e as Map<String, dynamic>);
      },
    ).toList();
    return list;
    // return body.map((e) {
    //   return PostsModel(
    //     userId: e['userId'] as int,
    //     id: e['id'] as int,
    //     title: e['title'] as String,
    //     body: e['body'] as String,
    //   );
    // },).toList();
  } else {
    throw Exception('network error');
  }
}

Future<ApiModel1?> parameterizedApi() async {
  var response = await dio.get('https://reqres.in/api/users', queryParameters: {
    "page": 2,
  });

  if (response.statusCode == 200) {
    var apiModel = ApiModel1.fromJson(response.data);
    return apiModel;
  } else {
    throw Exception('network error');
  }
}

Future<String> parameterizedApi2(String email, String password) async {
  var response = await dio.post('https://reqres.in/api/login', data: {
    'email': email,
    'password': password,
  });

  if (response.statusCode == 200) {
    return response.data['token'];
  } else {
    throw Exception('Failed to login: ${response.statusCode}');
  }
}

Future<List<dynamic>?> getTrendingNews() async {
  String baseURL =
      "https://newsdata.io/api/1/news?apikey=pub_5079603df267718f378922ef3056b19fc1e72&q=api%20key";
  try {
    var response = await dio.get(baseURL);
    if (response.statusCode == 200) {
      var body = response.data;
      var articles = body['results'];
      return articles;
    } else {
      print("Something went wrong in Trending news");
    }
  } catch (e) {
    print("Error: $e");
  }
  return null;
}
