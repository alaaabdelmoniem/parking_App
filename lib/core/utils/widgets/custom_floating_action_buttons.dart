import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:parking/core/utils/app_colors.dart';

class CustomFloatingActionButtons extends StatefulWidget {
  const CustomFloatingActionButtons({
    super.key,
    this.currentPosition,
    required this.mapController,
  });

  final Position? currentPosition;
  final MapController mapController;

  @override
  State<CustomFloatingActionButtons> createState() =>
      _CustomFloatingActionButtonsState();
}

class _CustomFloatingActionButtonsState
    extends State<CustomFloatingActionButtons>
    with TickerProviderStateMixin {
  AnimationController? _animationController;

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    _animationController?.dispose();

    final camera = widget.mapController.camera;

    final latTween = Tween<double>(
      begin: camera.center.latitude,
      end: destLocation.latitude,
    );
    final lngTween = Tween<double>(
      begin: camera.center.longitude,
      end: destLocation.longitude,
    );
    final zoomTween = Tween<double>(begin: camera.zoom, end: destZoom);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    final animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInCubic,
    );

    _animationController!.addListener(() {
      widget.mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    _animationController!.forward();
  }

  void _zoomIn() {
    _animatedMapMove(
      widget.mapController.camera.center,
      widget.mapController.camera.zoom + 1,
    );
  }

  void _zoomOut() {
    _animatedMapMove(
      widget.mapController.camera.center,
      widget.mapController.camera.zoom - 3,
    );
  }

  void _goToCurrentLocation() {
    if (widget.currentPosition != null) {
      _animatedMapMove(
        LatLng(
          widget.currentPosition!.latitude,
          widget.currentPosition!.longitude,
        ),
        15,
      );
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomButtonFloating(onPressed: _zoomIn, icon: Icons.add),
        CustomButtonFloating(onPressed: _zoomOut, icon: Icons.remove),
        CustomButtonFloating(
          onPressed: _goToCurrentLocation,
          icon: Icons.my_location,
        ),
      ],
    );
  }
}

class CustomButtonFloating extends StatelessWidget {
  const CustomButtonFloating({super.key, this.onPressed, this.icon});
  final void Function()? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: AppColors.primary),
      style: IconButton.styleFrom(
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
      ),
    );
  }
}
