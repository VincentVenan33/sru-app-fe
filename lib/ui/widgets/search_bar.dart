import 'package:flutter/material.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/utilities/text_styles.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    required this.controller,
    this.enableFocusBorder = true,
    this.hintText,
    this.onChanged,
    this.onFieldSubmitted,
    this.padding,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final bool enableFocusBorder;
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final EdgeInsets? padding;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final FocusNode _focus = FocusNode();
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    if (widget.enableFocusBorder) {
      _focus.addListener(_onFocusChange);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.enableFocusBorder) {
      _focus.removeListener(_onFocusChange);
      _focus.dispose();
    }
  }

  void _onFocusChange() {
    if (_focus.hasFocus) {
      setState(() {
        _isSelected = true;
      });
      return;
    }
    setState(() {
      _isSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: _isSelected ? 2 : 0,
            color: _isSelected ? Colors.blue : MjkColor.lightBlack002,
          ),
        ),
        margin: EdgeInsets.all(!_isSelected ? 1 : 0),
        padding: EdgeInsets.all(_isSelected ? 15 : 16),
        child: TextFormField(
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          focusNode: _focus,
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            isDense: true,
            border: InputBorder.none,
            hintStyle: buildTextStyle(
              fontHeight: 16.08,
              fontSize: 13,
              fontWeight: 400,
              color: MjkColor.lightBlack002,
            ),
            icon: const Icon(
              Icons.search,
              size: 16,
            ),
            contentPadding: EdgeInsets.zero,
          ),
          style: buildTextStyle(
            fontSize: 13,
            fontHeight: 16.08,
            fontWeight: 400,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
