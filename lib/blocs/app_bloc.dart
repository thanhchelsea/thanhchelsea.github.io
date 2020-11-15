import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../localizations.dart';
import 'blocs.dart';

class AppBloc extends BaseBloc {
  String currentLanguage;
  String currentTypeMap;

  AppBloc(this.currentLanguage, this.currentTypeMap);

  @override
  BaseState get initialState =>
      CreatApp(currentLanguage ?? Constants.VI, currentTypeMap ?? "Terrain"); //

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is ChangeLanguage) {
      if (currentLanguage != event.language) {
        currentLanguage = event.language;
        await LanguageDelegate()
            .load(Locale(event.language)); // luu thay doi vao sharedpreferences
        yield NewLanguageState(event.language);
      }
    }
    if(event is changeTypeMap){
      yield ChangeMap(event.currentTypeMap);
    }
  }
}

class changeTypeMap extends BaseEvent{
  String currentTypeMap;
  changeTypeMap(this.currentTypeMap);
}
class ChangeMap extends BaseState{
  String Map;
  ChangeMap(this.Map);
  @override
  List<Object> get props => [Map];
}

class CreatApp extends BaseState {
  final String language;
  final String Map;
  CreatApp(this.language, this.Map);
  @override
  List<Object> get props => [language, Map];
}

class NewLanguageState extends BaseState {
  final String language;
  NewLanguageState(this.language);

  @override
  List<Object> get props => [language];
}

class ChangeLanguage extends BaseEvent {
  // thay doi ngon ngu
  final String language;

  ChangeLanguage(this.language);
}