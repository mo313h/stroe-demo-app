import 'package:flutter/material.dart';
import 'package:store_demo/src/features/home/data/models/product_model.dart';
import 'package:store_demo/src/features/home/presentation/views/product_details_view.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class HorizontalProductCard extends StatelessWidget {
  const HorizontalProductCard({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsView(product: product),
        ),
      ),
      child: Container(
        height: 93,
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),

        margin: EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(color: Color(0xffE6E6E6)),
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: product.id,
                child: SizedBox(
                  height: 70,
                  width: 84,
                  child: Image.network(product.thumbnail),
                ),
              ),
            ),
            gapW8,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    product.title,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  gapH4,
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    product.description,
                    style: TextStyle(
                      color: Color(0xff3B3B3B),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        product.price.toString(),
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      gapW2,
                      Text(
                        'R.Y',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            gapW12,
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.star, size: 18, color: Color(0xffFF9F06)),
                    Text('4.5'),
                  ],
                ),
                Spacer(),
                Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(size: 20, Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
