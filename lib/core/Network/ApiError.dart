import 'package:dio/dio.dart';

/// Helper class for converting [DioError] into readable formats
class ApiError {
  int? errorType = 0;
  ApiErrorModel? apiErrorModel;

  /// Description of error generated, similar to [Error.message]
  String? errorDescription;

  ApiError({this.errorDescription});

  ApiError.fromDio(Object dioError) {
    _handleError(dioError);
  }

  /// Sets class properties based on the error
  void _handleError(Object error) {
    if (error is DioException) {
      DioException dioError = error;
      switch (dioError.type) {
        case DioExceptionType.cancel:
          errorDescription = "Request to server was cancelled";
          break;
        case DioExceptionType.connectionTimeout:
          errorDescription =
              "Connection timeout with server, please try again later";
          break;
        case DioExceptionType.badCertificate:
          errorDescription = "Bad Certificate";
          break;
        case DioExceptionType.connectionError:
          errorDescription = "Connection Error, please try again later";
          break;
        case DioExceptionType.unknown:
          errorDescription =
              "Connection to server failed due to internet connection, please check and try again";
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription =
              "Receive timeout in connection with server, please try again later.";
          break;
        case DioExceptionType.badResponse:
          errorType = dioError.response?.statusCode;
          if (dioError.response?.statusCode == 401) {
            apiErrorModel = ApiErrorModel.fromJson(dioError.response!.data);
            print('errorrr..... ${apiErrorModel?.message}');
            print(dioError.response!.data);
            errorDescription =
                _extractMessage(apiErrorModel?.message) ??
                extractDescriptionFromResponse(dioError.response);
          } else if (dioError.response?.statusCode == 400 ||
              dioError.response?.statusCode == 422 ||
              dioError.response?.statusCode == 403 ||
              dioError.response?.statusCode == 404 ||
              dioError.response?.statusCode == 409) {
            apiErrorModel = ApiErrorModel.fromJson(dioError.response?.data);
            if (dioError.response!.data.toString().isNotEmpty) {
              errorDescription =
                  _extractMessage(apiErrorModel?.message) ??
                  extractDescriptionFromResponse(dioError.response);
            }
          } else if (dioError.response?.statusCode == 500) {
            apiErrorModel?.message = "Server error, please try again later.";
            if (dioError.response!.data.toString().isNotEmpty) {
              errorDescription =
                  _extractMessage(apiErrorModel?.message) ??
                  extractDescriptionFromResponse(dioError.response);
            } else {
              errorDescription =
                  'Something went wrong while processing your request';
            }
          } else {
            errorDescription =
                "Couldn't Make connections, please try again Later";
          }
          break;
        case DioExceptionType.sendTimeout:
          errorDescription =
              "Connection to server failed due to internet connection, please check and try again";
          break;
      }
    } else {
      errorDescription = "Oops an error occurred, we are fixing it";
    }
  }

  String? _extractMessage(dynamic message) {
    if (message is String) {
      return message;
    } else if (message is ErrorMessage) {
      return message.error ?? message.responseData?.message;
    }
    return null;
  }

  String extractDescriptionFromResponse(Response<dynamic>? response) {
    String message = "";
    try {
      if (response?.data != null && response?.data["message"] != null) {
        message =
            _extractMessage(ApiErrorModel.fromJson(response?.data).message) ??
            '';
      } else {
        message = response?.statusMessage ?? '';
      }
    } catch (error) {
      message = response?.statusMessage ?? error.toString();
    }
    return message;
  }

  @override
  String toString() => '$errorDescription';
}

class ApiErrorModel {
  String? code;
  dynamic message; // Dynamic to handle String or ErrorMessage
  bool? success;
  String? details;
  dynamic content;
  dynamic error;

  ApiErrorModel({
    this.content,
    this.code,
    this.message,
    this.success,
    this.details,
    this.error,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    dynamic message;
    if (json["message"] is String) {
      message = json["message"];
    } else if (json["message"] is Map<String, dynamic>) {
      message = ErrorMessage.fromJson(json["message"]);
    } else {
      message = null;
    }

    return ApiErrorModel(
      code: json["code"],
      message: message,
      success: json["success"],
      details: json["details"],
      error: json["error"],
      content: json["content"],
    );
  }
}

class ErrorMessage {
  String? error;
  ResponseData? responseData;

  ErrorMessage({this.error, this.responseData});

  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    return ErrorMessage(
      error: json["error"],
      responseData:
          json["response_data"] != null
              ? ResponseData.fromJson(json["response_data"])
              : null,
    );
  }
}

class ResponseData {
  int? status;
  int? statusCode;
  String? message;
  String? error;

  ResponseData({this.status, this.statusCode, this.message, this.error});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      status: json["status"],
      statusCode: json["statusCode"],
      message: json["message"],
      error: json["error"],
    );
  }
}

// import 'package:dio/dio.dart';

// /// Helper class for converting [DioError] into readable formats
// class ApiError {
//   int? errorType = 0;
//   ApiErrorModel? apiErrorModel;

//   /// Description of error generated, similar to [Error.message]
//   String? errorDescription;

//   ApiError({this.errorDescription});

//   ApiError.fromDio(Object dioError) {
//     _handleError(dioError);
//   }

//   /// Sets class properties based on the error
//   void _handleError(Object error) {
//     if (error is DioException) {
//       DioException dioError = error;
//       switch (dioError.type) {
//         case DioExceptionType.cancel:
//           errorDescription = "Request to server was cancelled";
//           break;
//         case DioExceptionType.connectionTimeout:
//           errorDescription =
//               "Connection timeout with server, please try again later";
//           break;
//         case DioExceptionType.badCertificate:
//           errorDescription = "Bad Certificate";
//           break;
//         case DioExceptionType.connectionError:
//           errorDescription = "Connection Error, please try again later";
//           break;
//         case DioExceptionType.unknown:
//           errorDescription =
//               "Connection to server failed due to internet connection, please check and try again";
//           break;
//         case DioExceptionType.receiveTimeout:
//           errorDescription =
//               "Receive timeout in connection with server, please try again later.";
//           break;
//         case DioExceptionType.badResponse:
//           errorType = dioError.response?.statusCode;
//           if (dioError.response?.statusCode == 401) {
//             apiErrorModel = ApiErrorModel.fromJson(dioError.response!.data);
//             print('errorrr..... ${apiErrorModel?.error}');
//             print(dioError.response!.data);
//             errorDescription =
//                 _extractMessage(apiErrorModel?.error) ??
//                 extractDescriptionFromResponse(dioError.response);
//           } else if (dioError.response?.statusCode == 400 ||
//               dioError.response?.statusCode == 422 ||
//               dioError.response?.statusCode == 403 ||
//               dioError.response?.statusCode == 404 ||
//               dioError.response?.statusCode == 409) {
//             apiErrorModel = ApiErrorModel.fromJson(dioError.response?.data);
//             if (dioError.response!.data.toString().isNotEmpty) {
//               errorDescription =
//                   _extractMessage(apiErrorModel?.message) ??
//                   extractDescriptionFromResponse(dioError.response);
//             }
//           } else if (dioError.response?.statusCode == 500) {
//             apiErrorModel?.message = "Server error, please try again later.";
//             if (dioError.response!.data.toString().isNotEmpty) {
//               errorDescription =
//                   _extractMessage(apiErrorModel?.message) ??
//                   extractDescriptionFromResponse(dioError.response);
//             } else {
//               errorDescription =
//                   'Something went wrong while processing your request';
//             }
//           } else if (dioError.response?.statusCode == 425) {
//             errorDescription =
//                 // "Oops! we couldn't make connections, please try again";
//                 errorDescription =
//                     _extractMessage(apiErrorModel?.message) ??
//                     extractDescriptionFromResponse(dioError.response);
//           }
//           break;
//         case DioExceptionType.sendTimeout:
//           errorDescription =
//               "Connection to server failed due to internet connection, please check and try again";
//           break;
//       }
//     } else {
//       errorDescription = "Oops an error occurred, we are fixing it";
//     }
//   }

//   String? _extractMessage(dynamic message) {
//     if (message is String) {
//       return message;
//     } else if (message is ErrorMessage) {
//       return message.error ?? message.responseData?.message;
//     }
//     return null;
//   }

//   String extractDescriptionFromResponse(Response<dynamic>? response) {
//     String message = "";
//     try {
//       if (response?.data != null && response?.data["error"] != null) {
//         message =
//             _extractMessage(ApiErrorModel.fromJson(response?.data).error) ?? '';
//       } else {
//         message = response?.statusMessage ?? '';
//       }
//     } catch (error) {
//       message = response?.statusMessage ?? error.toString();
//     }
//     return message;
//   }

//   @override
//   String toString() => '$errorDescription';
// }

// class ApiErrorModel {
//   String? code;
//   dynamic message; // Dynamic to handle String or ErrorMessage
//   bool? success;
//   String? details;
//   dynamic content;
//   dynamic error;

//   ApiErrorModel({
//     this.content,
//     this.code,
//     this.message,
//     this.success,
//     this.details,
//     this.error,
//   });

//   factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
//     dynamic message;
//     if (json["message"] is String) {
//       message = json["message"];
//     } else if (json["message"] is Map<String, dynamic>) {
//       message = ErrorMessage.fromJson(json["message"]);
//     } else {
//       message = null;
//     }

//     return ApiErrorModel(
//       code: json["code"],
//       message: message,
//       success: json["success"],
//       details: json["details"],
//       error: json["error"],
//       content: json["content"],
//     );
//   }
// }

// class ErrorMessage {
//   String? error;
//   ResponseData? responseData;

//   ErrorMessage({this.error, this.responseData});

//   factory ErrorMessage.fromJson(Map<String, dynamic> json) {
//     return ErrorMessage(
//       error: json["error"],
//       responseData:
//           json["response_data"] != null
//               ? ResponseData.fromJson(json["response_data"])
//               : null,
//     );
//   }
// }

// class ResponseData {
//   int? status;
//   int? statusCode;
//   String? message;
//   String? error;

//   ResponseData({this.status, this.statusCode, this.message, this.error});

//   factory ResponseData.fromJson(Map<String, dynamic> json) {
//     return ResponseData(
//       status: json["status"],
//       statusCode: json["statusCode"],
//       message: json["message"],
//       error: json["error"],
//     );
//   }
// }

// import 'package:dio/dio.dart';
// import 'package:wepay/core/Network/LaravelError.dart';
// import 'package:wepay/core/main_core/app.logger.dart';

// /// Helper class for converting [DioException] into readable formats
// class ApiError {
//   int? errorType = 0;

//   final logger = getLogger('ApiError');

//   /// description of error generated this is similar to convention [Error.message]
//   String? errorDescription;

//   ApiError({this.errorDescription});

//   ApiError.fromDio(Object dioError) {
//     _handleError(dioError);
//   }

//   /// sets value of class properties from [error]
//   void _handleError(Object error) {
//     if (error is DioException) {
//       DioException dioError = error; // as DioError;
//       switch (dioError.type) {
//         case DioExceptionType.cancel:
//           errorDescription = "Request to server was cancelled";
//           break;

//         case DioExceptionType.unknown:
//           errorDescription = "Connection failed...";
//           break;
//         case DioExceptionType.receiveTimeout:
//         case DioExceptionType.sendTimeout:
//           errorDescription = "Connection failed...";
//           break;
//         case DioExceptionType.badResponse:
//           errorType = dioError.response?.statusCode;
//           errorDescription = _handleErrorFromStatusCode(dioError.response);
//           break;
//         case DioExceptionType.connectionTimeout:
//           errorDescription = "Connection timeout, please try again later";
//           break;
//         case DioExceptionType.badCertificate:
//           break;
//         case DioExceptionType.connectionError:
//           errorDescription = "Connection failed...";
//           break;
//       }
//     } else {
//       errorDescription = "Oops an error occurred, we are fixing it";
//     }
//   }

//   @override
//   String toString() => '$errorDescription';

//   String? _handleErrorFromStatusCode(Response? response) {
//     String? message;
//     switch (response?.statusCode) {
//       case 400:
//       case 402:
//       case 403:
//       case 404:
//       case 409:
//       case 500:
//         final data = ApiErrorModel.fromMap(response?.data);
//         message =
//             (data.errors?.isNotEmpty ?? false)
//                 ? data.errors?.first
//                 : data.message;
//         break;
//       case 429:
//         message = 'You are trying too many times, wait a minute.';
//         break;
//       case 422:
//         message = _handleResponseFromLaravel(response);
//         break;
//       default:
//     }
//     return message;
//   }

//   String _handleResponseFromLaravel(Response<dynamic>? data) {
//     final response = LaravelError.fromJson(data?.data);
//     if (response.errors!.email!.isNotEmpty) {
//       return response.errors!.email!.first;
//     }
//     if (response.errors!.username!.isNotEmpty) {
//       return response.errors!.username!.first;
//     }
//     if (response.errors!.picture!.isNotEmpty) {
//       return response.errors!.picture!.first;
//     }
//     if (response.errors!.receiverPhoneNo!.isNotEmpty) {
//       return response.errors!.receiverPhoneNo!.first;
//     }
//     return '';
//   }
// }

// class ApiErrorModel {
//   String? status;
//   String? message;
//   int? statusCode;
//   List<String>? errors;

//   ApiErrorModel({this.status, this.message, this.statusCode, this.errors});

//   factory ApiErrorModel.fromMap(Map<String, dynamic> map) {
//     return ApiErrorModel(
//       message: map['message'],
//       status: map['status'].toString(),
//       statusCode: map['statusCode']?.toInt(),
//       errors: List<String>.from(map['errors'] ?? [map['message']]),
//     );
//   }
// }
