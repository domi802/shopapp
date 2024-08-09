import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/provider/cart_provider.dart';
import 'package:shopapp/provider/favorite_provider.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final dynamic productData;
  ProductDetailScreen({super.key, required this.productData});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProviderData = ref.read(cartProvider.notifier);
    final favoriteProviderData = ref.read(favoriteProvider.notifier);
    ref.watch(favoriteProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Product Detail',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: Color(0xFF363330),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              onPressed: () {
                favoriteProviderData.addProductToFavorite(
                  productName: widget.productData['productName'],
                  productId: widget.productData['productId'],
                  imageUrl: widget.productData['productImage'],
                  productPrice: widget.productData['productPrice'],
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    margin: EdgeInsets.all(15),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.grey,
                    content: Text(
                      widget.productData['productName'],
                    ),
                  ),
                );
              },
              icon: favoriteProviderData.getFavoriteItem
                      .containsKey(widget.productData["productId"])
                  ? Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 274,
              width: 260,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0,
                    top: 15,
                    child: Container(
                      width: 260,
                      height: 260,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Color(0xFFE8EEFF),
                        borderRadius: BorderRadius.circular(130),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 22,
                    top: 0,
                    child: Container(
                      width: 216,
                      height: 274,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Color(0xFF9CA8FF),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: SizedBox(
                        width: 300,
                        child: PageView.builder(
                          itemCount: widget.productData['productImage'].length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              widget.productData['productImage'][index],
                              width: 198,
                              height: 225,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.productData['productName'],
                  style: GoogleFonts.roboto(
                    color: Color(0xFF3C55EF),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  "\$${widget.productData['productPrice'].toStringAsFixed(2)}",
                  style: GoogleFonts.roboto(
                    color: Color(0xFF3C55EF),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.productData['category'],
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          widget.productData['rating'] == 0
              ? Text('')
              : Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Text(
                        widget.productData['rating'].toString(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0),
                      ),
                      Text(
                        '(${widget.productData['totalReviews'].toString()})',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 2.0),
                      ),
                    ],
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Size',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Color(
                      0xFF343434,
                    ),
                    letterSpacing: 1.6,
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.productData['productSize'].length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF12688),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.productData['productSize'][index],
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About',
                  style: GoogleFonts.lato(
                    color: Color(0xFF363330),
                    fontSize: 16,
                    letterSpacing: 1.0,
                  ),
                ),
                Text(
                  widget.productData['description'],
                ),
              ],
            ),
          )
        ],
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            cartProviderData.addProductToCart(
              productName: widget.productData['productName'],
              productPrice: widget.productData['productPrice'],
              categoryName: widget.productData['category'],
              imageUrl: widget.productData['productImage'],
              quantity: 1,
              instock: widget.productData['quantity'],
              productId: widget.productData['productId'],
              productSize: ' ',
              discount: widget.productData['discount'],
              description: widget.productData['description'],
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                margin: EdgeInsets.all(15),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.grey,
                content: Text(
                  widget.productData['productName'],
                ),
              ),
            );
          },
          child: Container(
            width: 386,
            height: 48,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Color(
                0xFF33B54EE,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Text(
                'Add to Cart',
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
