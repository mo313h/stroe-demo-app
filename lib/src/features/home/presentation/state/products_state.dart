import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/product_model.dart';
import '../../data/repositories/home_repo.dart';

part 'products_state.g.dart';

@Riverpod(keepAlive: true)
class ProductsState extends _$ProductsState {
  int currentPage = 0;
  final int limit = 10;
  bool hasMore = true;

  List<ProductModel> products = [];

  @override
  FutureOr<List<ProductModel>> build() async {
    return fetchProducts();
  }

  Future<List<ProductModel>> fetchProducts({bool loadMore = false}) async {
    if (!hasMore && loadMore) return products;

    if (!loadMore) {
      currentPage = 0;
      hasMore = true;
      products = [];
    }

    try {
      final skip = currentPage * limit;

      final newProducts = await ref
          .read(homeRepoProvider)
          .getProducts(limit: limit, skip: skip);

      products.addAll(newProducts);

      if (newProducts.length < limit) {
        hasMore = false;
      } else {
        currentPage++;
      }

      state = AsyncData(products);

      return products;
    } catch (e, st) {
      state = AsyncError(e, st);
      return products;
    }
  }

  Future<void> refresh() async {
    currentPage = 0;
    hasMore = true;
    products = [];
    await fetchProducts();
  }

  Future<void> reset() async {
    currentPage = 0;
    hasMore = true;
    products = [];
    state = const AsyncData([]);
  }
}
