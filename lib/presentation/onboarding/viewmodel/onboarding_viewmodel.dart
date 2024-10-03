import 'package:tut_app/presentation/base/baseviewmodel.dart';

class OnboardingViewmodel extends BaseViewModel
    with OnboardingViewmodelInputs, OnboardingViewmodelOutputs {
  //onboarding view model inputs
  @override
  void dispose() {}

  @override
  void start() {}

  @override
  void goNext() {
    // TODO: implement goNext
  }

  @override
  void goPrevious() {
    // TODO: implement goPrevious
  }

  @override
  void onPageChange(int index) {
    // TODO: implement onPageChange
  }
}

mixin class OnboardingViewmodelInputs {
  //onboarding view model inputs
  void goNext() {
    // TODO: implement goNext
  }
  void goPrevious() {
    // TODO: implement goPrevious
  }
  void onPageChange(int index) {
    // TODO: implement onPageChange
  }
}

mixin class OnboardingViewmodelOutputs {}
