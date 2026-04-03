import 'package:equatable/equatable.dart';
import 'package:meeting_app/models/meeting_config.dart';
import 'package:meeting_app/screens/home_screen_constants.dart';

class MeetingState extends Equatable {
  final bool isLoading;
  final MeetingAction? loadingAction;
  final MeetingConfig? meetingConfig;

  const MeetingState({
    this.isLoading = false,
    this.loadingAction,
    this.meetingConfig,
  });

  MeetingState copyWith({
    bool? isLoading,
    MeetingAction? loadingAction,
    bool clearLoadingAction = false,
    MeetingConfig? meetingConfig,
  }) {
    return MeetingState(
      isLoading: isLoading ?? this.isLoading,
      loadingAction: clearLoadingAction ? null : (loadingAction ?? this.loadingAction),
      meetingConfig: meetingConfig ?? this.meetingConfig,
    );
  }

  @override
  List<Object?> get props => [isLoading, loadingAction, meetingConfig];
}
