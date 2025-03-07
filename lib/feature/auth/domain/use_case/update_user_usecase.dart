import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wholesalehub_app/app/usecase/usease.dart';
import 'package:wholesalehub_app/core/error/failure.dart';
import 'package:wholesalehub_app/feature/auth/domain/entity/auth_entity.dart';
import 'package:wholesalehub_app/feature/auth/domain/repository/auth_repository.dart';

// class UpdateUserParams extends Equatable {
//   final String fName;
//   final String lName;
//   final String email;
//   final String phoneNo;
//   final String address;
//   final String username;
//   // final String password;
//   final String? image;

//   const UpdateUserParams({
//     required this.fName,
//     required this.lName,
//     required this.email,
//     required this.phoneNo,
//     required this.address,
//     required this.username,
//     // required this.password,
//     this.image,
//   });

//   @override
//   List<Object?> get props => [
//         fName,
//         lName,
//         email,
//         phoneNo,
//         address,
//         username,
//       ];

//   // Validation method
//   String? validate() {
//     if (fName.isEmpty || lName.isEmpty) return 'Name fields cannot be empty';
//     if (email.isEmpty || !email.contains('@')) return 'Enter a valid email';
//     if (phoneNo.isEmpty || phoneNo.length != 10) return 'Invalid phone number';
//     if (username.isEmpty) return 'Username is required';
//     // if (password.isEmpty || password.length < 6) return 'Password too short';
//     return null; // Valid
//   }
// }

class UpdateUserUsecase implements UsecaseWithParams<void, AuthEntity> {
  final IAuthRepository repository;

  UpdateUserUsecase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(AuthEntity params) async {
    try {
      final authEntity = AuthEntity(
        fName: params.fName,
        lName: params.lName,
        email: params.email,
        phoneNo: params.phoneNo,
        address: params.address,
        username: params.username,
        password: '',
        image: params.image,
      );
      print('AUTHENTITY::: $authEntity');
      return repository.updateUser(authEntity);
    } catch (e) {
      return Left(
        SharedPrefsFailure(
            message: 'Unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}
