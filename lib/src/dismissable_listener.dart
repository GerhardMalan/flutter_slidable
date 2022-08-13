// Copyright ©2022, GM Consult (Pty) Ltd. All rights reserved
// End user is granted a non-exclusive non-transferable license the ("License")
// to use GM Consult's proprietary software (the "Software").
//

// ignore_for_file: public_member_api_docs

import 'package:flutter_slidable/flutter_slidable.dart';

class DismissableListener<T extends Object> implements IDismissableListener<T> {
  //

  const DismissableListener(
      this.confirmItemDismiss,
      this.onItemDismissed);

  @override
  final ConfirmDismissHandler<Object>? confirmItemDismiss;

  @override
  final DismissedHandler<Object>? onItemDismissed;

}
