import 'package:flutter/material.dart';
import 'package:tiktok_v2/constants/sizes.dart';

class FormButton extends StatelessWidget {
  final bool disabled;
  final String? text;

  const FormButton({
    super.key,
    required this.disabled,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
        decoration: BoxDecoration(
          color:
              disabled ? Colors.grey.shade300 : Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(
            Sizes.size2,
          ),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: TextStyle(
            color: disabled ? Colors.grey.shade500 : Colors.white,
            fontWeight: FontWeight.w600,
          ),
          child: Text(
            text ?? 'Next',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
