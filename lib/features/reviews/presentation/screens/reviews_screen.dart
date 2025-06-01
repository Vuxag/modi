import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_services_marketplace/core/network/api_client.dart';
import 'package:local_services_marketplace/features/reviews/presentation/controllers/review_controller.dart';
import 'package:local_services_marketplace/features/reviews/presentation/widgets/review_card.dart';
import 'package:local_services_marketplace/shared/models/review_model.dart';

class ReviewsScreen extends StatelessWidget {
  final String serviceId;
  late final ReviewController controller;

  ReviewsScreen({
    Key? key,
    required this.serviceId,
  }) : super(key: key) {
    final apiClient = Get.find<ApiClient>();
    controller = Get.put(ReviewController(apiClient));
    controller.loadServiceReviews(serviceId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error.value != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: ${controller.error.value}',
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.loadServiceReviews(serviceId),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final reviews = controller.reviews;
        if (reviews.isEmpty) {
          return const Center(
            child: Text('No reviews yet'),
          );
        }

        return ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];
            return ReviewCard(
              review: review,
              onReply: () => _showReplyDialog(context, review),
              onReport: () => _showReportDialog(context, review),
            );
          },
        );
      }),
      floatingActionButton: Obx(() {
        if (controller.isCreatingReview.value) {
          return const FloatingActionButton(
            onPressed: null,
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          );
        }
        return FloatingActionButton(
          onPressed: () => _showAddReviewDialog(context),
          child: const Icon(Icons.add),
        );
      }),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Reviews'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Sort by Rating'),
              trailing: const Icon(Icons.sort),
              onTap: () {
                controller.sortByRating();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Sort by Date'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () {
                controller.sortByDate();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Show Verified Only'),
              trailing: Obx(() => Switch(
                    value: controller.showVerifiedOnly.value,
                    onChanged: (value) {
                      controller.showVerifiedOnly.value = value;
                      Navigator.pop(context);
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _showReplyDialog(BuildContext context, Review review) {
    final replyController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reply to Review'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: replyController,
              decoration: const InputDecoration(
                hintText: 'Enter your reply...',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Obx(() {
              if (controller.isReplying.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          Obx(() {
            if (controller.isReplying.value) {
              return const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            }
            return ElevatedButton(
              onPressed: () {
                if (replyController.text.isNotEmpty) {
                  controller.replyToReview(review.id, replyController.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Send'),
            );
          }),
        ],
      ),
    );
  }

  void _showReportDialog(BuildContext context, Review review) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Review'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Inappropriate Content'),
              onTap: () {
                controller.reportReview(review.id, 'inappropriate');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Fake Review'),
              onTap: () {
                controller.reportReview(review.id, 'fake');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Spam'),
              onTap: () {
                controller.reportReview(review.id, 'spam');
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 16),
            Obx(() {
              if (controller.isReporting.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }

  void _showAddReviewDialog(BuildContext context) {
    final commentController = TextEditingController();
    final rating = 0.obs;
    final tags = <String>[].obs;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Review'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < rating.value ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                        ),
                        onPressed: () => rating.value = index + 1,
                      );
                    }),
                  )),
              const SizedBox(height: 16),
              TextField(
                controller: commentController,
                decoration: const InputDecoration(
                  hintText: 'Write your review...',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: [
                  'Quality',
                  'Service',
                  'Value',
                  'Cleanliness',
                  'Professionalism',
                ].map((tag) {
                  return FilterChip(
                    label: Text(tag),
                    selected: tags.contains(tag),
                    onSelected: (selected) {
                      if (selected) {
                        tags.add(tag);
                      } else {
                        tags.remove(tag);
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Obx(() {
                if (controller.isCreatingReview.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          Obx(() {
            if (controller.isCreatingReview.value) {
              return const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            }
            return ElevatedButton(
              onPressed: () {
                if (rating.value > 0 && commentController.text.isNotEmpty) {
                  controller.createReview(
                    serviceId,
                    rating.value,
                    commentController.text,
                    tags,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Submit'),
            );
          }),
        ],
      ),
    );
  }
}
