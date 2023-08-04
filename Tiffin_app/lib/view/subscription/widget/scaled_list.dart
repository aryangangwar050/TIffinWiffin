import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';

class ScaledList extends StatefulWidget {
  const ScaledList({
    Key key,
    @required this.itemBuilder,
    @required this.itemCount,
    @required this.itemColor,
    this.showDots = true,
    this.cardWidthRatio = 0.6,
    this.marginWidthRatio = 0.1,
    this.selectedCardHeight = 100,
    this.unSelectedCardHeight = 80,
  })  : assert(cardWidthRatio + marginWidthRatio >= 0.5,
            " Card width + margin width should exceed 0.5 of the screen"),
        assert(selectedCardHeight > unSelectedCardHeight,
            " selectedCardHeight should alwayes excceed the unSelectedCardHeight to show desire effect");

  final Widget Function(int index, int selectedIndex) itemBuilder;
  final int itemCount;
  final Color Function(int index) itemColor;
  final bool showDots;
  final double cardWidthRatio;
  final double marginWidthRatio;
  final double selectedCardHeight;
  final double unSelectedCardHeight;

  @override
  _ScaledListState createState() => _ScaledListState();
}

class _ScaledListState extends State<ScaledList> {
  ScrollController _scrollController;
  int _selectedIndex = 0;

  double parentWidth;
  double parentHeight;

  @override
  void initState() {
    _scrollController = ScrollController();
    final double fullCardWidth =
        widget.cardWidthRatio + widget.marginWidthRatio;
    _scrollController.addListener(() {
      final double offset = _scrollController.offset;
      double deltaReverse =
          (((_selectedIndex + 2) * fullCardWidth) - 1) * parentWidth;

      double deltaForward =
          (((_selectedIndex - 1) * (fullCardWidth)) + widget.marginWidthRatio) *
              parentWidth;

      if (offset > deltaReverse &&
          _scrollController.position.userScrollDirection ==
              ScrollDirection.reverse) {
        setState(() {
          _selectedIndex += 1;
        });
      }
      if (offset < deltaForward &&
          _scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
        setState(() {
          _selectedIndex -= 1;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: LayoutBuilder(builder: (context, constraints) {
        parentWidth = constraints.maxWidth;
        parentHeight = constraints.maxHeight;
        if (parentHeight == double.infinity) {
          final mediaQuery = MediaQuery.of(context);
          parentHeight = mediaQuery.size.height;
        }
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: Duration(seconds: 2),
                curve: Curves.fastOutSlowIn,
                height: size.width > 360 && size.height > 700
                    ? parentHeight / 1.29
                    : parentHeight / 1.23,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.itemCount,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        if (index == 0) ...[
                          SizedBox(
                              width: parentWidth * widget.marginWidthRatio),
                        ],
                        Stack(
                          children: [
                            Container(
                              width: parentWidth * widget.cardWidthRatio,
                              height: _selectedIndex == index
                                  ? widget.selectedCardHeight
                                  : widget.unSelectedCardHeight,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10,
                                    offset: Offset(0, 7),
                                    color: widget
                                        .itemColor(index)
                                        .withOpacity(0.7),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(20),
                                color: widget.itemColor(index),
                              ),
                            ),
                            Positioned(
                                right: 0,
                                bottom: 0,
                                top: 0,
                                child: CustomPaint(
                                  size: Size(
                                    parentWidth * widget.cardWidthRatio,
                                    _selectedIndex == index
                                        ? widget.selectedCardHeight
                                        : widget.unSelectedCardHeight,
                                  ),
                                  painter: CustomCardPainter(
                                      radius: 20,
                                      startColor: widget.itemColor(index),
                                      endColor: widget.itemColor(index)),
                                )),
                            Positioned.fill(
                                child:
                                    widget.itemBuilder(index, _selectedIndex))
                          ],
                        ),
                        SizedBox(width: parentWidth * widget.marginWidthRatio)
                      ],
                    );
                  },
                ),
              ),
              if (widget.showDots) ...[
                SizedBox(
                    height: size.width > 360 && size.height > 700
                        ? parentHeight * 0.1
                        : parentHeight * 0.15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      widget.itemCount, (index) => buildDot(index)),
                ),
              ]
            ],
          ),
        );
      }),
    );
  }

  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: parentHeight * 0.01,
      margin: EdgeInsets.all(parentWidth * 0.01),
      width: _selectedIndex == index ? parentWidth * 0.05 : parentWidth * 0.015,
      decoration: BoxDecoration(
          color: index == _selectedIndex
              ? widget.itemColor(index)
              : Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}

// Custom Card Painter to draw a curved Paint on the card
class CustomCardPainter extends CustomPainter {
  final Color startColor, endColor;
  final double radius;

  CustomCardPainter({
    @required this.startColor,
    @required this.endColor,
    @required this.radius,
  });
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - radius, 0)
      ..quadraticBezierTo(size.width, 0, radius, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
