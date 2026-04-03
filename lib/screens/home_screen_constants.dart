
import 'package:flutter/material.dart';

enum ButtonType { create, join }

extension ButtonTypeExtension on ButtonType {
  IconData getIcon() {
    switch (this) {
      case ButtonType.create:
        return Icons.video_call;
      case ButtonType.join:
        return Icons.person;
    }
  }

  String getLabel() {
    switch (this) {
      case ButtonType.create:
        return 'Create a Meeting';
      case ButtonType.join:
        return 'Join Meeting';
    }
  }

  String getLoadingLabel() {
    switch (this) {
      case ButtonType.create:
        return 'Creating';
      case ButtonType.join:
        return 'Joining';
    }
  }

}
