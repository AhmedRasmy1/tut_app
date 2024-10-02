// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  late final List<SliderObject> _sliders = getSliderData();

  List<SliderObject> getSliderData() => [
        SliderObject(
          title: AppStrings.onBoardingTitle1,
          subTitle: AppStrings.onBoardingSubTitle1,
          image: ImageAssets.onBoardingLogo1,
        ),
        SliderObject(
          title: AppStrings.onBoardingTitle2,
          subTitle: AppStrings.onBoardingSubTitle2,
          image: ImageAssets.onBoardingLogo2,
        ),
        SliderObject(
          title: AppStrings.onBoardingTitle3,
          subTitle: AppStrings.onBoardingSubTitle3,
          image: ImageAssets.onBoardingLogo3,
        ),
        SliderObject(
          title: AppStrings.onBoardingTitle4,
          subTitle: AppStrings.onBoardingSubTitle4,
          image: ImageAssets.onBoardingLogo4,
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _sliders.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return OnBoardingPage(sliderObject: _sliders[index]);
        },
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        height: AppSize.s100,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  textAlign: TextAlign.end,
                  AppStrings.onBoardingSKip,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
            BottomSheet(
              sliders: _sliders,
              currentIndex: _currentIndex,
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

class SliderObject {
  String title;
  String subTitle;
  String image;
  SliderObject({
    required this.title,
    required this.subTitle,
    required this.image,
  });
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({
    super.key,
    required this.sliders,
    required this.currentIndex,
  });
  final List<SliderObject> sliders;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
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
            ),
          ),
        ),
        //! circle indicator
        Row(
          children: [
            for (int i = 0; i < sliders.length; i++)
              Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: getProperCircle(i, currentIndex),
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
              child: SvgPicture.asset(ImageAssets.leftArrowIc),
            ),
          ),
        ),
      ],
    );
  }

  Widget getProperCircle(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc);
    } else {
      return SvgPicture.asset(ImageAssets.solidCircleIc);
    }
  }
}
