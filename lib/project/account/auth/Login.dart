import 'dart:math';

import 'package:doan_barberapp/components/skin/color_skin.dart';
import 'package:doan_barberapp/components/skin/typo_skin.dart';
import 'package:doan_barberapp/components/widget/SnackBar.dart';
import 'package:doan_barberapp/project/Home.dart';
import 'package:doan_barberapp/project/account/auth/Register.dart';
import 'package:doan_barberapp/shared/constant.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../../../shared/bloc/auth_bloc/auth_bloc.dart';
import '../../../shared/repository/AuthRepository.dart';
import 'ForgotPassword.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  AuthRepository authRepository = AuthRepository();
  bool guest = false;

  @override
  void dispose() {
    super.dispose();
    nameTEC.dispose();
    passwordTEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: FColorSkin.white,
        body: BlocConsumer<AuthBloc, AuthState>(
          listenWhen: (previous, current) => current is AuthSuccess || current is AuthError,
          listener: (context, state) {
            if (state is AuthSuccess) {
              if(guest == false) {
                SnackBarCore.success(title: S.of(context).common_ThanhCong);
              }
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (ctx) => const MyHomePage()));
            }
            if (state is AuthError) {
              SnackBarCore.fail(title: state.message ?? S.of(context).common_LoiXayRa);
              // showDialog(
              //     context: context,
              //     builder: (context) => AlertDialog(
              //       content: Container(
              //         padding: EdgeInsets.all(4),
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(15)),
              //         child: Text(state.message ?? S.of(context).common_LoiXayRa),
              //       ),
              //     ));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20.0,left: 16),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 94.0),
                        transform: Matrix4.rotationZ(-8 * pi / 180)
                          ..translate(-10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: FColorSkin.primary,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black26,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Text(
                          shopName,
                          style: FTypoSkin.title1.copyWith(color: FColorSkin.white),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Form(
                                    key: _formKey,
                                    child: Builder(
                                        builder: (context) => Column(
                                              children: [
                                                TextFormField(
                                                  style: const TextStyle(color: Colors.black),
                                                  decoration: const InputDecoration(labelText: 'Email'),
                                                  textInputAction: TextInputAction.next,
                                                  controller: nameTEC,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return S.of(context).common_LoiThongTinTrong;
                                                    }
                                                    if (!EmailValidator
                                                        .validate(value)) {
                                                      return S.of(context).common_LoiEmailKhongHopLe;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                TextFormField(
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  obscureText: true,
                                                  decoration: InputDecoration(
                                                          labelText:
                                                          S.of(context).auth_MatKhau,),
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  controller: passwordTEC,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return S.of(context).common_LoiThongTinTrong;
                                                    } else if (value.length <
                                                        8) {
                                                      return S.of(context).common_LoiMK8KyTu;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context).size.height *
                                                      0.02,
                                                ),
                                                if (state is AuthLoadingState)
                                                  const Center(child: CircularProgressIndicator(),)
                                                else
                                                  CupertinoButton(
                                                    onPressed: () {
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                      final validate =
                                                          Form.of(context)
                                                              .validate();
                                                      if (!validate) {
                                                        return;
                                                      }
                                                      Form.of(context).save();
                                                      guest = false;
                                                      context.read<AuthBloc>().add(
                                                          SignInRequestedEvent(
                                                              email: nameTEC.text,
                                                              password: passwordTEC.text));
                                                    },
                                                    borderRadius: BorderRadius.circular(100),
                                                    color: FColorSkin.primary,
                                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                                    child: Text(
                                                      S.of(context).auth_DangNhap,
                                                      style: TextStyle(color: FColorSkin.white),
                                                    ),
                                                  )
                                              ],
                                            ))),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPassword()));
                                  },
                                  child: Text(
                                    S.of(context).auth_QuenMK,
                                    style: TextStyle(color: FColorSkin.primary),
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    S.of(context).auth_ChuaCoTK,
                                    style: FTypoSkin.title4
                                        .copyWith(color: FColorSkin.title),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (ctx) => const Register()));
                                    },
                                    child: Text(
                                      S.of(context).auth_nDangKy,
                                      style: FTypoSkin.title4
                                          .copyWith(color: FColorSkin.error),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Divider(
                          indent: MediaQuery.of(context).size.width * 0.4,
                        ),
                        Text(S.of(context).auth_Hoac,),
                        Divider(
                          indent: MediaQuery.of(context).size.width * 0.4,
                        )
                      ],
                    ),
                    const SizedBox(height: 5,),
                    TextButton(
                        onPressed: () {
                          guest = true;
                          context.read<AuthBloc>().add(GuestLoginEvent());
                        },
                        child: Text(S.of(context).auth_DangNhapKhach,)),
                    // Container(
                    //   margin: const EdgeInsets.symmetric(
                    //       horizontal: 10, vertical: 5),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15),
                    //       color: Theme.of(context)
                    //           .colorScheme
                    //           .secondaryContainer),
                    //   child: InkWell(
                    //     onTap: () {
                    //       // context.read<AuthBloc>().add(GoogleSignInEvent());
                    //     },
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           'Continue with Google',
                    //           style: TextStyle(
                    //               color: Theme.of(context)
                    //                   .colorScheme
                    //                   .onSecondaryContainer),
                    //         ),
                    //         Image.asset(
                    //           'assets/google.png',
                    //           height: 50,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
