import 'package:event_flow/features/announcement/screens/announcements_screen.dart';
import 'package:event_flow/features/create_announcement/screens/create_announcement_screen.dart';
import 'package:event_flow/features/create_event/screens/create_event_screen.dart';
import 'package:event_flow/features/event/screens/event_screen.dart';
import 'package:event_flow/features/forum/screens/forum_screen.dart';
import 'package:event_flow/features/resources/screens/resources_screen.dart';
import 'package:event_flow/features/todo/screens/todo_screen.dart';
import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data_models/event/event_data_model.dart';
import '../data_models/forum/forum_topic_data_model.dart';
import '../data_models/vote/voting_topic_data_model.dart';
import '../features/forum_topic/screen/forum_topic_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/vote_overview/screens/vote_screen.dart';
import '../features/voting_topic/screens/voting_topic_screen.dart';
import 'navigation_helpers.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          final selectedIndex = getSelectedIndex(state.uri.toString());

          return BaseScreen(
            selectedIndex: selectedIndex,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const HomeScreen(),
            ),
          ),
          GoRoute(
            path: '/announcements',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const AnnouncementScreen(),
            ),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const Center(child: Text('Einstellungen kommen bald!')),
            ),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const Center(child: Text('Profil kommt bald!')),
            ),
          ),
          GoRoute(
            path: '/event',
            builder: (context, state) {
              final event = state.extra as Event;
              return EventScreen(event: event);
            },
          ),
          GoRoute(
            path: '/forum',
            pageBuilder: (context, state) {
              final eventDetails = state.extra as Event;

              return CustomTransitionPage(
                key: state.pageKey,
                child: ForumScreen(event: eventDetails),
                transitionDuration: const Duration(milliseconds: 250),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return slideFromBottomTransition(
                      context, animation, secondaryAnimation, child);
                },
              );
            },
          ),
          GoRoute(
            path: '/forumTopic',
            builder: (context, state) {
              final forumTopic = state.extra as ForumTopic;
              return ForumTopicScreen(forumTopic: forumTopic);
            },
          ),
          GoRoute(
            path: '/vote',
            pageBuilder: (context, state) {
              final eventDetails = state.extra as Event;

              return CustomTransitionPage(
                key: state.pageKey,
                child: VoteScreen(event: eventDetails),
                transitionDuration: const Duration(milliseconds: 250),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return slideFromBottomTransition(
                      context, animation, secondaryAnimation, child);
                },
              );
            },
          ),
          GoRoute(
            path: '/votingTopic',
            builder: (context, state) {
              final votingTopic = state.extra as VotingTopic;
              return VotingTopicScreen(votingTopic: votingTopic);
            },
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
          GoRoute(
            path: '/resources',
            pageBuilder: (context, state) {
              final eventDetails = state.extra as Event;

              return CustomTransitionPage(
                key: state.pageKey,
                child: ResourcesScreen(event: eventDetails),
                transitionDuration: const Duration(milliseconds: 250),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return slideFromBottomTransition(
                      context, animation, secondaryAnimation, child);
                },
              );
            },
          ),
          GoRoute(
            path: '/todo',
            pageBuilder: (context, state) {
              final eventDetails = state.extra as Event;

              return CustomTransitionPage(
                key: state.pageKey,
                child: ToDoScreen(event: eventDetails),
                transitionDuration: const Duration(milliseconds: 250),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return slideFromBottomTransition(
                      context, animation, secondaryAnimation, child);
                },
              );
            },
          ),
        ],
      ),
    ],
  );
}
