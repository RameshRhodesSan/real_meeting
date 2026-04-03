import 'package:equatable/equatable.dart';
import 'package:meeting_app/models/meeting_config.dart';
import 'package:meeting_app/screens/home_screen_constants.dart';

abstract class MeetingEvent extends Equatable {
  const MeetingEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class MeetingActionEvent extends MeetingEvent{
  final MeetingAction action;
  const MeetingActionEvent(this.action);
}

class MeetingJoinEvent extends MeetingEvent {
  final MeetingConfig meetingConfig;
  const MeetingJoinEvent(this.meetingConfig);

  @override
  List<Object> get props => [meetingConfig];
}
