import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store_demo/src/core/common_widgets/filled_button_widget.dart';
import 'package:store_demo/src/core/common_widgets/inputs/app_textfield.dart';
import 'package:store_demo/src/core/constants/app_sizes.dart';
import 'package:store_demo/src/features/auth/controller/auth_controller.dart';
import 'package:store_demo/src/features/dashboard/presentation/views/main_dashboard_view.dart';

class AuthView extends ConsumerStatefulWidget {
  const AuthView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool? checkValue = false;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "emilys");
    _passwordController = TextEditingController(text: "emilyspass");
    _tabController = TabController(length: 2, vsync: this);
    _emailController.addListener(_updateState);
    _passwordController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);
    ref.listen<AsyncValue<void>>(authControllerProvider, (previous, next) {
      if (next is AsyncData && next.value == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainDashboardView()),
        );
      }
      if (next is AsyncError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }
    });
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset('assets/images/Vector (1).png'),

                  const SizedBox(height: 16),

                  const Text(
                    'Replaced by text',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 32),
                  ),

                  const Text(
                    'Placeholder text area',
                    style: TextStyle(
                      color: Color(0xff6C7278),
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 4,
                    ),
                    child: TabBar(
                      controller: _tabController,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: const Color(0xffEC441E),
                      unselectedLabelColor: const Color(0xff7D7D91),
                      tabs: const [
                        Tab(text: 'Login'),
                        Tab(text: 'Sign up'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    height: 160,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email'),
                            gapH4,
                            AppTextField(controller: _emailController),
                            gapH16,
                            Text('password'),
                            gapH4,
                            AppTextField(
                              isPassword: true,
                              controller: _passwordController,
                            ),
                          ],
                        ),

                        Column(children: const [Text('Sign up!')]),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        side: const BorderSide(
                          color: Color(0xff6C7278),
                          width: 2,
                        ),
                        value: checkValue,
                        onChanged: (value) {
                          setState(() {
                            checkValue = value;
                          });
                        },
                      ),
                      Spacer(),
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color(0xffEC441E),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  FilledButtonWidget(
                    isLoading: state.isLoading,

                    onPressed:
                        _emailController.text.isEmpty ||
                            _passwordController.text.isEmpty
                        ? null
                        : () {
                            ref
                                .read(authControllerProvider.notifier)
                                .login(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                          },
                    title: 'Log in',
                  ),
                  gapH16,
                  Consumer(
                    builder: (context, ref, _) {
                      return FilledButtonWidget(
                        borderRadius: 10,
                        borderColor: Color(0xffEFF0F6),

                        backgroundColor: Colors.transparent,
                        onPressed: () {},
                        title: '',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            SvgPicture.asset('assets/icons/google.svg'),
                            gapW4,
                            Text(
                              'Continue with Google',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  gapH16,
                  FilledButtonWidget(
                    borderRadius: 10,
                    borderColor: Color(0xffEFF0F6),
                    backgroundColor: Colors.transparent,
                    onPressed: () {},
                    title: '',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/2021_Facebook_icon 1.svg',
                        ),
                        gapW4,
                        Text(
                          'Continue with Facebook',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
