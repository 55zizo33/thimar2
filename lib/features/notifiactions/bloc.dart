
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/dio_helper.dart';

class GetNotificationsBloc extends Bloc<GetNotificationsEvent,
    GetNotificationsStates> {
  final DioHelper _dio;

  GetNotificationsBloc(this._dio) : super(GetNotificationsLoadingState()) {
    on<GetNotificationsEvent>(_getData);
  }

  void _getData(
      GetNotificationsEvent event,
      Emitter<GetNotificationsStates> emit,
      ) async {
    final response = await _dio.get("notifications");
    if (response.isSuccess) {
      final model = NotificationsData.fromJson(response.data["data"]);
      emit(GetNotificationsSuccessState(list: model.list));
    } else {
      emit(GetNotificationsFailedState(msg: response.message!));
    }
  }
}

abstract class GetNotificationsEvents {}

class GetNotificationsEvent extends GetNotificationsEvents {}

abstract class GetNotificationsStates {}

class GetNotificationsLoadingState extends GetNotificationsStates {}

class GetNotificationsFailedState extends GetNotificationsStates {
  final String msg;

  GetNotificationsFailedState({required this.msg});
}

class GetNotificationsSuccessState extends GetNotificationsStates {
  final List<NotificationModel> list;

  GetNotificationsSuccessState({required this.list});
}

class NotificationsData {
  late final int unReadCount;
  late final List<NotificationModel> list;

  NotificationsData.fromJson(Map<String, dynamic> json) {
    unReadCount = json['unreadnotifications_count'] ?? 0;
    list = List.from(json['notifications'] ?? []).map((e) => NotificationModel.fromJson(e)).toList();
  }
}

class NotificationModel {
  late final String id, img, notifyType, title, body, time;
  late bool isRead;
  late final Order order;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? "";
    img = json["image"] ?? "";
    title = json["title"] ?? "";
    body = json["body"] ?? "";
    time = json["created_at"] ?? "";
    isRead = json["is_read"] ?? false;
    notifyType = json['notify_type'] ?? "";
    order = Order.fromJson(json['order'] ?? {});
  }
}

class Order {
  late final int orderId;
  late final int clientId;
  late final int driverId;
  late final String orderStatus;

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'] ?? 0;
    clientId = json['client_id'] ?? 0;
    driverId = json['driver_id'] ?? 0;
    orderStatus = json['order_status'] ?? "";
  }
}
