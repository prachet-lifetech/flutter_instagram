import 'package:flutter/material.dart';
import 'package:flutter_instagram/models/enums/bottom_nav_items.dart';
import 'package:flutter_instagram/screens/screens.dart';

class TabNavigator extends StatelessWidget {
  static const tabNavigatorRoot = '/';

  final GlobalKey<NavigatorState> navigatorKey;
  final BottomNavItem item;

  const TabNavigator({
    Key key,
    @required this.navigatorKey,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders();
    return Navigator(
      key: navigatorKey,
      initialRoute: tabNavigatorRoot,
      onGenerateInitialRoutes: (_, initialRoute) {
        return [
          MaterialPageRoute(
              settings: RouteSettings(name: tabNavigatorRoot),
              builder: (context) => routeBuilders[initialRoute](context))
        ];
      },
    );
  }

  Map<String, WidgetBuilder> _routeBuilders() {
    return {tabNavigatorRoot: (context) => _getScreen(context, item)};
  }

  Widget _getScreen(BuildContext context, BottomNavItem item) {
    switch(item) {
      case BottomNavItem.feed:
          return FeedScreen();
      case BottomNavItem.search:
        return SearchScreen();
      case BottomNavItem.create:
        return CreatePostScreen();
      case BottomNavItem.notifications:
        return NotificationsScreen();
      case BottomNavItem.profile:
        return ProfileScreen();
    }
  }


}
