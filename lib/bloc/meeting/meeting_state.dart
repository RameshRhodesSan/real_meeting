import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:meeting_app/models/meeting_config.dart';
import 'package:meeting_app/screens/home_screen_constants.dart';

class MeetingState extends Equatable {
  final bool isLoading;
  final MeetingAction? loadingAction;
  final MeetingConfig? meetingConfig;
  final TextEditingController joinMeetingIdController;

  const MeetingState({
    this.isLoading = false,
    this.loadingAction,
    this.meetingConfig,
    required this.joinMeetingIdController,
  });

  MeetingState copyWith({
    bool? isLoading,
    MeetingAction? loadingAction,
    bool clearLoadingAction = false,
    MeetingConfig? meetingConfig,
    TextEditingController? joinMeetingIdController,
  }) {
    return MeetingState(
      isLoading: isLoading ?? this.isLoading,
      loadingAction: clearLoadingAction ? null : (loadingAction ?? this.loadingAction),
      meetingConfig: meetingConfig ?? this.meetingConfig,
      joinMeetingIdController: joinMeetingIdController ?? this.joinMeetingIdController,
    );
  }

  @override
  List<Object?> get props => [isLoading, loadingAction, meetingConfig, joinMeetingIdController];
}
