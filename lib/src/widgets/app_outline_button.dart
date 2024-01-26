import 'package:flutter/material.dart';

class AppOutlineButton extends StatelessWidget {
  const AppOutlineButton({
    super.key,
    this.color,
    this.onTap,
    this.content,
    this.colorContent,
  });
  final Color? color;
  final Function()? onTap;
  final String? content;
  final Color? colorContent;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: color ?? Colors.amber),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Text(
            content ?? '',
            style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )
          //  Paragraph(
          //   content: content,
          //   textAlign: TextAlign.center,
          //   style: STYLE_MEDIUM.copyWith(
          //     color: color ?? AppColors.PRIMARY_PURPLE,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          ),
    );
  }
}
