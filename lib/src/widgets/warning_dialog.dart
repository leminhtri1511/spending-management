import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'app_outline_button.dart';

class WarningOneDialog extends StatelessWidget {
  const WarningOneDialog({
    super.key,
    this.content,
    this.imagePng,
    this.title,
    this.buttonName,
    this.buttonColor,
    this.onTap,
    this.imageSvg,
    this.imageLottie,
    this.textEditingController,
  });
  final String? content;
  final String? title;
  final String? buttonName;
  final String? imagePng;
  final String? imageSvg;
  final String? imageLottie;
  final Color? buttonColor;
  final VoidCallback? onTap;
  final TextEditingController? textEditingController;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dynamic dialogContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        // vertical: 20.0,
        horizontal: 30,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(13),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imagePng != null)
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 35,
                  child: Image.asset(
                    imagePng ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              if (imageSvg != null)
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 5, 2, 2),
                  radius: 35,
                  child: SvgPicture.asset(imageSvg ?? ''),
                ),
              // if (imageLottie != null)
              //   SizedBox(
              //     height: 100,
              //     child: Lottie.asset(imageLottie ?? ''),
              //   ),
              const SizedBox(
                height: 10,
              ),
              // Paragraph(
              //   content: title,
              //   textAlign: TextAlign.center,
              //   style: STYLE_LARGE_BIG.copyWith(fontWeight: FontWeight.w600),
              // ),
              Text(
                title ?? '',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  content ?? '',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                //   Paragraph(
                //   content: content ?? '',
                //   textAlign: TextAlign.center,
                //   fontSize: 14,
                //   fontWeight: FontWeight.w500,
                // ),
              ),
              if (buttonName != null) const SizedBox(height: 10),
              if (buttonName != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: AppOutlineButton(
                    content: buttonName,
                    onTap: onTap,
                    color: buttonColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
