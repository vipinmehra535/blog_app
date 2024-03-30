import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/datasoucres/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = await remoteDataSource.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(userId);
    } on SeveralExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailAndPassword
    throw UnimplementedError();
  }
}
