import 'package:drift/drift.dart';

import 'io.dart'
    if (dart.library.js_interop) 'web.dart' as driver;

// Elige el motor de SQLite segun la plataforma al compilar:
// en Android/iOS/escritorio usa io.dart y en la web usa web.dart.
QueryExecutor openConnection() => driver.openConnection();
