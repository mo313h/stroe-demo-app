import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_demo/src/features/home/data/models/product_model.dart';

import '../../../../core/dio/dio_helper.dart';
import '../../../../core/dio/end_points.dart';

final homeRepoProvider = Provider((ref) => HomeRepo(ref: ref));

class HomeRepo {
  final Ref ref;
  HomeRepo({required this.ref});
  Future<List<ProductModel>> getProducts({int limit = 10, int skip = 0}) async {
    try {
      final res = await ref
          .read(dioHelperProvider)
          .getData(
            url: EndPoints.products,
            query: {'limit': limit, 'skip': skip},
          );

      final List<dynamic> data = res.data['products'];
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
