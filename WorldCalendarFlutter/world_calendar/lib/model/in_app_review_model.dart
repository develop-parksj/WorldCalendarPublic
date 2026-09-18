import 'package:in_app_review/in_app_review.dart';

class InAppReviewModel {
  static final InAppReviewModel _model = InAppReviewModel();
  static InAppReviewModel get instance => _model;

  InAppReviewModel();

  Future<void> requestReview() async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }
}