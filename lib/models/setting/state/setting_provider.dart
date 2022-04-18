import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/models/setting/state/setting_state.dart';

/// state de la class SettingChange
final settingChange =
    ChangeNotifierProvider<SettingState>((ref) => SettingState());

/// stream de tous les settings
final settingsStream = StreamProvider((ref) {
  return ref.watch(settingChange).streamSettings();
});

/// future de tous les settings
final settingsFuture = FutureProvider((ref) {
  return ref.watch(settingChange).futureSettings();
});
