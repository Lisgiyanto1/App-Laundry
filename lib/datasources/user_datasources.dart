import 'package:dartz/dartz.dart';
import 'package:laundryapp/config/app_constants.dart';
import 'package:laundryapp/config/app_response.dart';
import 'package:laundryapp/config/failure.dart';
import 'package:laundryapp/config/app_request.dart';
// package http
import 'package:http/http.dart' as http;

class UserDataSources {
  static Future<Either<Failure, Map>> login(
    String email,
    String password,
  ) async {
    Uri url = Uri.parse('${AppConstants.baseURL}/login');
    try {
      final response = await http.post(
        url,
        headers: Apprequest.header(),
        body: {
          'email': email,
          'password': password,
        },
      );
      final data = AppResponse.data(response);
      return Right(data);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(FetchFailure(e.toString()));
    }
  }

  static Future<Either<Failure, Map>> register(
    String username,
    String email,
    String password,
  ) async {
    Uri url = Uri.parse('${AppConstants.baseURL}/register');
    try {
      final response = await http.post(
        url,
        headers: Apprequest.header(),
        body: {
          'username': username,
          'email': email,
          'password': password,
        },
      );
      final data = AppResponse.data(response);
      return Right(data);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(FetchFailure(e.toString()));
    }
  }
}
