// app_router.dart
import 'package:event_flow/features/create_event/screens/create_event_screen.dart';
import 'package:event_flow/features/event/screens/event_screen.dart';
import 'package:event_flow/features/forum/screens/forum_screen.dart';
import 'package:event_flow/features/forum/screens/forum_topic_screen.dart';
import 'package:event_flow/features/vote/screens/vote_screen.dart';
import 'package:event_flow/features/vote/screens/vote_topic_screen.dart';
import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/home/screens/home_screen.dart';
import '../services/isar_service.dart';

class AppRouter {
  final IsarService isarService;

  AppRouter(this.isarService);

  late final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeContent(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeContent(),
      ),
      GoRoute(
        path: '/chat',
        builder: (context, state) => const BaseScreen(
          selectedIndex: 1,
          title: Text('Chat'),
          child: Center(child: Text('Chat Screen')),
        ),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const BaseScreen(
          selectedIndex: 2,
          title: Text('Settings'),
          child: Center(child: Text('Settings')),
        ),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const BaseScreen(
          selectedIndex: 3,
          title: Text('Profile'),
          child: Center(child: Text('Profile')),
        ),
      ),
      GoRoute(
        path: '/event',
        builder: (context, state) {
          final eventDetails = state.extra as Map<String, String>;
          return EventScreen(
            title: eventDetails['title']!,
            date: eventDetails['date']!,
            time: eventDetails['time']!,
            location: eventDetails['location']!,
            attendees: eventDetails['attendees']!,
          );
        },
      ),
      GoRoute(
        path: '/forum',
        builder: (context, state) => const ForumScreen(),
      ),
      GoRoute(
        path: '/forum/topic',
        builder: (context, state) => const ForumTopicScreen(
          title: 'Forum',
        ),
      ),
      GoRoute(
        path: '/vote',
        builder: (context, state) => const VoteScreen(),
      ),
      GoRoute(
        path: '/vote/topic',
        builder: (context, state) => const VoteTopicScreen(
          title: 'Wer kommt alles?',
        ),
      ),
      GoRoute(
        path: '/createEvent',
        builder: (context, state) => const CreateEventScreen(),
      ),
    ],
  );
}

final appRouter = AppRouter(IsarService()).router;
