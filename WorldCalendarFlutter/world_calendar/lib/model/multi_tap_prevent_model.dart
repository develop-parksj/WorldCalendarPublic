class MultiTapPreventModel {
  static final MultiTapPreventModel _model = MultiTapPreventModel(isTapped: false);
  static MultiTapPreventModel get instance => _model;

  bool _isTapped = false;
  bool get isTapped => _isTapped;

  MultiTapPreventModel({
    required bool isTapped,
  }):
        _isTapped = isTapped;

  void setIsTapped(bool isTapped) {
    _isTapped = isTapped;
  }
}