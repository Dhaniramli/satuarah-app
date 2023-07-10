import 'package:get/get.dart';

import '../modules/cek/bindings/cek_binding.dart';
import '../modules/cek/views/cek_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/chat_room/bindings/chat_room_binding.dart';
import '../modules/chat_room/views/chat_room_view.dart';
import '../modules/edit_a_trip/bindings/edit_a_trip_binding.dart';
import '../modules/edit_a_trip/views/edit_a_trip_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/find_ride/bindings/find_ride_binding.dart';
import '../modules/find_ride/views/find_ride_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/leaving_today/bindings/leaving_today_binding.dart';
import '../modules/leaving_today/views/leaving_today_view.dart';
import '../modules/main_navigation/bindings/main_navigation_binding.dart';
import '../modules/main_navigation/views/main_navigation_view.dart';
import '../modules/make_a_trip/bindings/make_a_trip_binding.dart';
import '../modules/make_a_trip/views/make_a_trip_view.dart';
import '../modules/map/bindings/map_binding.dart';
import '../modules/map/views/map_view.dart';
import '../modules/order_detail/bindings/order_detail_binding.dart';
import '../modules/order_detail/views/order_detail_view.dart';
import '../modules/ordering/bindings/ordering_binding.dart';
import '../modules/ordering/views/ordering_view.dart';
import '../modules/ordering_map/bindings/ordering_map_binding.dart';
import '../modules/ordering_map/views/ordering_map_view.dart';
import '../modules/popular_route/bindings/popular_route_binding.dart';
import '../modules/popular_route/views/popular_route_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register_driver/bindings/register_driver_binding.dart';
import '../modules/register_driver/views/register_driver_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/search_ride/bindings/search_ride_binding.dart';
import '../modules/search_ride/views/search_ride_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.signIn,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.signUp,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.mainNavigation,
      page: () => const MainNavigationView(),
      binding: MainNavigationBinding(),
    ),
    GetPage(
      name: _Paths.POPULAR_ROUTE,
      page: () => PopularRouteView(),
      binding: PopularRouteBinding(),
    ),
    GetPage(
      name: _Paths.LEAVING_TODAY,
      page: () => const LeavingTodayView(),
      binding: LeavingTodayBinding(),
    ),
    GetPage(
      name: _Paths.FIND_RIDE,
      page: () => FindRideView(),
      binding: FindRideBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.CEK,
      page: () => const CekView("", ""),
      binding: CekBinding(),
    ),
    GetPage(
      name: _Paths.ORDERING,
      page: () => const OrderingView(),
      binding: OrderingBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAIL,
      page: () => const OrderDetailView(),
      binding: OrderDetailBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_DRIVER,
      page: () => const RegisterDriverView(),
      binding: RegisterDriverBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_ROOM,
      page: () => const ChatRoomView(),
      binding: ChatRoomBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.MAKE_A_TRIP,
      page: () => const MakeATripView(),
      binding: MakeATripBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_A_TRIP,
      page: () => const EditATripView(),
      binding: EditATripBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_RIDE,
      page: () => const SearchRideView(),
      binding: SearchRideBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.MAP,
      page: () => const MapView(),
      binding: MapBinding(),
    ),
    GetPage(
      name: _Paths.ORDERING_MAP,
      page: () => const OrderingMapView(),
      binding: OrderingMapBinding(),
    ),
  ];
}
