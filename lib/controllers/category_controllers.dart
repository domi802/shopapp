import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopapp/models/category_models.dart';

class categoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fatchCategories();
  }

  void _fatchCategories() {
    _firestore.collection('categories').snapshots().listen(
      (QuerySnapshot querySnapshot) {
        categories.assignAll(
          querySnapshot.docs.map(
            (doc) {
              final data = doc.data() as Map<String, dynamic>;

              return CategoryModel(
                CategoryName: data['CategoryName'],
                categoryImage: data['categoryImage'],
              );
            },
          ).toList(),
        );
      },
    );
  }
}
