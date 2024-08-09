import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp/controllers/category_controllers.dart';
import 'package:shopapp/views/inner_screens/category_product_screen.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({super.key});

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  final categoryController _categoryController = Get.find<categoryController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _categoryController.categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 4, crossAxisSpacing: 8, crossAxisCount: 4),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CategoryProductScreen(
                          categoryModel: _categoryController.categories[index]);
                    }));
                  },
                  child: Column(
                    children: [
                      Image.network(
                        _categoryController.categories[index].categoryImage,
                        width: 47,
                        height: 47,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        _categoryController.categories[index].CategoryName,
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 0.3,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              })
        ],
      );
    });
  }
}
