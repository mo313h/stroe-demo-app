import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class ProductPrefrence extends StatelessWidget {
  const ProductPrefrence({
    super.key,
    required this.path,
    required this.name,
    required this.description,
  });
  final String path;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(path),
        Text(name, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
        gapH4,
        Text(
          description,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
