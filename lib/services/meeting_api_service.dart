import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:meeting_app/constants/app_constants.dart';
import 'package:meeting_app/models/meeting_config.dart';
import 'package:meeting_app/services/failure/failure.dart';

class MeetingApiService {
  static const String _base = AppConstants.apiBaseUrl;
  static const String _keyPrimary = AppConstants.apiKeyValue;

  Future<Either<MeetingConfig, Failure>> createMeeting() async {
    try {
      final uri = Uri.parse('$_base/meetings?type=agent');
      debugPrint('[API] POST $uri');
      final response = await http.post(
        uri,
        headers: {AppConstants.apiKey: _keyPrimary},
      );
      debugPrint('[API] createMeetingAsAgent → ${response.statusCode}');
      _assertOk(response, 'Create Meeting As Agent');
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return Left(MeetingConfig.fromAssessmentJson(body));
    } on Exception catch (e) {
      return Right(ApiFailure(message: e.toString()));
    }
  }

  void _assertOk(http.Response res, String label) {
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('$label failed (${res.statusCode}): ${res.body}');
    }
    final decoded = jsonDecode(res.body) as Map<String, dynamic>?;
    if (decoded == null) throw Exception('$label: empty response body');
    final status = decoded['status'] as String?;
    if (status != null && status != 'success') {
      throw Exception('$label error: ${decoded['message'] ?? res.body}');
    }
  }

  Future<Either<MeetingConfig, Failure>> joinMeeting({required String meetingId}) async {
    {
      try {
        debugPrint('[API] joinMeeting -> meetingId=$meetingId ');
        final uri = Uri.parse('$_base/meetings?type=client&meeting_id=$meetingId');
        debugPrint('[API] POST $uri');
        final response = await http.post(
          uri,
          headers: {AppConstants.apiKey: _keyPrimary},
        );
        debugPrint('[API] joinMeeting -> ${response.statusCode}: ${response.body}');
        _assertOk(response, 'joinMeeting');
        Map<String, dynamic> jsonParsedData = jsonDecode(response.body);
        MeetingConfig config = MeetingConfig.fromAssessmentJson(jsonParsedData);
        return Left(config);
      } on Exception catch (e) {
        return Right(ApiFailure(message: e.toString()));
      }
    }
  }
}