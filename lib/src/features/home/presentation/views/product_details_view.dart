import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:store_demo/src/features/home/data/models/product_model.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../widgets/product_prefrences.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  Color bgColor = Colors.grey.shade200;

  @override
  void initState() {
    super.initState();
    getColor();
  }

  Future<void> getColor() async {
    final palette = await PaletteGenerator.fromImageProvider(
      NetworkImage(widget.product.thumbnail),
    );

    final color = palette.dominantColor?.color ?? Colors.grey;

    // نجعل اللون أفتح
    setState(() {
      bgColor = Color.alphaBlend(Colors.white.withAlpha(153), color);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: Color(0xff435B71)),
        ),
        title: const Text(
          'Details',
          style: TextStyle(
            color: Color(0xff191919),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/Vector (6).svg',
              colorFilter: ColorFilter.mode(Color(0xff435B71), BlendMode.srcIn),
            ),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,

        alignment: AlignmentGeometry.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fragrances',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              widget.product.title,
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            gapH8,

                            Text(
                              'Unit Price',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.product.price.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                gapW2,
                                Text(
                                  'R.Y',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            gapH16,
                            Text(
                              'Rating',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 18,
                                  color: Color(0xffFF9F06),
                                ),
                                Text('4.5'),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Hero(
                        tag: widget.product.id,
                        child: Image.network(
                          widget.product.thumbnail,
                          width: MediaQuery.sizeOf(context).width / 2.4,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 27),
                      Text(
                        'Overview',
                        style: TextStyle(
                          color: Color(0xff435B71),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      gapH12,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProductPrefrence(
                            path: 'assets/icons/store.svg',
                            name: 'Brand',
                            description: 'Dolce & Gabbana',
                          ),
                          ProductPrefrence(
                            path: 'assets/icons/clock-arrow-up.svg',
                            name: 'Return Policy',
                            description: '7 Day',
                          ),
                          ProductPrefrence(
                            path: 'assets/icons/store.svg',
                            name: 'Stock',
                            description: 'low Stock',
                          ),
                        ],
                      ),
                      SizedBox(height: 32),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(25),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(7),

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: AppColors.primary,
                                ),
                                child: Center(
                                  child: Text(
                                    'About',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Center(
                                  child: Text(
                                    'Reviews',
                                    style: TextStyle(color: Color(0xff999999)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 18),
                      Text(
                        'A vibrant and fruity perfume, blending mango, jasmine, and light woodsA vibrant and fruity perfume, blending mango, jasmine, and light woods',
                        style: TextStyle(
                          color: Color(0xff435B71),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            left: 20,
            right: 20,
            top: null,
            bottom: 40,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
              height: 60,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(80),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: Offset(0, 8),
                  ),
                ],
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(99),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total Price',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '3,000 RY',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add to Cart ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        SvgPicture.asset('assets/icons/shopping-bag.svg'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
