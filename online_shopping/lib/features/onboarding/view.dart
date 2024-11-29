import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/routing/app_routes.dart';
import 'package:online_shopping/core/styles/styles.dart';
import 'package:online_shopping/features/onboarding/logic.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  int currentPage = 0;

  OnboardingLogic onboardingLogic = OnboardingLogic();

  void _onSkipPressed() {
    setState(() {
      // Go to the next page or reset if it's the last page
      if (currentPage < onboardingLogic.listOfImages.length - 1) {
        currentPage++;
        _pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        currentPage = 0;
        _pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50.dg),
                child: SizedBox(
                  height: 400.h,
                  width: 250.w,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: onboardingLogic.listOfImages.length,
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Image.asset(
                            onboardingLogic.listOfImages[index],
                            fit: BoxFit.contain,
                          ),
                          Text(
                            onboardingLogic.listOfQoutes[index],
                            style: AppTextStyles.font25blackRegular,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            SmoothPageIndicator(
              controller: _pageController,
              count: onboardingLogic.listOfImages.length,
              effect: WormEffect(
                dotHeight: 8.h,
                dotWidth: 14.w,
                type: WormType.thinUnderground,
              ),
            ),
            SizedBox(height: 130.h),
            Padding(
              padding: EdgeInsets.only(left: 15.h),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.login);
                    },
                    child: Text(
                      'Skip',
                      style: AppTextStyles.font25blackRegular,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
