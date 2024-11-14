part of 'shop_cubit.dart';

abstract class ShopState {
  const ShopState();
}

final class ShopInit extends ShopState {
  const ShopInit();
}

final class Loading extends ShopState {
  const Loading();
}

final class MainList extends ShopState {
  final List<ProductModel> shopList;

  const MainList(
    this.shopList,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MainList && other.shopList == shopList;
  }

  @override
  int get hashCode => shopList.hashCode;
}

final class MoveToDetailScreen extends ShopState {
  final ProductModel product;
  final List<ProductModel> list;
  const MoveToDetailScreen(this.product,this.list);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MoveToDetailScreen && other.product == product && other.list == list;
  }

  @override
  int get hashCode => Object.hash(
        product,
        list,
      );
}
