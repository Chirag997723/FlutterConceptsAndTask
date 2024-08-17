import 'package:flutter_practice_app/old_file/model.dart';
import 'package:flutter_practice_app/old_file/mvc_ex/api_repository.dart';
import 'package:flutter_practice_app/old_file/state_management/productModel.dart';
import 'package:get/get.dart';

class MyController extends GetxController {
var cartItems = <CartItem>[].obs;

  void addToCart(Product product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      cartItems[index].quantity++;
      cartItems.refresh();
    } else {
      cartItems.add(CartItem(product: product));
    }
  }

  void removeFromCart(Product product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
        cartItems.refresh();
      } else {
        cartItems.removeAt(index);
      }
    }
  }

  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.product.price * item.quantity);



  var counter = 0;
  var item = 0.obs;

  increment() {
    counter++;
    update();
  }


  var isLoading = true.obs;
  var productList = <ProductModel>[].obs;

  fetchProduct() async {
    try {
      isLoading(true);

      await fetchProductData().then((val) {
        if (val != null) {
          productList.value = val;
        }
      });
    } catch (e) {
      print('error fetching user data $e');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    fetchProduct();
    super.onInit();
  }

  @override
  void onClose() {
    print('called onClose');
    super.onClose();
  }
}
