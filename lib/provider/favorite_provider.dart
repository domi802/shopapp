import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopapp/models/favorite_models.dart';

final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, Map<String, FavoriteModel>>(
  (ref) {
    return FavoriteNotifier();
  },
);

class FavoriteNotifier extends StateNotifier<Map<String, FavoriteModel>> {
  FavoriteNotifier() : super({});

  void addProductToFavorite({
    required String productName,
    required String productId,
    required List imageUrl,
    required double productPrice,
  }) {
    state[productId] = FavoriteModel(
      productName: productName,
      productId: productId,
      imageUrl: imageUrl,
      productPrice: productPrice,
    );
    // notify that state has changed
    state = {...state};
  }

  // remove all from fav

  void removeAllItem() {
    state.clear();

    /// notify that state has changed
    state = {...state};
  }

  // remove item from fav
  void removeItem(String productId) {
    state.remove(productId);
    state = {...state};
  }

  // retrive value from the state obj

  Map<String, FavoriteModel> get getFavoriteItem => state;
}
