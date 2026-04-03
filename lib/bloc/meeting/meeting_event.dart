import 'package:equatable/equatable.dart';

abstract class MeetingEvent extends Equatable {
  const MeetingEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class MeetingCreateEvent extends MeetingEvent {
  const MeetingCreateEvent();
}

class MeetingJoinEvent extends MeetingEvent {
  const MeetingJoinEvent();
}
