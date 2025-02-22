import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.fillColor,
    this.keyboardType,
    this.obscureText = false,
    this.maxLength,
    this.maxLines,
    this.errorText,
    this.textAlign,
    this.prefix,
    this.enabled,
    this.borderColor,
    this.onTap,
    this.prefixIcon,
    this.labelText,
    this.focusNode,
    this.validator,
    this.onChanged,
    this.minLines,
    this.style,
    this.autofocus,
    this.enableFocusBorder = false,
    this.inputFormatters,
    this.expands = false,
    this.buildCounter,
    this.textAlignVertical,
  });
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final String? errorText;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? prefixIcon;
  final bool obscureText;
  final bool expands;
  final bool? enabled;
  final bool? autofocus;
  final bool enableFocusBorder;
  final FocusNode? focusNode;
  final Color? fillColor;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final TextStyle? style;
  final TextAlignVertical? textAlignVertical;
  final TextAlign? textAlign;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Widget? Function(BuildContext,
      {required int currentLength,
      required bool isFocused,
      required int? maxLength})? buildCounter;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: TextFormField(
        autofocus: widget.autofocus ?? false,
        textAlignVertical: widget.textAlignVertical,
        buildCounter: widget.buildCounter,
        expands: widget.expands,
        enabled: widget.enabled,
        controller: widget.controller,
        textAlign: widget.textAlign ?? TextAlign.start,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        cursorColor: Colors.deepPurple,
        maxLines: widget.maxLines ?? 1,
        minLines: widget.minLines ?? 1,
        maxLength: widget.maxLength,
        focusNode: widget.focusNode,
        style: widget.style ??
            TextStyle(color: Colors.black87),
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        autofillHints: const [AutofillHints.email],
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          prefix: widget.prefix,
          prefixIcon: widget.prefixIcon,
          fillColor: widget.fillColor ?? Colors.white70,
          filled: true,
          labelText: widget.labelText,
          suffixIconConstraints:
          const BoxConstraints(maxHeight: 40, minWidth: 5),
          errorText: widget.errorText,
          border: InputBorder.none,
          focusedBorder: widget.enableFocusBorder
              ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: widget.borderColor ?? Colors.deepPurple,
            ),
          )
              : InputBorder.none,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey.shade100),
          suffixIcon: widget.suffixIcon,
        ),
      ),
    );
  }
}
