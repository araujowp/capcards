import 'package:capcards/components/app_service.dart';
import 'package:capcards/components/cap_text.dart';
import 'package:flutter/material.dart';

class CapScaffold extends StatelessWidget {
  final Widget body;
  final String appBarText;
  final String? appBarSubText;
  final List<Widget>? appBarActions;
  final bool extendBodyBehindAppBar;
  final EdgeInsets? padding;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomInset;

  const CapScaffold({
    super.key,
    required this.body,
    required this.appBarText,
    this.appBarSubText,
    this.appBarActions,
    this.extendBodyBehindAppBar = true,
    this.padding,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(appBarText, style: const TextStyle(color: Colors.white)),
            if (appBarSubText != null)
              CapText(appBarSubText!, color: Colors.yellow),
          ],
        ),
        actions: appBarActions,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      extendBody: true,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: ValueListenableBuilder<String>(
        valueListenable: AppSettings.backgroundImage,
        builder: (context, background, child) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(background),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            child: padding != null
                ? Padding(padding: padding!, child: body)
                : body,
          );
        },
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
