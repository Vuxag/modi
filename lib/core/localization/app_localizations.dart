import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:local_services_marketplace/core/config/app_config.dart';

class AppLocalizations {
  static const String _path = 'assets/translations';

  static Future<void> initialize() async {
    await EasyLocalization.ensureInitialized();
  }

  static Widget wrapWithLocalization(Widget child) {
    return EasyLocalization(
      supportedLocales:
          AppConfig.supportedLanguages.map((lang) => Locale(lang)).toList(),
      path: _path,
      fallbackLocale: Locale(AppConfig.defaultLanguage),
      child: child,
    );
  }

  // Common
  static String get appName => 'app.name'.tr();
  static String get ok => 'common.ok'.tr();
  static String get cancel => 'common.cancel'.tr();
  static String get save => 'common.save'.tr();
  static String get delete => 'common.delete'.tr();
  static String get edit => 'common.edit'.tr();
  static String get search => 'common.search'.tr();
  static String get loading => 'common.loading'.tr();
  static String get error => 'common.error'.tr();
  static String get success => 'common.success'.tr();
  static String get retry => 'common.retry'.tr();

  // Auth
  static String get login => 'auth.login'.tr();
  static String get register => 'auth.register'.tr();
  static String get forgotPassword => 'auth.forgot_password'.tr();
  static String get email => 'auth.email'.tr();
  static String get password => 'auth.password'.tr();
  static String get confirmPassword => 'auth.confirm_password'.tr();
  static String get phone => 'auth.phone'.tr();
  static String get name => 'auth.name'.tr();
  static String get logout => 'auth.logout'.tr();

  // Services
  static String get services => 'services.title'.tr();
  static String get serviceDetails => 'services.details'.tr();
  static String get serviceProvider => 'services.provider'.tr();
  static String get serviceLocation => 'services.location'.tr();
  static String get servicePrice => 'services.price'.tr();
  static String get serviceRating => 'services.rating'.tr();
  static String get serviceReviews => 'services.reviews'.tr();
  static String get serviceDescription => 'services.description'.tr();
  static String get serviceTags => 'services.tags'.tr();

  // Bookings
  static String get bookings => 'bookings.title'.tr();
  static String get bookingDetails => 'bookings.details'.tr();
  static String get bookingStatus => 'bookings.status'.tr();
  static String get bookingDate => 'bookings.date'.tr();
  static String get bookingTime => 'bookings.time'.tr();
  static String get bookingPrice => 'bookings.price'.tr();
  static String get bookingPayment => 'bookings.payment'.tr();
  static String get bookingCancel => 'bookings.cancel'.tr();
  static String get bookingReschedule => 'bookings.reschedule'.tr();

  // Reviews
  static String get reviews => 'reviews.title'.tr();
  static String get addReview => 'reviews.add'.tr();
  static String get editReview => 'reviews.edit'.tr();
  static String get reviewRating => 'reviews.rating'.tr();
  static String get reviewComment => 'reviews.comment'.tr();
  static String get reviewTags => 'reviews.tags'.tr();
  static String get reviewReply => 'reviews.reply'.tr();
  static String get reviewReport => 'reviews.report'.tr();

  // Payments
  static String get payments => 'payments.title'.tr();
  static String get paymentMethod => 'payments.method'.tr();
  static String get paymentStatus => 'payments.status'.tr();
  static String get paymentAmount => 'payments.amount'.tr();
  static String get paymentDate => 'payments.date'.tr();
  static String get paymentDetails => 'payments.details'.tr();
  static String get paymentHistory => 'payments.history'.tr();
  static String get paymentInstallments => 'payments.installments'.tr();

  // Profile
  static String get profile => 'profile.title'.tr();
  static String get editProfile => 'profile.edit'.tr();
  static String get settings => 'profile.settings'.tr();
  static String get notifications => 'profile.notifications'.tr();
  static String get language => 'profile.language'.tr();
  static String get theme => 'profile.theme'.tr();
  static String get help => 'profile.help'.tr();
  static String get about => 'profile.about'.tr();

  // Errors
  static String get networkError => 'errors.network'.tr();
  static String get serverError => 'errors.server'.tr();
  static String get authError => 'errors.auth'.tr();
  static String get validationError => 'errors.validation'.tr();
  static String get unknownError => 'errors.unknown'.tr();

  // Success Messages
  static String get loginSuccess => 'success.login'.tr();
  static String get registerSuccess => 'success.register'.tr();
  static String get bookingSuccess => 'success.booking'.tr();
  static String get paymentSuccess => 'success.payment'.tr();
  static String get reviewSuccess => 'success.review'.tr();
  static String get profileUpdateSuccess => 'success.profile_update'.tr();

  // Validation Messages
  static String get requiredField => 'validation.required'.tr();
  static String get invalidEmail => 'validation.invalid_email'.tr();
  static String get invalidPhone => 'validation.invalid_phone'.tr();
  static String get invalidPassword => 'validation.invalid_password'.tr();
  static String get passwordMismatch => 'validation.password_mismatch'.tr();
  static String get minLength => 'validation.min_length'.tr();
  static String get maxLength => 'validation.max_length'.tr();
}
