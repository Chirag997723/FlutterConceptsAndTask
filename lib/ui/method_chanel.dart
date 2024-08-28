import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  
  List<Product2> _products = [];
  final chanel = MethodChannel('myFirstMethodChannel');

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() async {
    List<Product2> products = await fetchProducts();
    setState(() {
      _products = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              sendToAndroid('sendSms');
            },
            label: Text('sendSms'),
            icon: Icon(Icons.sms),
          ),
          Expanded(
            child: _products.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      var product = _products[index];
                      return ListTile(
                        title: Text(product.title!),
                        subtitle: Text('\$${product.price}'),
                        leading: Image.network(
                          product.image!,
                          width: 50,
                          height: 50,
                        ),
                      );
                    },
                  ),
          )
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

Future<List<Product2>> fetchProducts() async {
  final Dio _dio = Dio();
  try {
    Response response = await _dio.get('https://fakestoreapi.com/products');
    var json = response.data as List;
    List<Product2> jsonList = json.map(
      (e) {
        return Product2.fromJson(e as Map<String, dynamic>);
      },
    ).toList();
    return jsonList;
  } catch (e) {
    print('Error fetching products: $e');
    return [];
  }
}

class Product2 {
  int? id;
  String? title;
  num? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  Product2(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rating});

  Product2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating =
        json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['category'] = this.category;
    data['image'] = this.image;
    if (this.rating != null) {
      data['rating'] = this.rating!.toJson();
    }
    return data;
  }
}

class Rating {
  num? rate;
  int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    data['count'] = this.count;
    return data;
  }
}
