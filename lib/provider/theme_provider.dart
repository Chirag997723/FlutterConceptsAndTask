import 'package:flutter/material.dart';
import 'package:flutter_practice_app/models/model.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode == ThemeMode.light
        ? _themeMode = ThemeMode.dark
        : _themeMode = ThemeMode.light;

    notifyListeners();
  }

  Color _color = Colors.blue;

  Color get color => _color;

  void setColor(Color color) {
    _color = color;
    notifyListeners();
  }

  List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;

  void addToCart(Product product) {
    final index =
        _cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      _cartItems[index].quantity++;
      
    } else {
      _cartItems.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    final index =
        _cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
        notifyListeners();
      } else {
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  double get totalPrice => _cartItems.fold(
      0, (sum, item) => sum + item.product.price * item.quantity);
}
