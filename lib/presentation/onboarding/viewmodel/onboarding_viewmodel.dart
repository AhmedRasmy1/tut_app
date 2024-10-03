// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:tut_app/domain/models.dart';
import 'package:tut_app/presentation/base/baseviewmodel.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';

class OnboardingViewModel extends BaseViewModel
    with OnboardingViewmodelInputs, OnboardingViewmodelOutputs {
  final StreamController<SliderViewObject> _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _sliders;
  late int _currentIndex = 0;

  // onboarding view model inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _sliders = getSliderData();
    _pushDataToView();
  }

  @override
  int goNext() {
    if (_currentIndex < _sliders.length - 1) {
      _currentIndex++;
    }
    _pushDataToView();
    return _currentIndex;
  }

  @override
  int goPrevious() {
    if (_currentIndex > 0) {
      _currentIndex--;
    } else {
      _currentIndex = _sliders.length - 1;
    }
    _pushDataToView();
    return _currentIndex;
  }

  @override
  void onPageChange(int index) {
    _currentIndex = index;
    _pushDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  // onboarding view model outputs
  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream;

  void _pushDataToView() {
    inputSliderViewObject.add(
      SliderViewObject(
        sliderObject: _sliders[_currentIndex],
        numOfSlides: _sliders.length,
        currentIndex: _currentIndex,
      ),
    );
  }

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
}

abstract mixin class OnboardingViewmodelInputs {
  // onboarding view model inputs
  int goNext();
  int goPrevious();
  void onPageChange(int index);
  // stream controller input
  Sink get inputSliderViewObject;
}

abstract mixin class OnboardingViewmodelOutputs {
  // stream controller output
  Stream<SliderViewObject> get outputSliderViewObject;
}
