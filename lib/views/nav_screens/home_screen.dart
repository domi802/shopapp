import 'package:flutter/material.dart';
import 'package:shopapp/views/widgets/banner_widget.dart';
import 'package:shopapp/views/widgets/header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(),
            BannerWidget(),
          ],
        ),
      ),
    );
  }
}
