import 'package:flutter/material.dart';
import 'package:parking/features/map/presentation/views/widgets/rounded_sheet_content.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          // screen content
          SizedBox.expand(),

          // draggable bottom sheet
          RoundedSheetContent(),
        ],
      ),
    );
  }
}
