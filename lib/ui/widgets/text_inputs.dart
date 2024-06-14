import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/utilities/text_styles.dart';
import 'package:mjk_apps/ui/shared/spacings.dart';

class MjkTextInput extends StatefulWidget {
  /// Don't use this factory method, instead use `MjkDatePicker` widget
  factory MjkTextInput.datePicker({
    required TextEditingController controller,
    String? hintText,
    String? label,
    Future<void> Function()? onTap,
  }) {
    return MjkTextInput(
      controller: controller,
      hintText: hintText,
      label: label,
      onTap: onTap,
      suffixIcon: const Padding(
        padding: EdgeInsets.all(16),
        child: Icon(
          Icons.calendar_month,
          size: 15,
          color: Colors.black,
        ),
      ),
      isDatePicker: true,
      disabled: true,
    );
  }

  factory MjkTextInput.money({
    required TextEditingController controller,
    required String prefixCurrency,
    String? hintText,
    String? label,
    Future<void> Function()? onTap,
    required void Function(String value) onChanged,
  }) {
    return MjkTextInput(
      controller: controller,
      hintText: hintText,
      label: label,
      onTap: onTap,
      onChanged: onChanged,
      prefixIcon: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
        child: Text(
          prefixCurrency,
          style: buildTextStyle(
            fontSize: 16,
            fontWeight: 400,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
  const MjkTextInput({
    Key? key,
    required this.controller,
    this.label,
    this.hintText,
    this.inputIcon,
    this.disabled = false,
    this.enableFocusBorder = true,
    this.enableObscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onTap,
    this.focusNode,
    this.maxLines = 1,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.enableThousandSeparator = true,
    this.validator,
    this.isDatePicker = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final Icon? inputIcon;
  final bool disabled;
  final bool enableFocusBorder;
  final bool enableObscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final int maxLines;
  final String? errorText;
  final TextInputType keyboardType;

  /// This field only works if keyboardType is number
  final bool enableThousandSeparator;

  /// This field will override `errorText` field
  final String? Function(String? value)? validator;

  // Dont touch this!
  final bool isDatePicker;

  @override
  State<MjkTextInput> createState() => _MjkTextInputState();
}

class _MjkTextInputState extends State<MjkTextInput> {
  bool _showPasswordEnabled = true;
  // ignore: unused_field
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ..._buildLabel(),
        GestureDetector(
          onTap: widget.onTap,
          child: TextFormField(
            focusNode: widget.focusNode,
            controller: widget.controller,
            enabled: !widget.disabled,
            obscureText: widget.enableObscureText && _showPasswordEnabled,
            maxLines: widget.maxLines,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.keyboardType == TextInputType.number
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    if (widget.enableThousandSeparator) ThousandSeparatorTextInputFormatter(),
                  ]
                : null,
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: widget.hintText,
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              border: widget.focusNode?.hasFocus == true
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                    )
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.red,
                      ),
                    ),
              hintStyle: buildTextStyle(
                fontSize: 16,
                fontHeight: 19.79,
                fontWeight: 400,
                color: Colors.grey,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 1,
                  color: MjkColor.primary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 1,
                  color: MjkColor.lightBlack002,
                ),
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.enableObscureText
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _showPasswordEnabled = !_showPasswordEnabled;
                        });
                      },
                      child: SizedBox(
                        height: 15,
                        child: _showPasswordEnabled ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                      ),
                    )
                  : SizedBox(
                      height: 15,
                      child: widget.suffixIcon,
                    ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 20,
              ),
            ),
            style: buildTextStyle(
              fontSize: 16,
              fontHeight: 19.79,
              fontWeight: 400,
              color: Colors.black,
            ),
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
        _buildErrorText(),
      ],
    );
  }

  List<Widget> _buildLabel() {
    final List<Widget> widgets = <Widget>[];
    if (widget.label != null) {
      widgets.addAll(
        <Widget>[
          Text(
            widget.label ?? '',
            style: buildTextStyle(
              fontSize: 14,
              fontWeight: 500,
              color: Colors.black,
            ),
          ),
          Spacings.verSpace(10),
        ],
      );
    }
    return widgets;
  }

  Widget _buildErrorText() {
    if (widget.errorText != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Spacings.verSpace(11),
          Text(
            widget.errorText ?? '',
            style: buildTextStyle(
              fontSize: 12,
              fontWeight: 400,
              color: const Color(0xFFFF1E1E),
            ),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}

class ThousandSeparatorTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      int selectionIndexFromTheRight = newValue.text.length - newValue.selection.extentOffset;
      List<String> chars = newValue.text.replaceAll(' ', '').split('');
      String newString = '';
      for (int i = 0; i < chars.length; i++) {
        if (i % 3 == 0 && i != 0) newString += '.';
        newString += chars[i];
      }

      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndexFromTheRight,
        ),
      );
    } else {
      return newValue;
    }
  }
}
