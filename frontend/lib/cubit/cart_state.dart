part of 'cart_cubit.dart';

abstract class CartState {
  const CartState();
}

final class CartInit extends CartState {
  const CartInit();
}

final class CartList extends CartState {
  final List<CartModel> items;
  final double fullPirce;

  const CartList(
    this.items,
    this.fullPirce,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartList &&
        other.items == items &&
        other.fullPirce == fullPirce;
  }

  @override
  int get hashCode => Object.hash(
        items,
        fullPirce,
      );
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
