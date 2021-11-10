

import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/core/usecases/usecase.dart';
import 'package:bufi_remake/screens/login/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUser implements UseCase<String, LoginParams> {
  final LoginRepository? repository;

  LoginUser({ this.repository});

  @override
  Future<Either<Failure,String>> call(LoginParams params) async {
   
    return await repository!.loginUser2(params.email, params.password);
  }
}

class LoginParams {
  final String? email;
  final String? password;

  LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
