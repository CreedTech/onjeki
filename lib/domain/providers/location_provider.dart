// Create a provider for the LocationNotifier
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/location_notifier.dart';
import '../states/location_state.dart';

final locationProvider =
    StateNotifierProvider<LocationNotifier, LocationState>((ref) {
  return LocationNotifier();
});
