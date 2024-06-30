// app_router.dart
import 'package:event_flow/features/announcement/screens/announcements_screen.dart';
import 'package:event_flow/features/create_announcement/screens/create_announcement_screen.dart';
import 'package:event_flow/features/create_event/screens/create_event_screen.dart';
import 'package:event_flow/features/event/screens/event_screen.dart';
import 'package:event_flow/features/forum/screens/forum_screen.dart';
import 'package:event_flow/features/vote/screens/vote_screen.dart';
import 'package:event_flow/features/vote/screens/vote_topic_screen.dart';
import 'package:event_flow/features/vote/widgets/create_voting_topic.dart';
import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data_models/event_data_model.dart';
import '../data_models/forum_topic_data_model.dart';
import '../data_models/voting_topic_data_model.dart';
import '../features/forum/screens/forum_topic_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/vote/screens/create_voting_topic_screen.dart';

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
          }),
      GoRoute(
          path: '/forumTopic',
          builder: (context, state) {
            final topic = state.extra as ForumTopic;
            return ForumTopicScreen(title: topic.title);
          }),
      GoRoute(
          path: '/vote',
          builder: (context, state) {
            final event = state.extra as Event;
            return VoteScreen(event: event);
          }),
      GoRoute(
        path: '/voteTopic',
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
        path: '/createVotingTopic',
        builder: (context, state) {
          final event = state.extra as Event;
          return CreateVotingTopicScreen(event: event);
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
  );
}
