import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meeting_app/bloc/meeting/meeting_event.dart';
import 'package:meeting_app/bloc/meeting/meeting_state.dart';
import 'package:meeting_app/models/meeting_config.dart';
import 'package:meeting_app/screens/home_screen_constants.dart';
import 'package:meeting_app/services/failure/failure.dart';
import 'package:meeting_app/services/meeting_api_service.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  late MeetingApiService apiService;

  MeetingBloc()
      : apiService = MeetingApiService(),
        super(const MeetingState()) {
    on<MeetingJoinEvent>(_onJoinMeeting);
    on<MeetingActionEvent>(_onMeetingAction);
  }

  Future<void> _onMeetingAction(MeetingActionEvent event, Emitter<MeetingState> emit) async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, loadingAction: MeetingAction.create));
    Either<MeetingConfig, Failure> config;
    switch (event.action) {
      case MeetingAction.create:
        config = await apiService.createMeeting();
      case MeetingAction.join:
        config = await apiService.joinMeeting();
    }
    config.fold((l) {
      //Success create api call
      emit(state.copyWith(meetingConfig: l));
      add(MeetingJoinEvent(l));
    }, (r) {
      debugPrint('Failed to create meeting: ${r.message}');
      // todo to implement failure msg to ui
    });
    emit(state.copyWith(isLoading: false, clearLoadingAction: true));
  }

  Future<void> _onJoinMeeting(MeetingJoinEvent event, Emitter<MeetingState> emit) async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, loadingAction: MeetingAction.join));
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(state.copyWith(isLoading: false, clearLoadingAction: true));
  }
}
