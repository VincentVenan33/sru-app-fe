import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sru/core/view_models/base_view_model.dart';

class ViewModel<T extends BaseViewModel> extends ConsumerStatefulWidget {
  const ViewModel({
    required this.model,
    this.onModelReady,
    required this.builder,
    this.child,
    this.onRetry,
    Key? key,
  }) : super(key: key);

  final Widget Function(
    BuildContext context,
    T model,
    Widget? child,
  ) builder;
  final T model;
  final Widget? child;
  final void Function(T)? onModelReady;
  final void Function(T)? onRetry;

  @override
  ConsumerState<ViewModel<T>> createState() => _ViewModelState<T>();
}

class _ViewModelState<T extends BaseViewModel> extends ConsumerState<ViewModel<T>> {
  // ignore: prefer_typing_uninitialized_variables
  late final _providerRef;
  @override
  void initState() {
    _providerRef = ChangeNotifierProvider<T>(
      (_) => widget.model,
    );
    final T model = widget.model;

    widget.onModelReady?.call(model);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return widget.builder(context, ref.watch(_providerRef), widget.child);
      },
    );
  }
}
