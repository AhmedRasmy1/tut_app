abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  // shared variables and functions that will be used through any view model
}

abstract class BaseViewModelInputs {
  void start(); // start view model job

  void dispose(); // will be called when view model is no longer used
}

mixin class BaseViewModelOutputs {}
