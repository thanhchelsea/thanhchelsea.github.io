import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/blocs/app_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/blocs.dart';
import 'constants.dart';
import 'ui/app.dart';
import 'utils/common.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String language = preferences.getString(SPrefCache.PREF_KEY_LANGUAGE); // kiem tra type(vi,en) ngon ngu khi khoi dong app
  String typeMap = preferences.get(SPrefCache.TYPE_MAP);
  if (language == null) {
    Common.changTypeMap("vi");
    language = "vi";
  }
  print("ngon ngu :" + language.toString());
  if (typeMap == null) {
    Common.changTypeMap("Hybird");
    typeMap = "Hybird";}
  print("map :" + typeMap);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (_) => AppBloc(language, typeMap),
        ),
      ],
      child: MyApp.language(language: language),
    ),
  );
}
