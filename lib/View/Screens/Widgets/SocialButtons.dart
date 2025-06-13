// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialButtons extends StatelessWidget {
  final VoidCallback? onPressed;
  final FaIcon icon;
  final double size;
  final String TipMessage;
  final String Textname;
  SocialButtons({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.size,
    required this.TipMessage,
    required this.Textname,
  }) : super(key: key);

  @override
  build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Tooltip(
          preferBelow: true,
          message: TipMessage,
          child: IconButton(iconSize: size, onPressed: onPressed, icon: icon),
        ),
        Text(
          Textname,
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }
}
