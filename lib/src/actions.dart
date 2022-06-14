import 'package:flutter/material.dart';

import 'slidable.dart';

/// Signature for [CustomSlidableAction.onPressed].
typedef SlidableActionCallback = void Function(BuildContext context);

const int _kFlex = 1;
const Color _kBackgroundColor = Colors.white;
const bool _kAutoClose = true;

/// Represents an action of an [ActionPane].
class CustomSlidableAction extends StatelessWidget {
  //
  /// Creates a [CustomSlidableAction].
  ///
  /// The [flex], [backgroundColor], [autoClose] and [child] arguments must not
  /// be null.
  ///
  /// The [flex] argument must also be greater than 0.
  ///
  /// When [onPressed] is null, the [disabledForegroundColor] will be used,
  /// if provided.
  const CustomSlidableAction({
    Key? key,
    this.flex = _kFlex,
    this.backgroundColor = _kBackgroundColor,
    this.foregroundColor,
    this.autoClose = _kAutoClose,
    this.borderRadius = BorderRadius.zero,
    this.padding,
    this.onPressed,
    required this.child,
    this.disabledForegroundColor,
  })  : assert(flex > 0),
        super(key: key);

  /// {@template slidable.actions.flex}
  /// The flex factor to use for this child.
  ///
  /// The amount of space the child's can occupy in the main axis is
  /// determined by dividing the free space according to the flex factors of the
  /// other [CustomSlidableAction]s.
  /// {@endtemplate}
  final int flex;

  /// {@template slidable.actions.backgroundColor}
  /// The background color of this action.
  ///
  /// Defaults to [Colors.white].
  /// {@endtemplate}
  final Color backgroundColor;

  /// Returns true if [onPressed] is null.
  bool get disabled => onPressed == null;

  /// {@template slidable.actions.foregroundColor}
  /// The foreground color of this action.
  ///
  /// Defaults to [Colors.black] if [background]'s brightness is
  /// [Brightness.light], or to [Colors.white] if [background]'s brightness is
  /// [Brightness.dark].
  /// {@endtemplate}
  final Color? foregroundColor;

  /// The foreground color of this action when [disabled].
  ///
  /// Defaults to [foregroundColor].
  final Color? disabledForegroundColor;

  /// {@template slidable.actions.autoClose}
  /// Whether the enclosing [Slidable] will be closed after [onPressed]
  /// occurred.
  /// {@endtemplate}
  final bool autoClose;

  /// {@template slidable.actions.onPressed}
  /// Called when the action is tapped or otherwise activated.
  ///
  /// If this callback is null, then the action will be disabled.
  /// {@endtemplate}
  final SlidableActionCallback? onPressed;

  /// {@template slidable.actions.borderRadius}
  /// The borderRadius of this action
  ///
  /// Defaults to [BorderRadius.zero].
  /// {@endtemplate}
  final BorderRadius borderRadius;

  /// {@template slidable.actions.padding}
  /// The padding of the OutlinedButton
  /// {@endtemplate}
  final EdgeInsets? padding;

  /// Typically the action's icon or label.
  final Widget child;

  /// Returns the effective foreground color:
  ///
  /// - If not [disabled], returns [foregroundColor] if it is not null. If
  ///   [foregroundColor] is null, returns either [Colors.black] or
  ///   [Colors.white], depending on the estimated brightness of the
  ///   [backgroundColor].
  ///
  /// - If [disabled], returns [disabledForegroundColor] if it is not null. If
  ///   [disabledForegroundColor] is null, returns [foregroundColor] with
  ///   opacity of 38% applied. If [foregroundColor] is null, returns either
  ///   [Colors.black] or [Colors.white], depending on the estimated brightness
  ///   of the [backgroundColor], with opacity of 62% applied.
  Color get effectiveForegroundColor => disabled
      ? disabledForegroundColor ??
          (foregroundColor ??
                  (ThemeData.estimateBrightnessForColor(backgroundColor) ==
                          Brightness.light
                      ? Colors.black
                      : Colors.white))
              .withOpacity(0.62)
      : foregroundColor ??
          (ThemeData.estimateBrightnessForColor(backgroundColor) ==
                  Brightness.light
              ? Colors.black
              : Colors.white);

  @override
  Widget build(BuildContext context) {
    final clrForegroundColor = effectiveForegroundColor;
    return Expanded(
      flex: flex,
      child: SizedBox.expand(
        child: OutlinedButton(
          onPressed: () => _handleTap(context),
          style: OutlinedButton.styleFrom(
            padding: padding,
            backgroundColor: backgroundColor,
            primary: clrForegroundColor,
            onSurface: clrForegroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
            side: BorderSide.none,
          ),
          child: child,
        ),
      ),
    );
  }

  void _handleTap(BuildContext context) {
    onPressed?.call(context);
    if (autoClose) {
      Slidable.of(context)?.close();
    }
  }
}

/// An action for [Slidable] which can show an icon, a label, or both.
class SlidableAction extends StatelessWidget {
  //
  /// Creates a [SlidableAction].
  ///
  /// The [flex], [backgroundColor], [autoClose] and [spacing] arguments
  /// must not be null.
  ///
  /// You must set either an [icon] or a [label].
  ///
  /// The [flex] argument must also be greater than 0.
  ///
  /// If [onPressed] is not provided, then [disabled] will return true.
  ///
  /// When [disabled] is true, the [disabledIcon], [disabledLabel],
  /// [disabledForegroundColor] and [disabledLabelStyle] will be used,
  /// if provided.
  const SlidableAction({
    Key? key,
    this.flex = _kFlex,
    this.backgroundColor = _kBackgroundColor,
    this.foregroundColor,
    this.autoClose = _kAutoClose,
    this.onPressed,
    this.icon,
    this.spacing = 4.0,
    this.label,
    this.borderRadius = BorderRadius.zero,
    this.padding,
    this.iconSize,
    this.labelStyle,
    this.disabledForegroundColor,
    this.disabledLabelStyle,
    this.disabledIcon,
    this.disabledLabel,
  })  : assert(flex > 0),
        assert(icon != null || label != null),
        super(key: key);

  /// The foreground color of this action when [disabled].
  ///
  /// Defaults to [foregroundColor].
  final Color? disabledForegroundColor;

  /// Returns true if [onPressed] is null.
  bool get disabled => onPressed == null;

  /// The size of the [icon] displayed on the [SlidableAction].
  ///
  /// Defaults to the current [IconTheme] size, if any. If there is no
  /// [IconTheme], or it does not specify an explicit size, then it
  /// defaults to 24.0.
  final double? iconSize;

  /// The [TextStyle] of the [label] widget.
  ///
  /// Defaults to the default text size (14.0) and [foregroundColor].
  final TextStyle? labelStyle;

  /// The [TextStyle] of the [label] widget when the [SlidableAction] is
  /// [disabled]. The
  ///
  /// Defaults to [labelStyle].
  final TextStyle? disabledLabelStyle;

  /// {@macro slidable.actions.flex}
  final int flex;

  /// {@macro slidable.actions.backgroundColor}
  final Color backgroundColor;

  /// {@macro slidable.actions.foregroundColor}
  final Color? foregroundColor;

  /// {@macro slidable.actions.autoClose}
  final bool autoClose;

  /// {@macro slidable.actions.onPressed}
  final SlidableActionCallback? onPressed;

  /// An icon to display above the [label].
  final IconData? icon;

  /// The icon to display when [disabled].
  ///
  /// Defaults to [icon].
  final IconData? disabledIcon;

  /// The space between [icon] and [label] if both set.
  ///
  /// Defaults to 4.
  final double spacing;

  /// A label to display below the [icon].
  final String? label;

  /// A label to display below the [icon] when the [SlidableAction] is
  /// [disabled].
  ///
  /// Defaults to [label].
  final String? disabledLabel;

  /// Padding of the OutlinedButton
  final BorderRadius borderRadius;

  /// Padding of the OutlinedButton
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    if (icon != null) {
      children.add(
        Icon(
          disabled ? disabledIcon ?? icon : icon,
          size: iconSize,
        ),
      );
    }

    if (label != null) {
      if (children.isNotEmpty) {
        children.add(
          SizedBox(height: spacing),
        );
      }

      children.add(
        Text(
          disabled ? disabledLabel ?? label! : label!,
          overflow: TextOverflow.ellipsis,
          style: disabled ? disabledLabelStyle ?? labelStyle : labelStyle,
        ),
      );
    }

    final child = children.length == 1
        ? children.first
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...children.map(
                (child) => Flexible(
                  child: child,
                ),
              )
            ],
          );

    return CustomSlidableAction(
      borderRadius: borderRadius,
      padding: padding,
      onPressed: onPressed,
      autoClose: autoClose,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      flex: flex,
      child: child,
    );
  }
}
