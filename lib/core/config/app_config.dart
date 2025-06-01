import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppConfig {
  static const String appName = 'Local Services Marketplace';
  static const String apiBaseUrl = 'https://api.example.com/v1';
  static const int apiTimeout = 30000; // 30 seconds
  static const int maxRetries = 3;
  static const int pageSize = 20;

  // Cache durations
  static const int cacheDuration = 3600; // 1 hour
  static const int imageCacheDuration = 86400; // 24 hours

  // Animation durations
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration splashDuration = Duration(seconds: 2);

  // API endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String servicesEndpoint = '/services';
  static const String bookingsEndpoint = '/bookings';
  static const String reviewsEndpoint = '/reviews';

  // Storage keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String settingsKey = 'app_settings';
  static const String languageKey = 'app_language';

  // Error messages
  static const String networkError = 'Please check your internet connection';
  static const String serverError =
      'Something went wrong. Please try again later';
  static const String authError = 'Authentication failed. Please login again';

  // Feature flags
  static const bool enableDarkMode = true;
  static const bool enableBiometrics = true;
  static const bool enablePushNotifications = true;
  static const bool enableAnalytics = true;

  // Payment settings
  static const String stripePublishableKey = 'your_stripe_publishable_key';
  static const String stripeMerchantId = 'your_stripe_merchant_id';

  // Map settings
  static const double defaultLatitude = 10.762622;
  static const double defaultLongitude = 106.660172;
  static const double defaultZoom = 15.0;

  // Theme settings
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color secondaryColor = Color(0xFF03A9F4);
  static const Color accentColor = Color(0xFF00BCD4);
  static const Color errorColor = Color(0xFFE53935);
  static const Color successColor = Color(0xFF43A047);
  static const Color warningColor = Color(0xFFFFA000);

  // Font settings
  static const String fontFamily = 'Poppins';
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 14.0;
  static const double fontSizeLarge = 16.0;
  static const double fontSizeXLarge = 18.0;
  static const double fontSizeXXLarge = 20.0;

  // Spacing
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;

  // Border radius
  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 8.0;
  static const double borderRadiusLarge = 12.0;

  // Shadow
  static const List<BoxShadow> defaultShadow = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 2),
      blurRadius: 4,
    ),
  ];

  // App info
  static Future<PackageInfo> get packageInfo => PackageInfo.fromPlatform();

  // Supported languages
  static const List<String> supportedLanguages = ['en', 'vi'];
  static const String defaultLanguage = 'en';

  // Rate limiting
  static const int maxLoginAttempts = 5;
  static const int loginLockoutDuration = 900; // 15 minutes

  // Cache settings
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB
  static const int maxImageCacheSize = 50 * 1024 * 1024; // 50MB

  // Analytics events
  static const String eventLogin = 'login';
  static const String eventRegister = 'register';
  static const String eventViewService = 'view_service';
  static const String eventCreateBooking = 'create_booking';
  static const String eventAddReview = 'add_review';

  // Notification channels
  static const String channelGeneral = 'general';
  static const String channelBookings = 'bookings';
  static const String channelPromotions = 'promotions';

  // Deep link schemes
  static const String deepLinkScheme = 'localservices';
  static const String deepLinkHost = 'example.com';

  // Social sharing
  static const String shareTitle =
      'Check out this service on Local Services Marketplace';
  static const String shareText =
      'I found this great service on Local Services Marketplace';

  // Privacy policy and terms
  static const String privacyPolicyUrl = 'https://example.com/privacy';
  static const String termsOfServiceUrl = 'https://example.com/terms';

  // Support
  static const String supportEmail = 'support@example.com';
  static const String supportPhone = '+1234567890';
  static const String supportWebsite = 'https://support.example.com';
}
