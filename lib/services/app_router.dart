// app_router.dart
import 'package:event_flow/features/announcement/screens/announcements_screen.dart';
import 'package:event_flow/features/create_announcement/screens/create_announcement_screen.dart';
import 'package:event_flow/features/create_event/screens/create_event_screen.dart';
import 'package:event_flow/features/event/screens/event_screen.dart';
import 'package:event_flow/features/forum/screens/forum_screen.dart';
import 'package:event_flow/features/forum/screens/forum_topic_screen.dart';
import 'package:event_flow/features/vote/screens/vote_screen.dart';
import 'package:event_flow/features/vote/screens/vote_topic_screen.dart';
import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data_models/event_data_model.dart';
import '../features/home/screens/home_screen.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/announcements',
        builder: (context, state) => const AnnouncementScreen(),
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
          final eventDetails = state.extra as Event?;
          return EventScreen(event: eventDetails);
        },
      ),
      GoRoute(
        path: '/forum',
        builder: (context, state) {
          final event = state.extra as Event;
          return ForumScreen(event: event);
        }
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
        builder: (context, state) {
          final event = state.extra as Event?;
          return CreateEventScreen(event: event);
        },
      ),
      GoRoute(
        path: '/createAnnouncement',
        builder: (context, state) {
          final event = state.extra as Event;
          return CreateAnnouncement(event: event);
        },
      ),
    ],
  );
}
