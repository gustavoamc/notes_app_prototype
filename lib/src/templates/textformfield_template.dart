import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldTemplate extends StatefulWidget {
  const TextFormFieldTemplate({
    super.key,
    this.autofocus = false,
    this.label,
    this.initialValue,
    this.controller,
    this.validator,
    this.onTap,
    this.onSaved,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.helperText,
    required this.placeholderText,
    this.prefix,
    this.prefixIcon,
    this.prefixText,
    this.suffix,
    this.suffixIcon,
    this.suffixText,
    this.minLines = 1,
    this.maxLines = 1,
    this.isObscure = false,
    this.isEnabled = true,
    this.textInputAction,
    this.inputFormatters,
  });

  final bool autofocus;
  final String? helperText;
  final String placeholderText;
  final Widget? prefix;
  final Widget? prefixIcon;
  final String? prefixText;
  final Widget? suffix;
  final Widget? suffixIcon;
  final String? suffixText;
  final int minLines;
  final int maxLines;
  final String? label;
  final String? initialValue;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  final VoidCallback? onEditingComplete;
  final void Function(String?)? onFieldSubmitted;
  final bool isObscure;
  final bool isEnabled;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<TextFormFieldTemplate> createState() => _TextFormFieldTemplateState();
}

class _TextFormFieldTemplateState extends State<TextFormFieldTemplate> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autofocus,
      controller: widget.controller,
      onTap: widget.onTap,
      onSaved: widget.onSaved,
      onFieldSubmitted: widget.onFieldSubmitted,
      onEditingComplete: widget.onEditingComplete,
      obscureText: widget.isObscure,
      inputFormatters: widget.inputFormatters,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: widget.initialValue,
      validator: widget.validator,
      minLines: widget.isObscure ? 1 : widget.minLines,
      maxLines: widget.isObscure ? 1 : widget.maxLines,
      decoration: InputDecoration(
        filled: true,
        enabled: widget.isEnabled,
        alignLabelWithHint: true,
        helperText: widget.helperText,
        hintText: widget.placeholderText,
        prefix: widget.prefix,
        prefixIcon: widget.prefixIcon,
        prefixText: widget.prefixText,
        suffix: widget.suffix,
        suffixIcon: widget.suffixIcon,
        suffixText: widget.suffixText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        labelText: widget.label,
      ),
    );
  }
}
