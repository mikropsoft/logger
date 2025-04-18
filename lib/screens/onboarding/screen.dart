import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/core/app_core.dart';
import 'package:logger/providers/shared_preferences_providers/onboarding_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({
    super.key,
  });

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController(viewportFraction: 1, keepPage: true);
  int currentIndex = 0;

  void finishOnboarding(context) {
    ref.read(onboardingProvider.notifier).markComplete();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AppInitializer(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = <OnBoardingScreenItem>[
      OnBoardingScreenItem(
        imageName: "4.png",
        title: AppLocalizations.of(context).onboardingScreenOneTitle,
        subtitle: AppLocalizations.of(context).onboardingScreenOneSubtitle,
      ),
      OnBoardingScreenItem(
        imageName: "1.png",
        title: AppLocalizations.of(context).onboardingScreenTwoTitle,
        subtitle: AppLocalizations.of(context).onboardingScreenTwoSubtitle,
      ),
      OnBoardingScreenItem(
        imageName: "2.png",
        title: AppLocalizations.of(context).onboardingScreenThreeTitle,
        subtitle: AppLocalizations.of(context).onboardingScreenThreeSubtitle,
      ),
      OnBoardingScreenItem(
        imageName: "3.png",
        title: AppLocalizations.of(context).onboardingScreenFourTitle,
        subtitle: AppLocalizations.of(context).onboardingScreenFourSubtitle,
      ),
    ];

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                padEnds: false,
                controller: _controller,
                itemCount: pages.length,
                itemBuilder: (_, index) {
                  return pages[index % pages.length];
                },
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: pages.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 8.0,
                dotWidth: 8.0,
                dotColor: Color.fromARGB(255, 220, 211, 238),
                activeDotColor: Color.fromARGB(255, 175, 138, 255),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (currentIndex != pages.length - 1) {
                      currentIndex += 1;
                      _controller.animateToPage(
                        currentIndex,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInSine,
                      );
                    } else {
                      finishOnboarding(context);
                    }
                  },
                  child: Text(
                    currentIndex == 0
                        ? AppLocalizations.of(context).getStartedText
                        : currentIndex == pages.length - 1
                            ? AppLocalizations.of(context).exploreNowText
                            : AppLocalizations.of(context).nextText,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                OutlinedButton(
                  onPressed: currentIndex != pages.length - 1
                      ? () {
                          finishOnboarding(context);
                        }
                      : null,
                  child: Text(
                    AppLocalizations.of(context).skipText,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}

class OnBoardingScreenItem extends StatelessWidget {
  final String imageName, subtitle, title;
  final bool useImageNameAsPath;

  const OnBoardingScreenItem({
    super.key,
    required this.imageName,
    required this.title,
    required this.subtitle,
    this.useImageNameAsPath = false,
  });

  @override
  Widget build(BuildContext context) {
    final lookupDirName =
        Theme.of(context).brightness == Brightness.dark ? "dark" : "light";
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FittedBox(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            height: MediaQuery.of(context).size.height * 0.3,
            child: Image.asset(
              useImageNameAsPath
                  ? imageName
                  : "assets/images/on_boarding/$lookupDirName/$imageName",
            ),
          ),
        ),
        Column(children: [
          FittedBox(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 18.0,
              color: isDarkTheme ? Colors.grey : Colors.black87,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ]),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
