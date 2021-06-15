
import 'package:g60/models/workout_set_type.dart';

class WorkoutSet {

  int duration;
  WorkoutSetType type;

  WorkoutSet(this.duration, this.type);

  void setDuration(int value) {
    duration = value;
  }

  int get getDuration => duration;

  void setType(WorkoutSetType value) {
    type = value;
  }

  WorkoutSetType get getType => type;

}