
import 'package:flutter/material.dart';

enum MeetingAction { create, join }

extension MeetingActionExtension on MeetingAction {
  IconData getIcon() {
    switch (this) {
      case MeetingAction.create:
        return Icons.video_call;
      case MeetingAction.join:
        return Icons.person;
    }
  }

  String getLabel() {
    switch (this) {
      case MeetingAction.create:
        return 'Create a Meeting';
      case MeetingAction.join:
        return 'Join Meeting';
    }
  }

  String getLoadingLabel() {
    switch (this) {
      case MeetingAction.create:
        return 'Creating';
      case MeetingAction.join:
        return 'Joining';
    }
  }

}
