import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class UploadProductScreen extends StatefulWidget {
  UploadProductScreen({super.key});

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _sizeController = TextEditingController();
  List<String> _imageUrls = [];
  bool _isLoading = false;
  final List<String> _categoryList = [];

  final List<String> _sizeList = [];
  String? selectedCategory;
  bool isLoading = false;
  String? productName;
  double? productPrice;
  int? discount;
  int? quantity;
  String? description;

  bool _isEntered = false;
// Create
  final ImagePicker picker = ImagePicker();

//Upload
  List<File> images = [];

// Define
  chooseImage() async {
    final pickedFiled = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFiled == null) {
      print('no image selected');
    } else {
      setState(() {
        images.add(File(pickedFiled.path));
      });
    }
  }

  Future<void> requestPermission() async {
    if (await Permission.photos.isDenied) {
      await Permission.photos.request();
    }
  }

  //method to upload image we select
  uploadProductImages() async {
    for (var image in images) {
      Reference ref = _firebaseStorage.ref().child('productImages').child(Uuid().v4());
      await ref.putFile(image).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          setState(() {
            _imageUrls.add(value);
          });
        });
      });
    }
  }

  uploadData() async {
    setState(() {
      _isLoading = true;
    });
    DocumentSnapshot vendorDoc =
        await _firestore.collection('vendors').doc(FirebaseAuth.instance.currentUser!.uid).get();
    await uploadProductImages();
    if (_imageUrls.isNotEmpty) {
      final productId = const Uuid().v4();
      await _firestore.collection('products').doc(productId).set({
        'productId': productId,
        'productName': productName,
        'productPrice': productPrice,
        'productSize': _sizeList,
        'category': selectedCategory,
        'description': description,
        'discount': discount ?? 0.00,
        'quantity': quantity,
        'productImage': _imageUrls,
        'vendorId': FirebaseAuth.instance.currentUser!.uid,
        'vendorName': (vendorDoc.data() as Map<String, dynamic>)['fullName'],
        'vendorEmail': (vendorDoc.data() as Map<String, dynamic>)['email'],
        'rating': 0,
        'totalReviews': 0,
        'isPopular': false,
      }).whenComplete(() {
        setState(() {
          _isLoading = false;
          _formKey.currentState!.reset();
          _imageUrls.clear();
          images.clear();
        });
      });
    }
  }

  _getCategories() {
    return _firestore.collection('categories').get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _categoryList.add(doc['categoryName']);
        });
      }
    });
  }

  @override
  void initState() {
    _getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              shrinkWrap: true,
              itemCount: images.length + 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 4.0,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                return index == 0
                    ? Center(
                        child: IconButton(
                          onPressed: () async {
                            await requestPermission();
                            chooseImage();
                          },
                          icon: Icon(Icons.add),
                        ),
                      )
                    : SizedBox(
                        child: Image.file(
                          images[index - 1],
                        ),
                      );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      productName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter field';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter product name',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.isNotEmpty && double.tryParse(value) != null) {
                              productPrice = double.parse(value);
                            } else {
                              productPrice = 0.0;
                            }
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter field';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Enter price',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: buildDropDownField(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty && int.tryParse(value) != null) {
                        discount = int.parse(value);
                      } else {
                        discount = null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Discount (Optional)',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty && int.tryParse(value) != null) {
                        quantity = int.parse(value);
                      } else {
                        quantity = 1;
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter field';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      description = value;
                    },
                    maxLength: 800,
                    maxLines: 4,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter field';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Description',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: _sizeController,
                            onChanged: (value) {
                              setState(() {
                                _isEntered = true;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Add Size',
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      _isEntered == true
                          ? Flexible(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _sizeList.add(_sizeController.text);
                                    _sizeController.clear();
                                  });
                                },
                                child: const Text(
                                  'Add',
                                ),
                              ),
                            )
                          : const Text(''),
                    ],
                  ),
                  _sizeList.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 50,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _sizeList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        _sizeList.removeAt(index);
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade800,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            _sizeList[index],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                      : const Text(''),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    uploadData();
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFF103DE5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Upload Product',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDropDownField() {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: 'Select category',
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        items: _categoryList.map((value) {
          return DropdownMenuItem(value: value, child: Text(value));
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              selectedCategory = value;
            });
          }
        });
  }
}
