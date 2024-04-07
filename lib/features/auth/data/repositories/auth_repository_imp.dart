import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/datasoucres/auth_remote_data_source.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();

      if (user == null) {
        return left(Failure("User is not Logged In"));
      }
      return right(user);
    } on SeveralExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(() async {
      return await remoteDataSource.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
    });
  }

  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(() async {
      return await remoteDataSource.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
    });
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fun) async {
    try {
      final user = await fun();
      return right(user);
    } on supabase.AuthException catch (e) {
      return left(Failure(e.message));
    } on SeveralExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
