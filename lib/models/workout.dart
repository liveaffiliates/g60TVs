
import 'package:g60/models/exercise.dart';
import 'package:g60/models/workout_set_type.dart';

class Workout {

  String name;
  int numberOfStations;
  int setsPerStation;
  int setDuration;
  int breakBetweenStations;
  int breakBetweenSets;
  List<Exercise> exercises = [];

  Workout({
    required this.name,
    required this.numberOfStations,
    required this.setsPerStation,
    required this.setDuration,
    required this.breakBetweenStations,
    required this.breakBetweenSets,
    required this.exercises
  });


}