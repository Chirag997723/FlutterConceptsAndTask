import 'package:flutter/material.dart';
import 'package:flutter_practice_app/models/model.dart';
import 'package:flutter_practice_app/provider/theme_provider.dart';
// import 'package:flutter_practice_app/state_management/myController.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  // var cartController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'CartScreen',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Consumer<ThemeProvider>(
              builder: (context, value, child) {
                return Text(
                  double.parse((value.totalPrice).toStringAsFixed(2))
                      .toString(),
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          )
        ],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
          child: cartController.cartItems.isEmpty
              ? Center(child: Text('Data Not found!'))
              : ListView.builder(
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(cartController.cartItems[index].product.name),
                      subtitle: Row(
                        children: [
                          IconButton(
                              onPressed: () => cartController.addToCart(Product(
                                  id: cartController
                                      .cartItems[index].product.id,
                                  name: cartController
                                      .cartItems[index].product.name,
                                  imgLink: cartController
                                      .cartItems[index].product.imgLink,
                                  price: cartController
                                      .cartItems[index].product.price)),
                              icon: Icon(Icons.add)),
                          Text(cartController.cartItems[index].quantity
                              .toString()),
                          IconButton(
                              onPressed: () => cartController.removeFromCart(
                                  Product(
                                      id: cartController
                                          .cartItems[index].product.id,
                                      name: cartController
                                          .cartItems[index].product.name,
                                      imgLink: cartController
                                          .cartItems[index].product.imgLink,
                                      price: cartController
                                          .cartItems[index].product.price)),
                              icon: Icon(Icons.remove)),
                        ],
                      ),
                      leading: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 44,
                          minHeight: 44,
                          maxWidth: 64,
                          maxHeight: 64,
                        ),
                        child: Image.network(
                            cartController.cartItems[index].product.imgLink,
                            fit: BoxFit.fill),
                      ),
                    );
                  },
                )),
    );
  }
}
