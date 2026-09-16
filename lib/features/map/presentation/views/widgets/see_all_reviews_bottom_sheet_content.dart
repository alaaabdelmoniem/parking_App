import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/features/map/data/mock/mock_spot_data.dart';
import 'package:parking/features/map/data/models/review_model.dart';
import 'package:parking/features/map/presentation/views/widgets/review_card.dart';

class SeeAllReviewsBottomSheetContent extends StatelessWidget {
  const SeeAllReviewsBottomSheetContent({super.key, required this.controller});
final  ScrollController controller;
  static const _reviews = [
  ReviewDataModel(
    rating: 5,
    date: '11 September 2026',
    duration: '23 hours',
    car: 'Subaru Legacy',
  ),
  ReviewDataModel(
    rating: 5,
    date: '11 September 2026',
    duration: '1 day',
    car: 'Nissan Titan',
  ),
  ReviewDataModel(
    rating: 5,
    date: '11 September 2026',
    duration: '18 hours',
    car: 'Chevrolet Colorado',
    location: 'TD Garden',
    tags: ['Safe & secure', 'Great value', 'Easy enter & exit'],
  ),
  ReviewDataModel(
    rating: 5,
    date: '10 September 2026',
    duration: '8 hours',
    car: 'Jeep Cherokee',
    location: 'TD Garden',
    tags: ['Easy enter & exit'],
  ),
  ReviewDataModel(
    rating: 4,
    date: '9 September 2026',
    duration: '3 hours',
    car: 'Toyota Camry',
    location: 'Fenway Park',
    tags: ['Great value'],
  ),
  ReviewDataModel(
    rating: 5,
    date: '8 September 2026',
    duration: '2 days',
    car: 'Ford F-150',
    location: 'Logan Airport',
    tags: ['Safe & secure', 'Easy enter & exit'],
  ),
  ReviewDataModel(
    rating: 3,
    date: '7 September 2026',
    duration: '5 hours',
    car: 'Honda Civic',
    tags: ['Easy enter & exit'],
  ),
  ReviewDataModel(
    rating: 5,
    date: '6 September 2026',
    duration: '12 hours',
    car: 'Mazda CX-5',
    location: 'North Station',
    tags: ['Great value', 'Safe & secure'],
  ),
  ReviewDataModel(
    rating: 4,
    date: '5 September 2026',
    duration: '6 hours',
    car: 'Kia Sportage',
    location: 'TD Garden',
  ),
  ReviewDataModel(
    rating: 5,
    date: '4 September 2026',
    duration: '1 day',
    car: 'Hyundai Tucson',
    location: 'Fenway Park',
    tags: ['Safe & secure'],
  ),
  ReviewDataModel(
    rating: 5,
    date: '3 September 2026',
    duration: '9 hours',
    car: 'Ford Escape',
    tags: ['Great value', 'Easy enter & exit'],
  ),
  ReviewDataModel(
    rating: 4,
    date: '2 September 2026',
    duration: '4 hours',
    car: 'Chevrolet Malibu',
    location: 'Logan Airport',
    tags: ['Safe & secure', 'Great value'],
  ),
];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      itemCount: _reviews.length, 
      itemBuilder: (context, index) => ReviewCard(review: _reviews[index], comment: parkingReviews[index],),
    );
  }
}
