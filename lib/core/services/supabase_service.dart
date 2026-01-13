// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:vignesh_project_01/core/exceptions/failure.dart';

// class SupabaseService {
//   /// SERVICE CLASS FOR SUPABASE

//   late Supabase _instance;
//   Supabase get instance => _instance;

//   /// INITIALIZE SUPABASE
//   Future initialize() async {
//     String url = dotenv.env['SUPABASE_URL'] ?? "";
//     String anonKey = dotenv.env['ANON_KEY'] ?? "";
//     await Supabase.initialize(url: url, anonKey: anonKey);
//     _instance = Supabase.instance;
//   }

//   Future<Either<Failure, AuthResponse>> signIn({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       debugPrint("Signing in with email requested");
//       AuthResponse authResponse = await _instance.client.auth
//           .signInWithPassword(email: email, password: password);
//       debugPrint("Signing in with email successful");
//       return Right(authResponse);
//     } on AuthApiException catch (e) {
//       debugPrint("Signing in with email failed with AuthApiException: $e");
//       return Left(Failure(message: e.message));
//     } catch (e) {
//       debugPrint("Signing in with email failed with error: $e");
//       return Left(Failure(message: e.toString()));
//     }
//   }

//   Future<Either<Failure, AuthResponse>> signUp({
//     required String email,
//     required String password,
//     required Map<String, dynamic> data,
//   }) async {
//     try {
//       AuthResponse authResponse = await _instance.client.auth.signUp(
//         email: email,
//         data: data,
//         password: password,
//       );
//       return Right(authResponse);
//     } on AuthApiException catch (e) {
//       return Left(Failure(message: e.message));
//     } on AuthRetryableFetchException catch (e) {
//       return Left(Failure(message: jsonDecode(e.message)['message']));
//     } catch (e) {
//       return Left(Failure(message: "Something went wrong! : $e"));
//     }
//   }

//   Future<Either<Failure, bool>> signOut() async {
//     try {
//       await _instance.client.auth.signOut();
//       return Right(true);
//     } catch (e) {
//       throw Left(Failure(message: e.toString()));
//     }
//   }

//   Future<Response> insertToTable({
//     required String route,
//     Map<String, dynamic>? query,
//     Map<String, dynamic>? data,
//   }) async {
//     var result = await _instance.client.from(route).insert(data ?? {});
//     return result;
//   }

//   Future<Response> updateInTable({
//     required String route,
//     Map<String, dynamic>? query,
//     Map<String, dynamic>? data,
//     required String refValue,
//     required String refKey,
//   }) async {
//     var result = await _instance.client
//         .from(route)
//         .update(data ?? {})
//         .eq(refKey, refValue);
//     return result;
//   }
// }
