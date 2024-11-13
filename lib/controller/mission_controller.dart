import 'package:get/get.dart';

// MissionController to manage the state of missions
class MissionController extends GetxController {
  // Map to store the state of each mission
  Map<String, bool> missionState = {
    "Exercise 1": false,
    "Exercise 2": false,
  };

  // Function to toggle the selection state of a mission
  void toggleMissionSelection(String missionTitle) {
    missionState[missionTitle] = !(missionState[missionTitle] ?? false);
    update(); // Notify listeners of state changes
  }

  // Computed property to calculate the overall progress percentage
  double get progressPercent {
    if (missionState.isEmpty) return 0.0;

    // Count the number of completed missions
    int completedMissions =
        missionState.values.where((completed) => completed).length;
    // Calculate the progress percentage
    return completedMissions / missionState.length;
  }
}
