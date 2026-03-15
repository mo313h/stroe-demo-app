import 'package:flutter/material.dart';
import 'package:store_demo/src/features/home/data/models/product_model.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../views/product_details_view.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
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
        height: 177,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),

        margin: EdgeInsets.symmetric(horizontal: 6),
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(product.thumbnail, height: 60)),
            gapH8,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    product.title,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ),
                gapW12,
                Icon(Icons.star, size: 18, color: Color(0xffFF9F06)),
                Text('4.5'),
              ],
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
            gapH12,
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
