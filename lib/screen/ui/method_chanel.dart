import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_practice_app/models/productModel.dart';

class ProductsPage extends StatelessWidget {
  final chanel = const MethodChannel('myFirstMethodChannel');

  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              sendToAndroid('sendSms');
            },
            label: const Text('sendSms'),
            icon: const Icon(Icons.sms),
          ),
          Expanded(
              child: FutureBuilder<List<ProductModel>>(
            future: fetchProductData2(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return ListTile(
                      title: Text(item.id.toString()),
                      subtitle: Text(item.title!),
                      leading: Text('\$${item.price}'),
                    );
                  },
                  itemCount: snapshot.data!.length,
                );
              }
            },
          ))
        ],
      ),
    );
  }

  Future<void> sendToAndroid(String name) async {
    try {
      final states = await chanel.invokeMethod('sendString', {"sendSms": name});
      print('android--> $states');
    } on Exception catch (e) {
      print(e);
    }
  }
}

Future<List<ProductModel>> fetchProductData2() async {
  final dio = Dio();
  var response = await dio.get('https://fakestoreapi.com/products');
  if (response.statusCode == 200) {
    final list = response.data as List;
    List<ProductModel> dataList = list.map(
      (e) {
        return ProductModel.fromJson(e as Map<String, dynamic>);
      },
    ).toList();
    return dataList;
  } else {
    throw Exception('network error');
  }
}
