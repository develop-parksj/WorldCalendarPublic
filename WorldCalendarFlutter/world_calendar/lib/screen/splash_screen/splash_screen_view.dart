import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:world_calendar/const/common.dart';
import 'package:world_calendar/l10n/l10n.dart';
import 'package:world_calendar/screen/splash_screen/splash_screen_view_model.dart';
import 'package:world_calendar/style/color_style.dart';
import 'package:world_calendar/style/text_style.dart';

class SplashScreenView extends HookConsumerWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    l10n = L10n.of(context)!;
    splashInitializeProvider = FutureProvider((ref) async {
      final SplashScreenViewModel splashScreenViewModel = ref.watch(splashScreenViewModelProvider);
      return await splashScreenViewModel.initialize(context);
    });

    return const Scaffold(
      body: SplashScreenViewBody(),
    );
  }
}

class SplashScreenViewBody extends HookConsumerWidget {
  const SplashScreenViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(splashInitializeProvider).when(
      loading: () => _mainBody(),
      error: (err, stack) => const TextStyleColor18w(
        text: 'error',
        color: ColorStyle.designRed,
      ),
      data: (_) {
        Future.delayed(const Duration(milliseconds: 300)).then((value) {
          final SplashScreenViewModel splashScreenViewModel = ref.watch(splashScreenViewModelProvider);
          if (context.mounted) {
            splashScreenViewModel.goToTop(context);
          }
        });

        return _mainBody();
      },
    );
  }

  Widget _mainBody() {
    return Center(
      child: Image.asset(
        getAssetsImagePath('app_icon'),
        width: 150,
        height: 150,
      ),
    );
  }
}