import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/datasoucres/auth_remote_data_source.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataSource.currentUserSession;
        if (session == null) {
          return left(Failure("User is not Logged In"));
        }
        return right(UserModel(
          id: session.user.id,
          name: "",
          email: session.user.email ?? "",
        ));
      }
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
      if (!await (connectionChecker.isConnected)) {
        return left(Failure("No Internet Connection"));
      }

      final user = await fun();
      return right(user);
    } on SeveralExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
