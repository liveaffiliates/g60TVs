import 'dart:io';

import 'package:g60/screens/createworkoutsscreen/createworkoutviewmodel.dart';
import 'package:g60/screens/savedworkoutsscreen/savedworkoutsviewmodel.dart';
import 'package:g60/screens/setupstudioscreen/setupstudioviewmodel.dart';
import 'package:g60/screens/startworkoutscreen/startworkoutviewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:g60/screens/homescreen/homeviewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

import 'services/firestoreservice.dart';



final locator = GetIt.instance;

bool setupLocator()  {
  setupServices();
  setupViewModels();
  setupStores();
  setupDataThirdPartyServices();
  return true;
}

void setupServices() {
  locator.registerLazySingleton(() => FireStoreService());

}

void setupStores() {
  // Stores
}


void setupViewModels() {
  // ViewModels (Use factories so that multiple views can be created with unique models)
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => StartWorkoutViewModel());
  locator.registerFactory(() => SavedWorkoutsViewModel());
  locator.registerFactory(() => CreateWorkoutViewModel());
  locator.registerFactory(() => SetupStudioViewModel());

}


void setupDataThirdPartyServices() {
  // 3rd party services for navigation, popups and bottom sheet
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => BottomSheetService());
}


