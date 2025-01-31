



import 'package:app/features/get_profile/bloc.dart';
import 'package:app/features/get_profile_images/bloc.dart';
import 'package:app/features/notifiactions/bloc.dart';
import 'package:app/features/products/bloc.dart';
import 'package:app/features/register/bloc.dart';
import 'package:app/features/sliders/bloc.dart';
import 'package:app/features/update_cart_item/bloc.dart';
import 'package:get_it/get_it.dart';

import '../logic/dio_helper.dart';
import 'add_to_cart/bloc.dart';
import 'app_info/bloc.dart';
import 'cart/bloc.dart';
import 'categories/bloc.dart';
import 'contact_us/bloc.dart';
import 'login/bloc.dart';
import 'otp/bloc.dart';

void initServiceLocator() {
  final container = GetIt.instance;

  container.registerSingleton(DioHelper());
  container.registerFactory(() => LoginBloc(GetIt.instance<DioHelper>()));
  container.registerFactory(() => AddToCartBloc(GetIt.instance<DioHelper>()));
  container.registerFactory(() => ContactUsBloc(GetIt.instance<DioHelper>()));
  container.registerFactory(() => RegisterBloc(GetIt.instance<DioHelper>()));
  container.registerFactory(() => UpdateCartItemBloc(GetIt.instance<DioHelper>()));
  container.registerFactory(() => AppInfoBloc(GetIt.instance<DioHelper>())..add(GetAppInfoEvent()));
  container.registerFactory(() => CategoriesBloc(GetIt.instance<DioHelper>())..add(GetCategoriesEvent()));
  container.registerFactory(() => SliderBloc(GetIt.instance<DioHelper>())..add(GetSliderEvent()));
  container.registerFactory(() => ProductsBloc(GetIt.instance<DioHelper>())..add(GetProductsEvent()));
  container.registerFactory(() => CartBloc(GetIt.instance<DioHelper>())..add(GetCartEvent()));
  container.registerFactory(() => OTPBloc(GetIt.instance<DioHelper>()));
  container.registerFactory(() => GetNotificationsBloc(GetIt.instance<DioHelper>())..add(GetNotificationsEvent()));
  container.registerFactory(() => GetProfileBloc(GetIt.instance<DioHelper>())..add(GetProfileEvent()));
  container.registerFactory(() => GetProfileImagesBloc(GetIt.instance<DioHelper>())..add(GetProfileImagesEvent()));


}