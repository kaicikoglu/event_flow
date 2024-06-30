import 'package:event_flow/features/announcement/screens/announcements_screen.dart';
import 'package:event_flow/features/create_announcement/screens/create_announcement_screen.dart';
import 'package:event_flow/features/create_event/screens/create_event_screen.dart';
import 'package:event_flow/features/event/screens/event_screen.dart';
import 'package:event_flow/features/forum/screens/forum_screen.dart';
import 'package:event_flow/features/vote/screens/vote_screen.dart';
import 'package:event_flow/features/vote/screens/vote_topic_screen.dart';
import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data_models/event_data_model.dart';
import '../data_models/forum_topic_data_model.dart';
import '../features/forum/screens/forum_topic_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../widgets/floating_action_button.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    routes: [
      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context, state, child) {
          return BaseScreen(
            selectedIndex: _getSelectedIndex(state.uri.toString()),
            title: _getTitle(state.uri.toString()),
            centerTitle: true, // Ensure title is centered
            floatingActionButton:
            _getFloatingActionButton(state.uri.toString(), context),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            backButton: _shouldShowBackButton(state.uri.toString())
                ? BackButton(onPressed: () {
              context.pop(); // Navigate back to the previous page
            })
                : null,
            child: child,
          );
        },
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
            builder: (context, state) => const Center(child: Text('Settings')),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const Center(child: Text('Profile')),
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
            },
          ),
          GoRoute(
            path: '/forumTopic',
            builder: (context, state) {
              final topic = state.extra as ForumTopic;
              return ForumTopicScreen(title: topic.title);
            },
          ),
          GoRoute(
            path: '/vote',
            builder: (context, state) {
              final event = state.extra as Event;
              return VoteScreen(event: event);
            },
          ),
          GoRoute(
            path: '/voteTopic',
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
              return CreateAnnouncementScreen(event: event);
            },
          ),
        ],
      ),
    ],
  );

  int _getSelectedIndex(String location) {
    switch (location) {
      case '/':
        return 0;
      case '/announcements':
        return 1;
      case '/settings':
        return 2;
      case '/profile':
        return 3;
      default:
        return 0;
    }
  }

  Widget _getTitle(String location) {
    switch (location) {
      case '/':
        return const Text('Mein EventFlow');
      case '/announcements':
        return const Text('Ankündigungen');
      case '/settings':
        return const Text('Einstellungen');
      case '/profile':
        return const Text('Profil');
      default:
        return const Text('Mein EventFlow');
    }
  }

  Widget? _getFloatingActionButton(String location, BuildContext context) {
    if (location == '/') {
      return CustomFAB(onPressed: () {
        context.push('/createEvent');
      });
    }
    return null;
  }

  bool _shouldShowBackButton(String location) {
    return location != '/' &&
        location != '/announcements' &&
        location != '/settings' &&
        location != '/profile';
  }
}
