import 'package:flutter/material.dart';
import 'package:parking/features/map/presentation/views/map_view.dart';
import 'package:parking/features/main/presentation/views/widgets/nav_bar.dart';
import 'package:parking/features/reservations/presentation/views/reservations_view.dart';

class MainNavView extends StatefulWidget {
  const MainNavView({super.key});

  @override
  State<MainNavView> createState() => _MainNavViewState();
}

class _MainNavViewState extends State<MainNavView> {
  int _selectedIndex = 1;

  final _screens = const [MapScreen(), ReservationsView(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // content can display Below nav bar
      body: _screens[_selectedIndex],
      bottomNavigationBar: LiquidGlassNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
