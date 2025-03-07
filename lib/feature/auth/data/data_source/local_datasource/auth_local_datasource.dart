import 'dart:io';

import 'package:wholesalehub_app/core/network/hive_service.dart';
import 'package:wholesalehub_app/feature/auth/data/data_source/auth_data_source.dart';
import 'package:wholesalehub_app/feature/auth/data/model/auth_hive_model.dart';
import 'package:wholesalehub_app/feature/auth/domain/entity/auth_entity.dart';

class AuthLocalDataSource implements IAuthDataSource {
  final HiveService _hiveService;

  AuthLocalDataSource(this._hiveService);

  @override
  Future<AuthEntity> getCurrentUser(String? token, String userId) async {
    // Return Empty AuthEntity
    return Future.value(const AuthEntity(
      userId: "1",
      fName: "",
      lName: "",
      image: null,
      email: "",
      phoneNo: "",
      address: "",
      username: "",
      password: "",
    ));
  }

  @override
  Future<String> loginCustomer(String username, String password) async {
    try {
      await _hiveService.loginCustomer(username, password);
      return Future.value("Success");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> registerCustomer(AuthEntity customer) async {
    try {
      // Convert AuthEntity to AuthHiveModel
      final authHiveModel = AuthHiveModel.fromEntity(customer);

      await _hiveService.register(authHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    throw UnimplementedError();
  }

  @override
  Future<String> getUserById(String username) {
    throw UnimplementedError();
  }

  @override
  Future<AuthEntity> updateUser(AuthEntity userId) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
