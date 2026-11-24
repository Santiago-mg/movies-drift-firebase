# 🎬 Movies · Flutter offline-first con Drift + Firestore

Aplicación Flutter para explorar un catálogo de películas y guardar **notas y calificaciones personales** que funcionan **sin conexión**. Las notas se guardan primero en una base local (Drift / SQLite) y se sincronizan con **Cloud Firestore** cuando hay red.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)
![SQLite](https://img.shields.io/badge/Drift_·_SQLite-003B57?style=flat-square&logo=sqlite&logoColor=white)
![Firebase](https://img.shields.io/badge/Cloud_Firestore-DD2C00?style=flat-square&logo=firebase&logoColor=white)

## ✨ Funcionalidades

- 📃 **Catálogo de películas** consumido por HTTP, con tarjetas de póster y vista de detalle.
- ⭐ **Película favorita** marcada con una estrella y persistida con `SharedPreferences`.
- 📝 **Notas y calificación por película**, guardadas localmente al instante.
- 🔄 **Sincronización offline-first**: cada nota queda marcada como `pendingSync` hasta que Firestore la confirma; `syncPending()` reintenta solo las pendientes.
- 🌐 **Multiplataforma**: Android, iOS, escritorio y **web** (Drift corre en el navegador con `sqlite3.wasm` y un web worker).

## 🧱 Arquitectura

```
lib/
  models/       → Movie, MovieNote (fromJson / toJson)
  services/     → MovieService (HTTP) y almacenamiento simple
  local/        → Base Drift: tabla de notas, data source local y conexión por plataforma (io / web)
  remote/       → Data source remoto sobre Cloud Firestore
  repository/   → MovieNoteRepository: escribe primero en local y luego intenta en remoto
  movie_screen.dart · movie_detail.dart · movie_card.dart → UI
```

El **repositorio** es la única puerta de entrada a los datos de notas: la UI no sabe si una nota viene de SQLite o de Firestore.

```
UI ──▶ MovieNoteRepository ──▶ Local (Drift)      ← siempre primero
                          └──▶ Remote (Firestore) ← si hay conexión; si falla, queda pendiente
```

## ▶️ Cómo ejecutarlo

Requisitos: Flutter 3.x y un proyecto de Firebase (o usa la app sin `remote`, solo local).

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # genera el código de Drift
flutter run                                                # o: flutter run -d chrome
```

Para usar tu propio Firebase: `flutterfire configure` regenera `lib/firebase_options.dart`.

## 📚 Documentación

En [`docs/`](docs/) hay una guía paso a paso del diseño visual de la app.
