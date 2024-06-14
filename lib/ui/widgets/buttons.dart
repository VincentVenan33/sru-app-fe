import 'package:flutter/material.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';

enum ButtonType { primary, outlineBasic, secondary, cancel, negative, outlineNegative, test }

enum ButtonSize {
  small,
  medium,
  large,
}

extension ButtonTypeExt on ButtonType {
  static const Map<ButtonType, Color> backgroundColors = <ButtonType, Color>{
    ButtonType.primary: MjkColor.redPrimary,
    ButtonType.secondary: MjkColor.secondary,
  };
  Color get backgroundColor => backgroundColors[this]!;

  static const Map<ButtonType, Color> backgroundDisabledColors = <ButtonType, Color>{
    ButtonType.primary: MjkColor.lightBlack001,
    ButtonType.secondary: MjkColor.lightBlack001,
  };
  Color get backgroundDisabled => backgroundDisabledColors[this]!;

  static const Map<ButtonType, Color> backgroundPressedColors = <ButtonType, Color>{
    ButtonType.primary: MjkColor.redPrimary,
    ButtonType.secondary: MjkColor.secondary,
  };
  Color get backgroundPressedColor => backgroundPressedColors[this]!;

  static const Map<ButtonType, Color> foregroundColors = <ButtonType, Color>{
    ButtonType.primary: Colors.white,
    ButtonType.secondary: Colors.white,
  };
  Color get foregroundColor => foregroundColors[this]!;

  static const Map<ButtonType, Color> foregroundPressedColors = <ButtonType, Color>{
    ButtonType.primary: Colors.white,
    ButtonType.secondary: Colors.white,
  };
  Color get foregroundPressedColor => foregroundPressedColors[this]!;

  static const Map<ButtonType, Color> textColors = <ButtonType, Color>{
    ButtonType.primary: Colors.white,
    ButtonType.secondary: Colors.white,
  };
  Color? get textColor => textColors[this];

  static const Map<ButtonType, Color> disabledTextColors = <ButtonType, Color>{
    ButtonType.primary: MjkColor.lightBlack001,
    ButtonType.secondary: MjkColor.lightBlack001,
  };
  Color? get disabledTextColor => disabledTextColors[this];

  static const Map<ButtonType, FontWeight> fontWeights = <ButtonType, FontWeight>{
    ButtonType.primary: FontWeight.w600,
    ButtonType.secondary: FontWeight.w600,
  };
  FontWeight? get fontWeight => fontWeights[this];
}

extension ButtonSizeExt on ButtonSize {
  static const Map<ButtonSize, double> linkButtonHeights = <ButtonSize, double>{
    ButtonSize.small: 21,
    ButtonSize.medium: 24,
    ButtonSize.large: 24,
  };

  double get linkButtonHeight => linkButtonHeights[this]!;

  static const Map<ButtonSize, double> fontSizes = <ButtonSize, double>{
    ButtonSize.small: 14,
    ButtonSize.medium: 16,
    ButtonSize.large: 16,
  };

  double get fontSize => fontSizes[this]!;

  static const Map<ButtonSize, double> iconSizes = <ButtonSize, double>{
    ButtonSize.small: 18,
    ButtonSize.medium: 22,
    ButtonSize.large: 22,
  };

  double get iconSize => iconSizes[this]!;

  static const Map<ButtonSize, EdgeInsetsGeometry> paddings = <ButtonSize, EdgeInsetsGeometry>{
    ButtonSize.small: EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    ),
    ButtonSize.medium: EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 18,
    ),
    ButtonSize.large: EdgeInsets.symmetric(
      horizontal: 22,
      vertical: 26,
    ),
  };

  EdgeInsetsGeometry get padding => paddings[this]!;

  static const Map<ButtonSize, double> reducedHeights = <ButtonSize, double>{
    ButtonSize.small: 16,
    ButtonSize.medium: 24,
    ButtonSize.large: 24,
  };

  double get reducedHeight => reducedHeights[this]!;
}

const List<ButtonType> blackTextColorButtonTypeList = <ButtonType>[
  ButtonType.primary,
  ButtonType.cancel,
];

class Button extends StatelessWidget {
  const Button({
    required this.buttonType,
    required this.buttonSize,
    required this.text,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final ButtonType buttonType;
  final ButtonSize buttonSize;
  final String text;
  final VoidCallback? onTap;

  ButtonStyle createStyle(
      {required Color background,
      required Color backgroundDisabled,
      required Color backgroundPressed,
      required Color foreground,
      required Color foregroundDisabled,
      required Color foregroundPressed,
      required Color shadowColor,
      required Color overlayColor,
      required EdgeInsetsGeometry padding,
      required OutlinedBorder? border,
      required OutlinedBorder? borderPressed,
      required BorderRadius borderRadiustest,
      // bordRadius = 10,
      bord}) {
    final MaterialStateProperty<Color> backgroundColor = MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return backgroundDisabled;
      } else if (states.contains(MaterialState.pressed)) {
        return backgroundPressed;
      }
      return background;
    });
    final MaterialStateProperty<Color> foregroundColor = MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return foregroundDisabled;
      } else if (states.contains(MaterialState.pressed)) {
        return foregroundPressed;
      }
      return foreground;
    });
    final MaterialStateProperty<OutlinedBorder?> shape = MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      return RoundedRectangleBorder(borderRadius: borderRadiustest);
    });

    return ButtonStyle(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      overlayColor: MaterialStateProperty.all<Color>(overlayColor),
      shadowColor: ButtonStyleButton.allOrNull<Color>(shadowColor),
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(padding),
      shape: shape,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minimumSize: MaterialStateProperty.all<Size>(const Size(10, 21)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: createStyle(
        padding: buttonSize.padding,
        background: buttonType.backgroundColor,
        backgroundDisabled: buttonType.backgroundDisabled,
        backgroundPressed: buttonType.backgroundPressedColor,
        foreground: buttonType.foregroundColor,
        foregroundDisabled: MjkColor.lightBlack001,
        foregroundPressed: buttonType.foregroundPressedColor,
        overlayColor: Colors.transparent,
        shadowColor: Colors.transparent,
        border: null,
        borderPressed: null,
        borderRadiustest: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // if (icon != null) ...<Widget>[
          //   Icon(
          //     icon,
          //     size: size.iconSize,
          //   ),
          //   Spacings.horzSpace(10.5),
          // ],
          Text(
            text,
            style: TextStyle(
              fontSize: buttonSize.fontSize,
              fontWeight: buttonType.fontWeight ?? FontWeight.w600,
              height: 14.84 / buttonSize.fontSize,
              color: onTap == null ? buttonType.disabledTextColor : buttonType.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
