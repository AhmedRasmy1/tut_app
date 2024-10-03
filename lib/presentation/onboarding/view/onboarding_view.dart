// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/presentation/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  final OnboardingViewModel _onboardingViewModel = OnboardingViewModel();

  @override
  void initState() {
    _bind(); // استدعاء _bind() هنا لربط الـ ViewModel
    super.initState();
  }

  _bind() {
    _onboardingViewModel.start();
  }

  @override
  void dispose() {
    _onboardingViewModel
        .dispose(); // استدعاء dispose هنا لإغلاق الـ ViewModel بشكل صحيح
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        stream: _onboardingViewModel.outputSliderViewObject,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return _getContentWidget(snapShot.data as SliderViewObject);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _getContentWidget(SliderViewObject sliderViewObject) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: sliderViewObject.numOfSlides,
        onPageChanged: (index) {
          if (mounted) {
            _onboardingViewModel.onPageChange(index);
          }
        },
        itemBuilder: (context, index) {
          return OnBoardingPage(sliderObject: sliderViewObject.sliderObject);
        },
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    RoutesManager.loginRoute,
                  );
                },
                child: Text(
                  textAlign: TextAlign.end,
                  AppStrings.onBoardingSKip,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
            OnboardingBottomSheet(
              // تغيير اسم الـ Widget لتجنب التضارب
              sliders: sliderViewObject.numOfSlides,
              currentIndex: sliderViewObject.currentIndex,
              controller: _pageController,
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.sliderObject,
  });
  final SliderObject sliderObject;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p72),
            child: Text(
              sliderObject.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          const SizedBox(height: AppSize.s9),
          Text(
            sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSize.s74),
          SvgPicture.asset(sliderObject.image),
        ],
      ),
    );
  }
}

class OnboardingBottomSheet extends StatefulWidget {
  // تغيير اسم الـ Widget لتجنب التضارب
  const OnboardingBottomSheet({
    super.key,
    required this.sliders,
    required this.currentIndex,
    this.controller,
  });
  final int sliders; // تعديل النوع ليتماشى مع البيانات المستخدمة
  final int currentIndex;
  final PageController? controller;

  @override
  State<OnboardingBottomSheet> createState() => _OnboardingBottomSheetState();
}

class _OnboardingBottomSheetState extends State<OnboardingBottomSheet> {
  final OnboardingViewModel _onboardingViewModel = OnboardingViewModel();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //! left arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: GestureDetector(
                child: SvgPicture.asset(ImageAssets.leftArrowIc),
                onTap: () {
                  setState(() {
                    _onboardingViewModel.goPrevious();
                    widget.controller?.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  });
                },
              ),
            ),
          ),
          //! circle indicator
          Row(
            children: [
              for (int i = 0;
                  i < widget.sliders;
                  i++) // تعديل النوع ليتماشى مع البيانات
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: getProperCircle(i, widget.currentIndex),
                ),
            ],
          ),
          //! right arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: GestureDetector(
                child: SvgPicture.asset(ImageAssets.rightArrowIc),
                onTap: () {
                  setState(() {
                    _onboardingViewModel.goNext();
                    widget.controller?.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getProperCircle(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc);
    } else {
      return SvgPicture.asset(ImageAssets.solidCircleIc);
    }
  }

  @override
  void dispose() {
    _onboardingViewModel.dispose();
    super.dispose();
  }
}
