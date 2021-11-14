import 'package:get_it/get_it.dart';
import 'package:kisan/Driver/Auth/authenicatte.dart';
import 'package:kisan/Driver/Auth/storage.dart';
import 'package:kisan/owner/user-controller.dart';

final locator = GetIt.instance;
void setServices() {
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerSingleton<StorageRepo>(StorageRepo());
  locator.registerSingleton<UserController>(UserController());
}
