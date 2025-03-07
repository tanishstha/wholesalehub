import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:wholesalehub_app/core/error/failure.dart';
import 'package:wholesalehub_app/feature/auth/data/data_source/local_datasource/auth_local_datasource.dart';
import 'package:wholesalehub_app/feature/auth/domain/entity/auth_entity.dart';
import 'package:wholesalehub_app/feature/auth/domain/repository/auth_repository.dart';

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepository(this._authLocalDataSource);

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser(
      String? token, String userId) async {
    try {
      final currentUser =
          await _authLocalDataSource.getCurrentUser(token, userId);
      return Right(currentUser);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginCustomer(
    String username,
    String password,
  ) async {
    try {
      final token =
          await _authLocalDataSource.loginCustomer(username, password);
      return Right(token);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerCustomer(AuthEntity customer) async {
    try {
      await _authLocalDataSource.registerCustomer(customer);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    return const Left(LocalDatabaseFailure(
        message: "Profile picture upload is not supported in local storage."));
  }

  @override
  Future<Either<Failure, AuthEntity>> updateUser(AuthEntity user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
