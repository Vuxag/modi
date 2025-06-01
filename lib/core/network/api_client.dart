import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:local_services_marketplace/shared/models/user_model.dart';
import 'package:local_services_marketplace/shared/models/service_model.dart';
import 'package:local_services_marketplace/shared/models/booking_model.dart';
import 'package:local_services_marketplace/shared/models/tag_model.dart';
import 'package:local_services_marketplace/shared/models/review_model.dart';
import 'package:local_services_marketplace/shared/models/promotion_model.dart';
import 'package:local_services_marketplace/shared/models/order_tracking_model.dart';
import 'package:local_services_marketplace/shared/models/chat_model.dart';
import 'package:local_services_marketplace/shared/models/payment_model.dart';
import 'package:local_services_marketplace/shared/models/schedule_model.dart';
import 'package:local_services_marketplace/shared/models/search_filter_model.dart';
import 'package:local_services_marketplace/shared/models/analytics_model.dart';
import 'package:local_services_marketplace/shared/models/referral_model.dart';

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
  factory ApiClient(Dio dio, {required String baseUrl}) {
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
    @Query("latitude") double latitude,
    @Query("longitude") double longitude,
    @Query("radius") double radius,
  );

  @GET("/services/{id}")
  Future<Service> getService(@Path("id") String id);

  @POST("/services/search")
  Future<List<Service>> searchServices(@Body() SearchFilter filter);

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
  @POST("/payments")
  Future<Payment> createPayment(@Body() Map<String, dynamic> body);

  @GET("/payments/{id}")
  Future<Payment> getPayment(@Path("id") String paymentId);

  @POST("/payments/{id}/installments")
  Future<Payment> createInstallments(
    @Path("id") String paymentId,
    @Body() Map<String, dynamic> body,
  );

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

  // Review endpoints
  @POST("/reviews")
  Future<Review> createReview(@Body() Map<String, dynamic> body);

  @GET("/reviews/service/{id}")
  Future<List<Review>> getServiceReviews(@Path("id") String serviceId);

  @PUT("/reviews/{id}/reply")
  Future<Review> replyToReview(
    @Path("id") String reviewId,
    @Body() Map<String, dynamic> body,
  );

  @POST("/reviews/{id}/media")
  Future<Review> addReviewMedia(
    @Path("id") String reviewId,
    @Body() Map<String, dynamic> body,
  );

  // Promotion endpoints
  @GET("/promotions")
  Future<List<Promotion>> getPromotions();

  @GET("/promotions/validate")
  Future<Promotion> validatePromotion(@Query("code") String code);

  @POST("/promotions/apply")
  Future<Map<String, dynamic>> applyPromotion(
    @Body() Map<String, dynamic> body,
  );

  // Order tracking endpoints
  @GET("/bookings/{id}/tracking")
  Future<OrderTracking> getOrderTracking(@Path("id") String bookingId);

  @POST("/bookings/{id}/tracking/update")
  Future<OrderTracking> updateOrderTracking(
    @Path("id") String bookingId,
    @Body() Map<String, dynamic> body,
  );

  // Chat endpoints
  @GET("/chats")
  Future<List<Chat>> getChats();

  @GET("/chats/{id}")
  Future<Chat> getChat(@Path("id") String chatId);

  @POST("/chats")
  Future<Chat> createChat(@Body() Map<String, dynamic> body);

  @POST("/chats/{id}/messages")
  Future<ChatMessage> sendMessage(
    @Path("id") String chatId,
    @Body() Map<String, dynamic> body,
  );

  // Notification endpoints
  @GET("/notifications")
  Future<List<Notification>> getNotifications();

  @PUT("/notifications/{id}/read")
  Future<void> markNotificationAsRead(@Path("id") String notificationId);

  @DELETE("/notifications/{id}")
  Future<void> deleteNotification(@Path("id") String notificationId);

  // Schedule endpoints
  @POST("/schedules")
  Future<Schedule> createSchedule(@Body() Map<String, dynamic> body);

  @GET("/schedules")
  Future<List<Schedule>> getSchedules(@Query("userId") String userId);

  @PUT("/schedules/{id}")
  Future<Schedule> updateSchedule(
    @Path("id") String scheduleId,
    @Body() Map<String, dynamic> body,
  );

  @POST("/schedules/{id}/reminders")
  Future<Schedule> addReminder(
    @Path("id") String scheduleId,
    @Body() Map<String, dynamic> body,
  );

  // Analytics endpoints
  @GET("/analytics/service/{id}")
  Future<ServiceAnalytics> getServiceAnalytics(@Path("id") String serviceId);

  @GET("/analytics/provider/{id}")
  Future<ProviderAnalytics> getProviderAnalytics(@Path("id") String providerId);

  @GET("/analytics/reviews")
  Future<List<ReviewAnalytics>> getReviewAnalytics(
    @Query("serviceId") String? serviceId,
    @Query("providerId") String? providerId,
  );

  // Referral endpoints
  @POST("/referrals")
  Future<Referral> createReferral(@Body() Map<String, dynamic> body);

  @GET("/referrals")
  Future<List<Referral>> getReferrals(@Query("userId") String userId);

  @GET("/referrals/stats")
  Future<ReferralStats> getReferralStats(@Query("userId") String userId);

  @POST("/share")
  Future<ShareContent> createShareContent(@Body() Map<String, dynamic> body);
}
