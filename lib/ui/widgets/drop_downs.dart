import 'package:flutter/material.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/utilities/text_styles.dart';
import 'package:mjk_apps/ui/shared/spacings.dart';

class SabpDropDown extends StatelessWidget {
  const SabpDropDown({
    this.label,
    this.noDataText = '',
    this.currentText = '',
    this.onTap,
    this.fontSize = 16,
    this.errorText,
    super.key,
  });

  final String? label;
  final String noDataText;
  final String currentText;
  final double fontSize;
  final VoidCallback? onTap;
  final String? errorText;

  String get getText {
    if (currentText.isEmpty) {
      return noDataText;
    }
    return currentText;
  }

  bool get _hasError => errorText != null && errorText?.isNotEmpty == true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ..._buildLabel(),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 14,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: _hasError ? Colors.red : MjkColor.lightBlack002,
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    getText,
                    style: buildTextStyle(
                      fontSize: fontSize,
                      fontWeight: 400,
                      color: MjkColor.lightBlack002,
                    ),
                  ),
                ),
                Spacings.horSpace(16),
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        if (errorText != null) ...<Widget>[
          Spacings.verSpace(8),
          Text(
            errorText ?? '',
            style: buildTextStyle(
              fontSize: 12,
              fontWeight: 400,
              color: const Color(0xFFFF1E1E),
            ),
          ),
        ],
      ],
    );
  }

  List<Widget> _buildLabel() {
    final List<Widget> widgets = <Widget>[];
    if (label != null) {
      widgets.addAll(
        <Widget>[
          Text(
            label ?? '',
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
}
