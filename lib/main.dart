import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ingressos/injection_container/service_locator.dart';
import 'package:ingressos/features/movie/presenter/ui/widgets/pages/movies_page.dart';
import 'package:ingressos/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MoviesPage(),
      initialRoute: Routes.home,
      onGenerateRoute: generateRoute,
    );
  }
}
