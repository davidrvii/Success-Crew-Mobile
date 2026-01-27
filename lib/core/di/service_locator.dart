import 'package:get_it/get_it.dart';

import 'core_di.dart';
import 'auth_di.dart';
import 'home_di.dart';

final GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  registerCoreDi(sl);
  registerAuthDi(sl);
  registerHomeDi(sl);
}

Future<void> resetLocator() async {
  await sl.reset();
}
