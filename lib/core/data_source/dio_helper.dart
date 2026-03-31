import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:task_mangment/features/auth/screens/login_screen.dart';

import '../router/navigation_helper.dart';
import '../localization/localization_helper.dart';
import '../services/alerts.dart';
import '../../shared/widgets/myLoading.dart';
import '../utils/utils.dart';

class DioService {
  late final Dio _dio;

  DioService([String baseUrl = '']) {
    _dio =
        Dio(
            BaseOptions(
              baseUrl: baseUrl,
              validateStatus: (status) => status != null && status < 400,
              followRedirects: true, // دع Dio يتعامل مع عمليات إعادة التوجيه
              headers: _getDefaultHeaders(),
              receiveDataWhenStatusError: true,
              connectTimeout: const Duration(milliseconds: 30000),
              receiveTimeout: const Duration(milliseconds: 30000),
            ),
          )
          ..interceptors.add(
            PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              responseBody: true,
              error: true,
              compact: true,
              maxWidth: 90,
            ),
          );
  }

  Map<String, dynamic> _getDefaultHeaders() {
    return {
      "Accept": "application/json",
      "lang": LocalizationHelper.currentLocale.languageCode,
    };
  }

  void _updateHeaders({required String method, bool isFile = false}) {
    final defaultHeaders = _getDefaultHeaders();
    _dio.options.headers = {
      ...defaultHeaders,
      if (Utils.token.isNotEmpty) "Authorization": 'Bearer ${Utils.token}',
    };

    // تجنب إضافة Content-Type لطلبات GET
    if (method.toUpperCase() != 'GET') {
      if (isFile) {
        // هذا الشرط سيتحقق فقط لطلبات POST أو PUT التي تحتوي على ملفات
        _dio.options.headers["Content-Type"] = "multipart/form-data";
      } else {
        // هنا يمكنك تعيين Content-Type الافتراضي للطلبات التي لا تحتوي على ملفات
        // مثل "application/json" إذا كان الـ backend يتوقع ذلك
        _dio.options.headers["Content-Type"] = "application/json";
      }
    }
  }

  Future<ApiResponse<T?>> _request<T>({
    required String method,
    required String url,
    Map<String, dynamic>? body,
    T Function(Map<String, dynamic>)? parser,
    Map<String, dynamic>? query,
    bool loading = false,
    bool isForm = false,
    bool isFile = false,
  }) async {
    try {
      if (loading) MyLoading.show();

      _updateHeaders(method: method, isFile: isFile);
      final data = isForm ? FormData.fromMap(body ?? {}) : body;

      Response response = await _dio.request(
        url,
        options: Options(method: method),
        data: data,
        queryParameters: query,
      );

      if (loading) MyLoading.dismis();
      return _checkForSuccess<T?>(response, parser);
    } on DioException catch (e) {
      if (loading) MyLoading.dismis();
      var response = _handleDioException<T?>(e);
      return ApiResponse(
        isError: true,
        response: response.response,
        model: null,
        message: response.message,
      );
    } catch (e) {
      // للتعامل مع أي أخطاء أخرى غير متوقعة
      if (loading) MyLoading.dismis();
      log("Unhandled Error: $e", name: "dio_service_error");
      Alerts.snack(
        text: LocalizationHelper.tr.parsingError,
        state: SnackState.failed,
      );
      return ApiResponse(isError: true, model: null, message: e.toString());
    }
  }

  Future<ApiResponse<T?>> postData<T>({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    bool loading = false,
    bool isForm = false,
    bool isFile = false,
    T Function(Map<String, dynamic>)? parser,
  }) {
    return _request<T?>(
      method: "POST",
      url: url,
      body: body,
      query: query,
      loading: loading,
      isForm: isForm,
      isFile: isFile,
      parser: parser,
    );
  }

  Future<ApiResponse<T?>> putData<T>({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    bool loading = false,
    bool isForm = false,
    T Function(Map<String, dynamic>)? parser,
  }) {
    return _request<T?>(
      method: "PUT",
      url: url,
      body: body,
      parser: parser,
      query: query,
      loading: loading,
      isForm: isForm,
    );
  }

  Future<ApiResponse<T?>> deleteData<T>({
    required String url,
    Map<String, dynamic>? query,
    T Function(Map<String, dynamic>)? parser,
    bool loading = false,
  }) {
    return _request<T?>(
      method: "DELETE",
      url: url,
      query: query,
      loading: loading,
      parser: parser,
    );
  }

  Future<ApiResponse<T?>> getData<T>({
    required String url,
    Map<String, dynamic>? query,
    T Function(Map<String, dynamic>)? parser,
    bool loading = false,
  }) {
    return _request<T?>(
      method: "GET",
      url: url,
      query: query,
      loading: loading,
      parser: parser,
    );
  }

  ApiResponse<T?> _checkForSuccess<T>(
    Response response,
    T? Function(Map<String, dynamic>)? parser,
  ) {
    // تحقق من وجود 'status' و 'message' قبل الوصول إليهما
    final bool status = response.data is Map
        ? response.data["status"] ?? false
        : false;
    final String message = response.data is Map
        ? response.data["message"] ?? "No message from server"
        : "Invalid response format";

    try {
      if (status) {
        return ApiResponse<T?>(
          isError: false,
          response: response,
          model: (parser != null) ? parser(response.data) : null,
          message: message,
        );
      } else {
        Alerts.snack(text: message, state: SnackState.failed);
        return ApiResponse<T?>(
          isError: true,
          response: response,
          model: null,
          message: message,
        );
      }
    } catch (e, trace) {
      log("Error: $e", name: "model_error");
      log("Trace: $trace", name: "model_trace");
      Alerts.snack(
        text: LocalizationHelper.tr.unexpectedError,
        state: SnackState.failed,
      );
      return ApiResponse<T?>(
        isError: true,
        response: response,
        model: null,
        message: e.toString(),
      );
    }
  }

  ApiResponse<T?> _handleDioException<T>(DioException e) {
    String errorMessage = LocalizationHelper.tr.unexpectedError;

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        errorMessage = LocalizationHelper.tr.connectionTimeout;
        break;
      case DioExceptionType.badResponse:
        errorMessage =
            e.response?.data["message"] ?? LocalizationHelper.tr.serverError;
        if (errorMessage.contains("Unauthenticated")) {
          _handleUnauthenticated();
        }
        break;
      case DioExceptionType.connectionError:
        errorMessage = LocalizationHelper.tr.noNetwork;
        break;
      case DioExceptionType.unknown:
        // التعامل مع الأخطاء غير المعروفة بشكل صريح
        errorMessage = LocalizationHelper.tr.unknownError;
        log("DioException.unknown: ${e.message}", name: "dio_error");
        break;
      case DioExceptionType.cancel:
        errorMessage = LocalizationHelper.tr.requestCanceled;
        break;
      case DioExceptionType.badCertificate:
        errorMessage = LocalizationHelper.tr.badCertificate;
        break;
    }

    Alerts.snack(text: errorMessage, state: SnackState.failed);
    return ApiResponse(
      isError: true,
      response: e.response,
      model: null,
      message: errorMessage,
    );
  }

  void _handleUnauthenticated() async {
    await Utils.dataManager.deleteUserData();
    if (!NavigationService.context.mounted) return;
    Navigator.push(
      NavigationService.context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}

class ApiResponse<T> {
  final bool isError;
  final String? message;
  final Response? response;
  final T? model;

  ApiResponse({required this.isError, this.response, this.model, this.message});
}
