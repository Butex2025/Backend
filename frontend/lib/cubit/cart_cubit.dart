import 'package:bloc/bloc.dart';
import 'package:frontend/data/model/cart.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartInit()) 
}

Future<void> loadCart() {}

Future<void> addToCart(CartModel item) {}

Future<void> removeFromCart(CartModel item) {}

Future<void> clearCart() {}

Future<void> sendCart() {}

Future<void> editItem(CartModel item) {}
