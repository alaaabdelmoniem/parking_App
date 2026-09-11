import 'package:flutter/material.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/map/presentation/views/widgets/spot_details_view_body.dart';

class SpotDetailsView extends StatelessWidget {
  const SpotDetailsView({super.key, required this.spotModel});
  final SpotModel spotModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SpotDetailsViewBody(spotModel: spotModel));
  }
}
