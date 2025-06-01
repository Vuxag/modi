import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:local_services_marketplace/shared/models/user_model.dart';
import 'package:local_services_marketplace/shared/models/service_model.dart';
import 'package:local_services_marketplace/shared/models/booking_model.dart';
import 'package:local_services_marketplace/shared/models/tag_model.dart';

part 'api_client.g.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() =>
      'ApiException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

@RestApi(baseUrl: "https://api.example.com/v1")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) {
    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException e, ErrorInterceptorHandler handler) {
        if (e.response != null) {
          final message = e.response?.data['message'] ?? e.message;
          throw ApiException(message, statusCode: e.response?.statusCode);
        }
        throw ApiException(e.message ?? 'Unknown error occurred');
      },
    ));
    return _ApiClient(dio, baseUrl: baseUrl);
  }

  // Auth endpoints
  @POST("/auth/register")
  Future<User> register(@Body() Map<String, dynamic> body);

  @POST("/auth/login")
  Future<Map<String, dynamic>> login(@Body() Map<String, dynamic> body);

  @POST("/auth/verify-phone")
  Future<void> verifyPhone(@Body() Map<String, dynamic> body);

  // Services endpoints
  @GET("/services")
  Future<List<Service>> getServices(
    @Query("tags") String? tags,
    @Query("lat") double? latitude,
    @Query("lng") double? longitude,
    @Query("radius") double? radius,
  );

  @GET("/services/nearby")
  Future<List<Service>> getNearbyServices(
    @Query("lat") double latitude,
    @Query("lng") double longitude,
    @Query("radius") double radius,
  );

  @GET("/services/{id}")
  Future<Service> getService(@Path("id") String id);

  @POST("/services/search")
  Future<List<Service>> searchServices(@Body() Map<String, dynamic> body);

  // Booking endpoints
  @POST("/bookings")
  Future<Booking> createBooking(@Body() Map<String, dynamic> body);

  @GET("/bookings/user")
  Future<List<Booking>> getUserBookings();

  @GET("/bookings/provider")
  Future<List<Booking>> getProviderBookings();

  @PUT("/bookings/{id}/status")
  Future<Booking> updateBookingStatus(
    @Path("id") String id,
    @Body() Map<String, dynamic> body,
  );

  // Payment endpoints
  @POST("/payments/create")
  Future<Map<String, dynamic>> createPayment(@Body() Map<String, dynamic> body);

  @POST("/payments/verify")
  Future<void> verifyPayment(@Body() Map<String, dynamic> body);

  @GET("/payments/history")
  Future<List<Map<String, dynamic>>> getPaymentHistory();

  // Rating endpoints
  @POST("/ratings")
  Future<void> createRating(@Body() Map<String, dynamic> body);

  @GET("/ratings/service/{id}")
  Future<List<Map<String, dynamic>>> getServiceRatings(@Path("id") String id);

  // Tag endpoints
  @GET("/tags")
  Future<List<Tag>> getTags(@Query("parentId") String? parentId);

  @POST("/tags")
  Future<Tag> createTag(@Body() Map<String, dynamic> body);

  @POST("/services/{id}/tags")
  Future<void> addTagsToService(
    @Path("id") String serviceId,
    @Body() List<String> tagIds,
  );

  @GET("/tags/popular")
  Future<List<Tag>> getPopularTags();
}
