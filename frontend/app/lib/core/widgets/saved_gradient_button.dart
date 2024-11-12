import 'package:app/core/extension/extension.dart';
import 'package:app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class SavedGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onClick;
  const SavedGradientButton({
    super.key,
    required this.buttonText,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.isMobile
          ? context.responsiveWidth(100)
          : context.responsiveWidth(100),
      height: context.isMobile
          ? context.responsiveWidth(12)
          : context.responsiveWidth(3.5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppPallete.gradient1,
            AppPallete.gradient2,
            // AppPallete.gradient3,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppPallete.backgroundColor),
        ),
      ),
    );
  }
}
