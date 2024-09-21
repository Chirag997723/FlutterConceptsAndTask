import 'package:flutter/material.dart';
import 'package:flutter_practice_app/models/model.dart';
import 'package:flutter_practice_app/provider/theme_provider.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_practice_app/state_management/myController.dart';
// import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final double productPrice;
  final String productImage;
  final int index;

  // var cartController = Get.put(MyController());

  ProductCard({
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<ThemeProvider>(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            child: Image.network(
              productImage,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              maxLines: 1,
              productName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '\$' + productPrice.toString(),
                  style: TextStyle(color: Colors.green),
                ),
              ),
              IconButton(
                icon: Icon(Icons.shopping_cart_checkout),
                onPressed: () {
                  cartProvider.addToCart(Product(
                      imgLink: productImage,
                      id: index,
                      name: productName,
                      price: productPrice));
                  // cartController.addToCart(Product(
                  //     imgLink: productImage,
                  //     id: index,
                  //     name: productName,
                  //     price: productPrice));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
