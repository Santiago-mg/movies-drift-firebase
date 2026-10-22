import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

// SQLite compilado a WebAssembly para la web.
// Necesita web/sqlite3.wasm y web/drift_worker.js junto a index.html.
QueryExecutor openConnection() {
  return LazyDatabase(() async {
    final result = await WasmDatabase.open(
      databaseName: 'movies',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
    );
    return result.resolvedExecutor;
  });
}
