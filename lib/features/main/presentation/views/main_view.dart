import 'package:flutter/material.dart';
import 'package:parking/features/map/presentation/views/map_view.dart';
import 'package:parking/features/main/presentation/views/widgets/nav_bar.dart';

class MainNavView extends StatefulWidget {
  const MainNavView({super.key});

  @override
  State<MainNavView> createState() => _MainNavViewState();
}

class _MainNavViewState extends State<MainNavView> {
  int _selectedIndex = 0;

  final _screens = const [MapScreen(), ReservationsScreen(), ProfileScreen()];

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

class ReservationsScreen extends StatelessWidget {
  const ReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
