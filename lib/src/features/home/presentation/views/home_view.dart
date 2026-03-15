import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_demo/src/core/constants/app_colors.dart';
import 'package:store_demo/src/core/constants/app_sizes.dart';
import 'package:store_demo/src/features/home/presentation/state/products_state.dart';
import 'package:store_demo/src/features/home/presentation/widgets/banner_slider.dart';

import '../widgets/horizontal_product_card.dart';
import '../widgets/product_card.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productsStateProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,

      child: Stack(
        children: [
          Image.asset(
            'assets/images/Rectangle 8132.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: [
                gapH64,
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white.withAlpha(100),
                      ),
                      child: SvgPicture.asset('assets/icons/map.svg'),
                    ),
                    gapW10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Location', style: TextStyle(color: Colors.white)),
                        SizedBox(
                          width: 180,
                          child: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            'Al Mukalla – Fuwah – Al Mutadarreen (Neighborhood), Street',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Badge(
                      offset: Offset(5, 33),
                      child: Icon(
                        size: 20,
                        Icons.notifications_none_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                gapH24,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/Vector (6).svg'),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hint: Text(
                              '  Search',
                              style: TextStyle(
                                color: Color(0xff878787),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 9),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/ri_equalizer-fill.svg'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 220,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: state.when(
                data: (products) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(child: BannerSlider()),
                      SliverToBoxAdapter(child: gapH48),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Text(
                                'Latest Products',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'View All',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: gapH12),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 190,
                          child: ListView.builder(
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) => Align(
                              alignment: AlignmentGeometry.center,
                              child: ProductCard(product: products[i]),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: gapH32),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Text(
                                'Popular Products',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'View All',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverList.builder(
                          itemCount: products.length + 1,
                          itemBuilder: (context, i) {
                            if (i < products.length) {
                              if (i == products.length - 1) {
                                ref
                                    .read(productsStateProvider.notifier)
                                    .fetchProducts(loadMore: true);
                              }

                              return HorizontalProductCard(
                                product: products[i],
                              );
                            }

                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: Center(
                                child: CupertinoActivityIndicator(
                                  color: AppColors.primary,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
                error: (error, st) => Center(child: Text(error.toString())),
                loading: () {
                  return CupertinoActivityIndicator(color: AppColors.primary);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
