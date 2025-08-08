import 'package:flutter/widgets.dart';

class ResponsiveSizeService extends WidgetsBindingObserver {
  // Private constructor without auto-initialization
  ResponsiveSizeService._internal();

  // Singleton instance
  static final ResponsiveSizeService instance = ResponsiveSizeService._internal();

  Size _screenSize = Size.zero;
  final _listeners = <VoidCallback>[];
  bool _isInitialized = false;

  /// Initialize the service and start listening to size changes
  void init() {
    if (_isInitialized) {
      return;
    }

    _updateScreenSize();
    WidgetsBinding.instance.addObserver(this);
    _isInitialized = true;
  }

  void _updateScreenSize() {
    final window = WidgetsBinding.instance.platformDispatcher.views.first;
    final newSize = window.physicalSize / window.devicePixelRatio;

    if (_screenSize != newSize) {
      _screenSize = newSize;
      _notifyListeners();
    }
  }

  void _notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  Size get screenSize {
    if (!_isInitialized) {
      throw StateError('ResponsiveSizeService must be initialized with init() before use');
    }
    return _screenSize;
  }

  @override
  void didChangeMetrics() {
    _updateScreenSize();
    super.didChangeMetrics();
  }

  void dispose() {
    if (!_isInitialized) {
      return;
    }

    WidgetsBinding.instance.removeObserver(this);
    _listeners.clear();
    _isInitialized = false;
  }
}
