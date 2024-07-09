import 'package:app/core/app_theme.dart';
import 'package:app/views/auth/components/have_account_or_not.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import '../../design/app_button.dart';
import '../../design/app_image.dart';
import '../../design/app_input.dart';
import '../../features/register/bloc.dart';
import '../../logic/input_validator.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final bloc = GetIt.instance<RegisterBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key:bloc.formKey ,
          child: SingleChildScrollView(
            padding:  EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppImage(
                  "logo.png",
                  height: 125.h,
                  width: 130.w,

                ),
                SizedBox(height: 16.h),
                Text(
                  "welcomeTo".tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "youCanRegisterNow".tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppTheme.grey,
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                AppInput(
                  controller: bloc.userNameController,
                  label: "userName".tr(),
                  prefixIcon:"user_name.png" ,
                ),

                AppInput(
                  controller: bloc.phoneController,
                  label: "phoneNumber".tr(),
                  prefixIcon:"phone.png" ,
                  validator: InputValidator.phone,
                  inputType: InputType.phone,
                ),
                AppInput(
                  controller: bloc.cityController,
                  label: "city".tr(),
                  prefixIcon:"city.png" ,
                ),
                AppInput(
                  controller: bloc.passwordController,
                  label: "password".tr(),
                  prefixIcon:"password.png" ,
                  validator: InputValidator.password,
                  inputType: InputType.password,
                ),
                AppInput(
                  controller: bloc.confrimPasswordController,
                  label: "confirmPassword".tr(),
                  prefixIcon:"password.png" ,
                  validator: InputValidator.password,
                  inputType: InputType.password,
                ),
                SizedBox(height: 16.h),
                BlocBuilder(
                    bloc: bloc,
                    builder: (context,state) =>AppButton(
                      isLoading: state is RegisterLoadingState,
                      onPressed: () {
                        bloc.add(RegisterEvent());
                      },
                      text: "register".tr(),
                    )
                ),
                HaveAccountOrNot(fromRegister: true,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}