import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:store_demo/src/features/auth/data/auth_repo.dart';
part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  Future<bool> build() async {
    return false;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    try {
      await ref.read(authRepoProivder).login(email, password);
      state = const AsyncData(true);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
