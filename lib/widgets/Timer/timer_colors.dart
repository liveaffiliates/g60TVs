import 'package:g60/theme/g60_colors.dart';
import 'package:flutter/material.dart';
import 'package:g60/models/workout_set_type.dart';

Color timerBackgroundColor () {
  return Colors.black.withOpacity(0.4);
}

Color timerProgressColor () {
  return Colors.white;
}

Color timerContainerBackgroundColor (WorkoutSetType type) {
  switch(type) {
    case WorkoutSetType.Normal: {
      return g60Green;
    }
    case WorkoutSetType.Move: {
      return g60Red;
    }
    case WorkoutSetType.Hydrate: {
      return g60LightBlue;
    }
    case WorkoutSetType.Stay: {
      return g60Red;
    }
    default: {
      return g60Green;
    }
  }
}

Color timerTextColor (WorkoutSetType type) {
  switch(type) {
    case WorkoutSetType.Normal: {
      return Colors.black;
    }
    case WorkoutSetType.Move: {
      return Colors.white;
    }
    case WorkoutSetType.Hydrate: {
      return Colors.black;
    }
    case WorkoutSetType.Stay: {
      return Colors.black;
    }
    default: {
      return Colors.black;
    }
  }
}


