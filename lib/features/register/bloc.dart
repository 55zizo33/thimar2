import 'dart:async';
import 'dart:io';
import 'package:app/views/auth/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/dio_helper.dart';
import '../../logic/helper_methods.dart';


part 'states.dart';
part 'events.dart';

class RegisterBloc extends Bloc<RegisterEvents, RegisterStates> {
  final DioHelper _dio;

  RegisterBloc(this._dio) : super(RegisterStates()) {
    on<RegisterEvent>(_sendData);
  }


  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final userNameController = TextEditingController();
  final cityController = TextEditingController(text: "بنها");
  final passwordController = TextEditingController();
  final confrimPasswordController = TextEditingController();

  Future<void> _sendData(RegisterEvent event,
      Emitter<RegisterStates> emit) async {
    if (formKey.currentState!.validate()) {
      emit(RegisterLoadingState());
      final response = await _dio.send("client_register", data: {
        "fullname": userNameController.text,
        "phone": phoneController.text,
        "password": passwordController.text,
        "password_confirmation": confrimPasswordController.text,
        "city_id":5,
        "country_id":1,
      });
      if (response.isSuccess) {
        showMessage(response.message!,messageType: MessageType.success);
        navigateTo(OTPView(phone: phoneController.text));
        emit(RegisterSuccessState());
      } else {
        showMessage(response.message!);
        emit(RegisterFailedState());
      }
    }
  }
}