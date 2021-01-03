import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grocery_manager/models/models.dart';

@immutable
abstract class DinnerEvent {}

class DinnersLoaded extends DinnerEvent {}

class NewDinnerStarted extends DinnerEvent {}

class EditingDinnerStarted extends DinnerEvent {
  final Dinner dinner;

  EditingDinnerStarted(this.dinner);
}

class DinnerSaved extends DinnerEvent {
  final Dinner dinner;

  DinnerSaved({this.dinner});
}

class DinnerCancelled extends DinnerEvent {}

class DinnersDeleted extends DinnerEvent {
  final List<Dinner> dinners;

  DinnersDeleted({this.dinners});
}

class DinnersImported extends DinnerEvent {
  final File file;

  DinnersImported({this.file});
}
