import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_demo/src/core/dio/dio_helper.dart';
import 'package:store_demo/src/core/dio/end_points.dart';

final authRepoProivder = Provider((ref) => AuthRepo(ref: ref));

class AuthRepo {
  final Ref ref;

  AuthRepo({required this.ref});

  Future<void> login(String email, String password) async {
    try {
      await ref
          .read(dioHelperProvider)
          .postData(
            url: EndPoints.login,
            data: {'username': email, 'password': password},
          );
    } catch (e) {
      rethrow;
    }
  }
}
