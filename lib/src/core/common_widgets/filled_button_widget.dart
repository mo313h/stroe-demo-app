import 'package:flutter/material.dart';

class FilledButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final Color? backgroundColor, textColor;
  final Color? borderColor;
  final String title;
  final bool isIcon;
  final double? borderRadius;
  final bool isLoading;
  final Widget? endWidget;
  final Widget? child;
  final double? height;
  const FilledButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.isIcon = false,
    this.borderRadius,
    this.isLoading = false,
    this.endWidget,
    this.child,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 0),
        shape: borderRadius != null
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
              )
            : null,
        fixedSize: Size.fromHeight(height ?? 48),
        backgroundColor: backgroundColor,
        side: borderColor == null
            ? BorderSide.none
            : BorderSide(color: borderColor!),
      ),
      onPressed: onPressed,
      child: isLoading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          : child ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,

                        fontWeight: FontWeight.bold,
                        color: textColor,
                        // color: Color(0xffAAAAAA),
                      ),
                    ),
                    if (endWidget != null) ...[Spacer(), endWidget!],
                  ],
                ),
    );
  }
}
