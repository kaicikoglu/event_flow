// app_router.dart
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

import '../data_models/event/event_data_model.dart';
import '../data_models/forum/forum_topic_data_model.dart';
import '../features/forum_topic/screen/forum_topic_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/vote/screens/create_voting_topic_screen.dart';
import 'navigation_helpers.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    routes: [
      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context, state, child) {
          return BaseScreen(
            selectedIndex: getSelectedIndex(state.uri.toString()),
            title: getTitle(state.uri.toString()),
            centerTitle: true,
            // Ensure title is centered
            floatingActionButton:
                getFloatingActionButton(state.uri.toString(), context),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            backButton: shouldShowBackButton(state.uri.toString())
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
              final forumTopic = state.extra as ForumTopic;
              return ForumTopicScreen(forumTopicId: forumTopic.id);
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
            path: '/createVotingTopic',
            builder: (context, state) {
              final event = state.extra as Event;
              return CreateVotingTopicScreen(event: event);
            },
          ),
          GoRoute(
            path: '/vote_topic_screen',
            builder: (context, state) {
              final extras = state.extra as Map<String, dynamic>;
              final event = extras['event'] as Event;
              final votingTitle = extras['voting_title'] as String;
              return VoteTopicScreen(event: event, title: votingTitle);
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
        ],
      ),
    ],
  );
}
