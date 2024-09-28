import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/cubits/todo_cubit.dart';
import 'package:note_app/data/models/todo_model.dart';
import 'package:note_app/themes/themes_provider.dart';
import 'package:note_app/views/home_view.dart';
import 'package:note_app/views/setting_view.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  final myBox = await Hive.openBox<TodoModel>('todoBox');
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemesProvider(),
      child: MyApp(todoBox: myBox),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.todoBox});
  final Box<TodoModel> todoBox;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Provider.of<ThemesProvider>(context).currentTheme,
      home: BlocProvider(
          create: (context) => ToDoCubit(todoBox), child: HomeView()),
      routes: {
        '/settingView': (context) => const SettingView(),
      },
    );
  }
}
