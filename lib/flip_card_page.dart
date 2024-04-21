import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class FlipCardPage extends StatefulWidget {
  const FlipCardPage();

  @override
  _FlipCardPageState createState() => _FlipCardPageState();
}

class _FlipCardPageState extends State<FlipCardPage> {
  bool _toggler = true;

  @override
  void initState() {
    super.initState();
    // Start a timer to automatically flip the card every 3 seconds
    Timer.periodic(const Duration(seconds: 3), (_) {
      _onFlipCardPressed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          height: 300,
          width: 500,
          child: FlipCard(
            toggler: _toggler,
            frontCard: AppCard(title: 'assets/coming.gif',color:  Colors.black,),
            backCard: AppCard(title: 'assets/curb.png',color:  Color(0XFFDFFD08),),
          ),
        ),
      );

  }

  void _onFlipCardPressed() {
    setState(() {
      _toggler = !_toggler;
    });
  }
}

class AppCard extends StatelessWidget {
  final String title;
  final Color? color;

  const AppCard({
    required this.title, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: color,
      ),
      child: Center(
        child: Image.asset(title,fit: BoxFit.cover,)
      ),
    );
  }
}

class FlipCard extends StatelessWidget {
  final bool toggler;
  final Widget frontCard;
  final Widget backCard;

  const FlipCard({
    required this.toggler,
    required this.backCard,
    required this.frontCard,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: _transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.ease,
        switchOutCurve: Curves.ease.flipped,
        child: toggler
            ? SizedBox(key: const ValueKey('front'), child: frontCard)
            : SizedBox(key: const ValueKey('back'), child: backCard),
      ),
    );
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnimation = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnimation,
      child: widget,
      builder: (context, widget) {
        final isFront = ValueKey(toggler) == widget!.key;
        final rotationY = isFront ? rotateAnimation.value : min(rotateAnimation.value, pi * 0.5);
        return Transform(
          transform: Matrix4.rotationY(rotationY)..setEntry(3, 0, 0),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }
}
