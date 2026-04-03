import 'dart:convert';

class MeetingConfig {
  final String meetingId;
  final String externalMeetingId;
  final String mediaRegion;
  final MediaPlacement mediaPlacement;
  final String attendeeId;
  final String externalUserId;
  final String joinToken;
  final bool isHost;

  const MeetingConfig({
    required this.meetingId,
    required this.externalMeetingId,
    required this.mediaRegion,
    required this.mediaPlacement,
    required this.attendeeId,
    required this.externalUserId,
    required this.joinToken,
    this.isHost = false,
  });

  MeetingConfig copyWith({bool? isHost}) => MeetingConfig(
        meetingId: meetingId,
        externalMeetingId: externalMeetingId,
        mediaRegion: mediaRegion,
        mediaPlacement: mediaPlacement,
        attendeeId: attendeeId,
        externalUserId: externalUserId,
        joinToken: joinToken,
        isHost: isHost ?? this.isHost,
      );

  factory MeetingConfig.fromAssessmentJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    final meeting = data['meeting'] as Map<String, dynamic>;
    final attendee = data['attendee'] as Map<String, dynamic>;

    final placementMap = meeting['MediaPlacement'] as Map<String, dynamic>?;
    if (placementMap == null) {
      throw Exception('Placement is null - MeetingId=${meeting['MeetingId']}');
    }

    return MeetingConfig(
      meetingId: (meeting['MeetingId'] ?? '') as String,
      externalMeetingId: (meeting['ExternalMeetingId'] ?? '') as String,
      mediaRegion: (meeting['MediaRegion'] ?? 'ap-southeast-1') as String,
      mediaPlacement: MediaPlacement.fromJson(placementMap),
      attendeeId: (attendee['AttendeeId'] ?? '') as String,
      externalUserId: (attendee['ExternalUserId'] ?? '') as String,
      joinToken: (attendee['JoinToken'] ?? '') as String,
    );
  }

  factory MeetingConfig.fromJson(Map<String, dynamic> json) {
    final meeting = json['Meeting'] as Map<String, dynamic>;
    final attendee = json['Attendee'] as Map<String, dynamic>;
    final placement = meeting['MediaPlacement'] as Map<String, dynamic>;

    return MeetingConfig(
      meetingId: (meeting['MeetingId'] ?? '') as String,
      externalMeetingId: (meeting['ExternalMeetingId'] ?? '') as String,
      mediaRegion: (meeting['MediaRegion'] ?? 'ap-southeast-1') as String,
      mediaPlacement: MediaPlacement.fromJson(placement),
      attendeeId: (attendee['AttendeeId'] ?? '') as String,
      externalUserId: (attendee['ExternalUserId'] ?? '') as String,
      joinToken: (attendee['JoinToken'] ?? '') as String,
    );
  }

  String toShareableCode() {
    final payload = jsonEncode({
      'meetingId': meetingId,
      'externalMeetingId': externalMeetingId,
      'mediaRegion': mediaRegion,
      'mediaPlacement': mediaPlacement.toMap(),
    });
    return base64Url.encode(utf8.encode(payload));
  }

  static MeetingConfig? fromShareableCode(String code) {
    try {
      final normalized = base64Url.normalize(code.trim());
      final json = jsonDecode(utf8.decode(base64Url.decode(normalized))) as Map<String, dynamic>;
      return MeetingConfig(
        meetingId: json['meetingId'] as String,
        externalMeetingId: json['externalMeetingId'] as String,
        mediaRegion: json['mediaRegion'] as String,
        mediaPlacement: MediaPlacement.fromJson(json['mediaPlacement'] as Map<String, dynamic>),
        attendeeId: '',
        externalUserId: '',
        joinToken: '',
      );
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> toMap() => {
        'meetingId': meetingId,
        'externalMeetingId': externalMeetingId,
        'mediaRegion': mediaRegion,
        'mediaPlacement': mediaPlacement.toMap(),
        'attendeeId': attendeeId,
        'externalUserId': externalUserId,
        'joinToken': joinToken,
      };
}

class MediaPlacement {
  final String audioHostUrl;
  final String audioFallbackUrl;
  final String signalingUrl;
  final String turnControlUrl;
  final String? eventIngestionUrl;
  final String? screenDataUrl;
  final String? screenSharingUrl;
  final String? screenViewingUrl;

  const MediaPlacement({
    required this.audioHostUrl,
    required this.audioFallbackUrl,
    required this.signalingUrl,
    required this.turnControlUrl,
    this.eventIngestionUrl,
    this.screenDataUrl,
    this.screenSharingUrl,
    this.screenViewingUrl,
  });

  factory MediaPlacement.fromJson(Map<String, dynamic> json) {
    return MediaPlacement(
      audioHostUrl: (json['AudioHostUrl'] ?? json['audioHostUrl'] ?? '') as String,
      audioFallbackUrl: (json['AudioFallbackUrl'] ?? json['audioFallbackUrl'] ?? '') as String,
      signalingUrl: (json['SignalingUrl'] ?? json['signalingUrl'] ?? '') as String,
      turnControlUrl: (json['TurnControlUrl'] ?? json['turnControlUrl'] ?? '') as String,
      eventIngestionUrl: (json['EventIngestionUrl'] ?? json['eventIngestionUrl']) as String?,
      screenDataUrl: (json['ScreenDataUrl'] ?? json['screenDataUrl']) as String?,
      screenSharingUrl: (json['ScreenSharingUrl'] ?? json['screenSharingUrl']) as String?,
      screenViewingUrl: (json['ScreenViewingUrl'] ?? json['screenViewingUrl']) as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'audioHostUrl': audioHostUrl,
        'audioFallbackUrl': audioFallbackUrl,
        'signalingUrl': signalingUrl,
        'turnControlUrl': turnControlUrl,
        if (eventIngestionUrl != null) 'eventIngestionUrl': eventIngestionUrl,
      };
}
