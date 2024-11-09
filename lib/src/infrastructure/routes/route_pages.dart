import 'package:get/get.dart';

import '../../pages/add_event/comon/add_event_binding.dart';
import '../../pages/add_event/view/add_event_screen.dart';
import '../../pages/bookmark/comon/bookmark_binding.dart';
import '../../pages/bookmark/view/bookmark_screen.dart';
import '../../pages/edit_event/comon/edit_event_binding.dart';
import '../../pages/edit_event/view/edit_event_screen.dart';
import '../../pages/event_details/common/event_details_binding.dart';
import '../../pages/event_details/view/event_details_screen.dart';
import '../../pages/event_list/comon/event_list_binding.dart';
import '../../pages/event_list/view/event_list_screen.dart';
import '../../pages/login/common/login_binding.dart';
import '../../pages/login/view/login_screen.dart';
import '../../pages/main/common/main_binding.dart';
import '../../pages/main/view/main_screen.dart';
import '../../pages/my_event/comon/my_event_binding.dart';
import '../../pages/my_event/view/my_event_screen.dart';
import '../../pages/signup/common/signup_binding.dart';
import '../../pages/signup/view/signup_screen.dart';
import '../../pages/splash/common/splash_binding.dart';
import '../../pages/splash/view/splash_screen.dart';
import 'route_paths.dart';

class RoutePages {
  static List<GetPage> pages = [
    GetPage(
        name: RoutePaths.splash,
        page: () => SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: RoutePaths.main,
        page: () => MainScreen(),
        binding: MainBinding(),
        children:[
          GetPage(
              name: RoutePaths.addEvent,
              page: () => AddEventScreen(),
              binding: AddEventBinding()),
          GetPage(
              name: RoutePaths.editEvent,
              page: () => EditEventScreen(),
              binding: EditEventBinding()),
        ]
    ),
    GetPage(
        name: RoutePaths.eventDetails,
        page: () => EventDetailsScree(),
        binding: EventDetailsBinding()),
    GetPage(
        name: RoutePaths.eventList,
        page: () => EventListScreen(),
        binding: MainBinding()),
    GetPage(
        name: RoutePaths.bookmark,
        page: () => BookmarkScreen(),
        binding: MainBinding()),
    GetPage(
        name: RoutePaths.login,
        page: () => LoginScreen(),
        binding: LoginBinding(),
        children: [
          GetPage(
            name: RoutePaths.signup,
            page: ()=>SignupScreen(),
            binding: SignupBinding()
          )
        ]),
  ];
}
