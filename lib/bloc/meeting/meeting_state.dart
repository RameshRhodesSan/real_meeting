import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:meeting_app/models/meeting_config.dart';
import 'package:meeting_app/screens/home_screen_constants.dart';

class MeetingState extends Equatable {
  final bool isLoading;
  final MeetingAction? loadingAction;
  final MeetingConfig? meetingConfig;
  final TextEditingController joinMeetingIdController;
  final bool isMuted;
  final bool isVideoOn;
  final bool navigateToMeeting;

  const MeetingState({
    this.isLoading = false,
    this.loadingAction,
    this.meetingConfig,
    required this.joinMeetingIdController,
    this.isMuted = false,
    this.isVideoOn = false,
    this.navigateToMeeting = false,
  });

  MeetingState copyWith({
    bool? isLoading,
    MeetingAction? loadingAction,
    bool clearLoadingAction = false,
    MeetingConfig? meetingConfig,
    TextEditingController? joinMeetingIdController,
    bool? isMuted,
    bool? isVideoOn,
    bool navigateToMeeting = false,
  }) {
    return MeetingState(
      isLoading: isLoading ?? this.isLoading,
      loadingAction: clearLoadingAction ? null : (loadingAction ?? this.loadingAction),
      meetingConfig: meetingConfig ?? this.meetingConfig,
      joinMeetingIdController: joinMeetingIdController ?? this.joinMeetingIdController,
      isMuted: isMuted ?? this.isMuted,
      isVideoOn: isVideoOn ?? this.isVideoOn,
      navigateToMeeting: navigateToMeeting,
    );
  }

  @override
  List<Object?> get props => [isLoading, loadingAction, meetingConfig, joinMeetingIdController, navigateToMeeting];
}
