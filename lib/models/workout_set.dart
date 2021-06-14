
class WorkoutSet {

  int duration;
  String type;

  WorkoutSet(this.duration, this.type);

  void setDuration(int value) {
    duration = value;
  }

  int get getDuration => duration;

  void setType(String value) {
    type = value;
  }

  String get getType => type;

}