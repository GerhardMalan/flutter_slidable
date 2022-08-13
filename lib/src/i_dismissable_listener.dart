// Copyright ©2022, GM Consult (Pty) Ltd. All rights reserved
// End user is granted a non-exclusive non-transferable license the ("License")
// to use GM Consult's proprietary software (the "Software").
//

// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';

typedef ConfirmDismissHandler<T extends Object> = Future<bool> Function(
    {required BuildContext context,
    required T value,
    required DismissDirection direction});

typedef DismissedHandler<T extends Object> = void Function(
    {required BuildContext context,
    required T value,
    required DismissDirection direction});

typedef TapHandler<T extends Object> = void Function(
    {required BuildContext context, required T value});

typedef LongPressHandler<T extends Object> = void Function(
    {required BuildContext context, required T value});

abstract class IDismissableListener<T extends Object> {
  //

  /// Confirm or veto a pending dismissal.
  ConfirmDismissHandler<T>? get confirmItemDismiss;

  /// Called when the widget has been dismissed.
  DismissedHandler<T>? get onItemDismissed;

  //
}
