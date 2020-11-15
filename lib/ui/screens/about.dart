import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';
class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseScreenMethod(
        title: "home.about",
        body: Container(
          color: Colors.red,
          alignment: Alignment.center,
          child: SpriteDemo(),
        ),
      ),
    );
  }
}
