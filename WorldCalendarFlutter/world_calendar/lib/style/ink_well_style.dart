import 'package:flutter/material.dart';

class InkWellDefaultStyle extends StatelessWidget {
  final VoidCallback? _onTap;
  final Widget _child;

  const InkWellDefaultStyle({
    super.key,
    VoidCallback? onTap,
    required Widget child,
  }):
        _onTap = onTap,
        _child = child;

  @override
  Widget build(BuildContext context) {
    return _onTap != null ? InkWell(
      onTap: _onTap,
      child: _child,
    ) : _child;
  }
}