import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store_demo/src/features/home/presentation/views/home_view.dart';

final bottomNavIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

class MainDashboardView extends ConsumerWidget {
  const MainDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    final pages = [
      const HomeView(),
      const SizedBox.shrink(),
      const SizedBox.shrink(),
      const SizedBox.shrink(),
    ];
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: BottomAppBar(
          color: Colors.white,
          elevation: 0, // نجعل الارتفاع 0 لأننا سنستخدم Border مخصص
          padding: EdgeInsets.zero,

          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BuildNavItem(
                  'assets/icons/home.svg',
                  'Home',
                  0,
                  onTap: () =>
                      ref.read(bottomNavIndexProvider.notifier).state = 0,
                ),
                BuildNavItem(
                  'assets/icons/Vector.svg',
                  'Search',
                  1,
                  onTap: () =>
                      ref.read(bottomNavIndexProvider.notifier).state = 1,
                ),
                BuildNavItem(
                  'assets/icons/cart.svg',
                  'Cart',
                  2,
                  onTap: () =>
                      ref.read(bottomNavIndexProvider.notifier).state = 2,
                ),
                BuildNavItem(
                  'assets/icons/person.svg',
                  'Profile',
                  3,
                  onTap: () =>
                      ref.read(bottomNavIndexProvider.notifier).state = 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuildNavItem extends ConsumerWidget {
  const BuildNavItem(
    this.assetPath,
    this.label,
    this.itemIndex, {
    required this.onTap,
    super.key,
  });

  final String assetPath;
  final String label;
  final int itemIndex;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);
    final isActive = currentIndex == itemIndex;
    final color = isActive ? const Color(0xffEC441E) : const Color(0xff4D515B);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            assetPath,
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
