// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:yexah/web/const/const.dart';
import 'package:yexah/web/widgets/customer_intraction.dart';

import '../const/color.dart';
import '../screen/home_page.dart';

class DealsAtYexahBanner extends StatefulWidget {
  final bool isdarkk;
  final BuildContext ctx;
  const DealsAtYexahBanner({
    super.key,
    required this.isdarkk,
    required this.ctx,
  });

  @override
  State<DealsAtYexahBanner> createState() => _DealsAtYexahBannerState();
}

class _DealsAtYexahBannerState extends State<DealsAtYexahBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
            begin: ColorConst.secondary, end: Colors.yellow)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Align(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: ColorConst.scaffoldDarklite,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  initialtab = Tabz.deals;
                  print(initialtab);
                });
              },
              child: Container(
                width: isMobileView(context)
                    ? screenwidth(context) * 0.7
                    : screenwidth(context) * 0.32,
                decoration: BoxDecoration(
                  color: isdark
                      ? ColorConst.scaffoldDarklite
                      : ColorConst.greyishBackgroundColour,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ColorConst.secondary),
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/yexah_fire_percent_logo.png',
                      width: 85,
                      height: 85,
                      fit: BoxFit.contain,
                    ),
                    // FxBox.w4,
                    AnimatedBuilder(
                      animation: _colorAnimation,
                      builder: (context, child) {
                        return Text(
                          'Explore new Deals at Yexah !',
                          softWrap: true,
                          style: TextStyle(
                              color: _colorAnimation.value,
                              fontSize: isMobileView(context)
                                  ? screenwidth(context) * .03
                                  : screenwidth(context) * .017,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Nunito'
                              // overflow: TextOverflow.ellipsis,
                              ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
