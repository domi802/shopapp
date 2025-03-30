import 'package:flutter/material.dart';
import 'package:shopapp/views/widgets/banner_widget.dart';
import 'package:shopapp/views/widgets/category_item.dart';
import 'package:shopapp/views/widgets/header_widget.dart';
import 'package:shopapp/views/widgets/popular_product_widget.dart';
import 'package:shopapp/views/widgets/reusable_text_widget.dart';

import '../widgets/recommended_product_widget.dart';

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
            CategoryItem(),
            ReusableTextWidget(title: 'Recommendet for you', subTitle: 'View all'),
            RecommendedProductWidget(),
            ReusableTextWidget(title: 'Popular Products', subTitle: 'View all'),
            PopularProductWidget(),
          ],
        ),
      ),
    );
  }
}
