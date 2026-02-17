import 'package:flutter/material.dart';

class CapScaffold extends StatelessWidget {
  final Widget body;
  final String appBarText;
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
        title: Text(
          appBarText,
          style: const TextStyle(color: Colors.white),
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundapp.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.center,
            // Descomente se quiser escurecer a imagem para melhor legibilidade do texto:
            // colorFilter: ColorFilter.mode(
            //   Colors.black.withOpacity(0.25),
            //   BlendMode.darken,
            // ),
          ),
        ),
        child: padding != null
            ? Padding(
                padding: padding!,
                child: body,
              )
            : body,
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
