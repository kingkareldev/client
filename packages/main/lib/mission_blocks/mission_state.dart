part of 'mission_bloc.dart';

@immutable
abstract class MissionState {}

class MissionInitial extends MissionState {}

class MissionPlaying extends MissionState {
  // TODO game data
  final bool showDialog;

  // final MissionDialogData? dialog;

  MissionPlaying({
    this.showDialog = false,
  });

  MissionPlaying copyWith({
    bool? showDialog,
  }) {
    return MissionPlaying(
      showDialog: showDialog ?? this.showDialog,
    );
  }
}
