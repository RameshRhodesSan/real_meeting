import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_app/bloc/meeting/meeting_bloc.dart';
import 'package:meeting_app/bloc/meeting/meeting_event.dart';
import 'package:meeting_app/bloc/meeting/meeting_state.dart';
import 'package:meeting_app/screens/home_screen_constants.dart';
import 'package:meeting_app/utils/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

const double _actionButtonHeight = 48;

ButtonStyle get _primaryButtonStyle => ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, _actionButtonHeight),
      maximumSize: const Size(double.infinity, _actionButtonHeight),
    );

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  ButtonStyle get _secondaryButtonStyle => OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, _actionButtonHeight),
        maximumSize: const Size(double.infinity, _actionButtonHeight),
      );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 36),
                    const Icon(Icons.video_call, size: 72, color: AppTheme.primaryColor),
                    const SizedBox(height: 12),
                    const Text(
                      'Real Meeting',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Powered by Amazon Chime SDK',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.cardColor,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppTheme.dividerColor),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        labelColor: Colors.white,
                        unselectedLabelColor: AppTheme.textSecondary,
                        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                        tabs: const [
                          Tab(icon: Icon(Icons.meeting_room_outlined, size: 20), text: 'Create'),
                          Tab(icon: Icon(Icons.person, size: 20), text: 'Join'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: _actionButtonHeight,
                      child: BlocBuilder<MeetingBloc, MeetingState>(
                        builder: (context, state) {
                          return TabBarView(
                            controller: _tabController,
                            children: [
                              CommonButton(
                                isLoading: state.isLoading && state.loadingAction == MeetingAction.create,
                                buttonType: MeetingAction.create,
                                onPressed: () => context.read<MeetingBloc>().add(const MeetingActionEvent(MeetingAction.create)),
                              ),
                              CommonButton(
                                isLoading: state.isLoading && state.loadingAction == MeetingAction.join,
                                buttonType: MeetingAction.join,
                                onPressed: () => context.read<MeetingBloc>().add(const MeetingActionEvent(MeetingAction.join)),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.list_alt, size: 18),
                label: const Text('View Event Log'),
                style: _secondaryButtonStyle,
                onPressed: () {
                  //Todo to call the Events screen
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonButton extends StatelessWidget {
  final bool isLoading;
  final MeetingAction buttonType;
  final VoidCallback? onPressed;

  const CommonButton({
    super.key,
    required this.isLoading,
    required this.buttonType,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: _primaryButtonStyle,
      onPressed: isLoading ? null : onPressed,
      icon: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ))
          : Icon(buttonType.getIcon()),
      label: Text(isLoading ? buttonType.getLoadingLabel() : buttonType.getLabel()),
    );
  }
}
