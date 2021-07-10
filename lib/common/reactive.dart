import 'package:rxdart/rxdart.dart';

T valueOf<T>(BehaviorSubject<T> subject) {
  return subject.value;
}
