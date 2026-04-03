import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_app/bloc/meeting/meeting_bloc.dart';
import 'package:meeting_app/bloc/meeting/meeting_state.dart';
import 'package:meeting_app/utils/app_theme.dart';

class MeetingScreen extends StatelessWidget {
  const MeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Meeting Room'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(child: Center(child: Text("Loading...", style: TextStyle(color: Colors.white)))),
            MeetingControlsBar(
              state: context.read<MeetingBloc>().state,
            )
          ],
        ),
      ),
    );
  }
}

class MeetingControlsBar extends StatelessWidget {
  final MeetingState state;

  const MeetingControlsBar({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final isMuted = state.isMuted;
    final isVideoOn = state.isVideoOn;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: AppTheme.surfaceColor,
        border: Border(top: BorderSide(color: AppTheme.dividerColor)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _ControlButton(
              icon: isMuted ? Icons.mic_off : Icons.mic,
              label: isMuted ? 'Unmute' : 'Mute',
              color: isMuted ? AppTheme.dangerColor : AppTheme.textPrimary,
              onPressed: () {
                //todo to add event for mute
              },
            ),
            _ControlButton(
              icon: isVideoOn ? Icons.videocam : Icons.videocam_off,
              label: isVideoOn ? 'Camera' : 'Camera Off',
              color: isVideoOn ? AppTheme.textPrimary : AppTheme.dangerColor,
              onPressed: () {
                //todo to add event for camera
              },
            ),
            _ControlButton(
              icon: Icons.call_end,
              label: 'Leave',
              color: Colors.white,
              backgroundColor: AppTheme.dangerColor,
              onPressed: () {
                //todo to add event for leave
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  const _ControlButton({
    required this.icon,
    required this.label,
    required this.color,
    this.backgroundColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: backgroundColor ?? AppTheme.cardColor,
                shape: BoxShape.circle,
                boxShadow: backgroundColor != null
                    ? [
                        BoxShadow(
                          color: backgroundColor!.withValues(alpha: 0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : null,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(color: color.withValues(alpha: 0.9), fontSize: 11, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
