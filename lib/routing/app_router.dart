import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noteworthy/features/authentication/data/authentication_repository.dart';
import 'package:noteworthy/features/authentication/presentation/sign_in_screen.dart';
import 'package:noteworthy/features/authentication/presentation/sign_up_screen.dart';
import 'package:noteworthy/features/notes/presentation/add_note_screen.dart';
import 'package:noteworthy/features/notes/presentation/edit_note_screen.dart';
import 'package:noteworthy/features/notes/presentation/notes_screen.dart';
import 'package:noteworthy/routing/go_router_refresh_stream.dart';

enum AppRoute { home, signIn, profile, signUp, addNote, editNote }

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return GoRouter(
      initialLocation: "/sign-up",
      debugLogDiagnostics: true,
      refreshListenable:
          GoRouterRefreshStream(authRepository.authStateChanges()),
      redirect: (context, state) {
        final isLoggedIn = firebaseAuth.currentUser != null;
        if (isLoggedIn) {
          if (state.location == '/sign-in') {
            return '/home';
          } else if (state.location == "/sign-up") {
            return '/home';
          }
        } else {
          if (state.location == '/home') {
            return '/sign-up';
          }
        }
      },
      routes: [
        GoRoute(
            path: "/sign-in",
            name: AppRoute.signIn.name,
            builder: (context, state) => const SignInScreen()),
        GoRoute(
            path: "/sign-up",
            name: AppRoute.signUp.name,
            builder: (context, state) => const SignUpScreen()),
        GoRoute(
            path: "/home",
            name: AppRoute.home.name,
            builder: (context, state) => const NotesScreen(),
            routes: [
              GoRoute(
                  path: "add-note",
                  name: AppRoute.addNote.name,
                  builder: (context, state) => const AddNoteScreen()),
              GoRoute(
                path: "edit/:id",
                name: AppRoute.editNote.name,
                builder: (context, state) {
                  final noteId = state.pathParameters['id']!;
                  return EditNoteScreen(noteId: noteId);
                },
              )
            ]),
      ]);
});
