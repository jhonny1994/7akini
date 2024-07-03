import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sevenakini_shared/features/core/utils/constants.dart';
import 'package:sevenakini_shared/features/core/utils/extensions.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({
    super.key,
    required this.message,
    this.isSimple = false,
  });

  final bool isSimple;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kDefaultPadding,
          child: Center(
            child: isSimple
                ? Text(
                    message,
                    style: context.textTheme.titleLarge,
                  )
                : Column(
                    children: [
                      const Spacer(flex: 2),
                      SizedBox(
                        height:
                            context.width * 0.75 - kDefaultPadding.horizontal,
                        width:
                            context.width * 0.75 - kDefaultPadding.horizontal,
                        child: SvgPicture.asset('assets/empty.svg'),
                      ),
                      const Spacer(),
                      Text(
                        message,
                        style: context.textTheme.titleLarge,
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
