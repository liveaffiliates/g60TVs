import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:g60/services/firebase_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:g60/locator.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:g60/common/viewstate.dart';


class BaseViewModel extends ChangeNotifier {

  final dialogService = locator<DialogService>();
  final navigationService = locator<NavigationService>();
  final firestoreService = locator<FireStoreService>();


  List<StreamSubscription<dynamic>> _subscriptions = [];

  ViewState _viewState = ViewState.Idle;
  ViewState get viewState => _viewState;


  void setViewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  void updateView() {
    notifyListeners();
  }

  void onReady() {}

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  Future<void> navigateToView({required String route}) async {
    await navigationService.navigateTo(route, preventDuplicates: true);
  }

  void onDispose() {
    this.cancelAllSubscriptions();
  }

  void listenTo<T>(Stream<T> stream, Action<T> action) {
    var viewModel = this;
    var subscription = stream.listen((event) {
      if (viewModel != null) {
        action(event);
        notifyListeners();
      }
    });
    trackSubscription(subscription);
  }

  void trackSubscription<T>(StreamSubscription<T> subscription) {
    // Track this subscription so it can be cancelled when the ViewModel is disposed of
    _subscriptions.add(subscription);
  }

  void cancelAllSubscriptions() {
    if (_subscriptions.length > 0) {
      _subscriptions.forEach((element) {
        if (element != null) {
          element.cancel();
        }
      });
    }
  }
}

typedef void Action<T>(T item);
