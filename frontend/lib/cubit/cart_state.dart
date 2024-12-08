part of 'cart_cubit.dart';

abstract class CartState {
  const CartState();
}

final class CartInit extends CartState {
  const CartInit();
}

final class CartList extends CartState {
  final List<CartModel> items;
  //dodac full price

  const CartList(
    this.items,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartList && other.items == items;
  }

  @override
  int get hashCode => items.hashCode;
}

final class CartMap extends CartState {
  final Set<Marker> markers;

  const CartMap(
    this.markers,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartMap && other.markers == markers;
  }

  @override
  int get hashCode => markers.hashCode;
}
