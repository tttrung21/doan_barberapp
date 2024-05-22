import 'dart:math';

import 'package:doan_barberapp/components/skin/color_skin.dart';
import 'package:doan_barberapp/components/skin/typo_skin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import '../../../components/widget/SnackBar.dart';
import '../../../generated/l10n.dart';
import '../../../shared/bloc/auth_bloc/auth_bloc.dart';
import '../../../shared/constant.dart';
import 'Login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameTEC.dispose();
    passwordTEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: FColorSkin.white,
          body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                SnackBarCore.success(title: S.of(context).common_ThanhCong);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              }
              if (state is AuthError) {
                SnackBarCore.fail(title: state.message ?? S.of(context).common_LoiXayRa);
                // showDialog(
                //     context: context,
                //     builder: (context) => AlertDialog(
                //           content: Container(
                //             padding: EdgeInsets.all(4),
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(15)),
                //             child: Text(state.message ?? ''),
                //           ),
                //         ));
              }
            },
            listenWhen: (previous, current) => current is AuthSuccess || current is AuthError,
            builder: (context, state) {
              if (state is AuthLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
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
                          child:  Text(
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
                                                    style: const TextStyle(color: Colors.black),
                                                    obscureText: true,
                                                    decoration:
                                                    InputDecoration(labelText: S.of(context).auth_MatKhau),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    controller: passwordTEC,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return S.of(context).common_LoiThongTinTrong;
                                                      } else if (value.length < 8) {
                                                        return S.of(context).common_LoiMK8KyTu;
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                    obscureText: true,
                                                    decoration:
                                                         InputDecoration(
                                                            labelText: S.of(context).auth_NhapLaiMatKhau),
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return S.of(context).common_LoiThongTinTrong;
                                                      } else if (value !=
                                                          passwordTEC.text) {
                                                        return S.of(context).common_LoiMKKhac;
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                                  CupertinoButton(
                                                    onPressed: () {
                                                      final validate = Form.of(context).validate();
                                                      if (!validate) {
                                                        return;
                                                      }
                                                      Form.of(context).save();
                                                      context.read<AuthBloc>().add(
                                                          SignUpRequestedEvent(
                                                              email: nameTEC.text,
                                                              password: passwordTEC.text));
                                                    },
                                                    borderRadius: BorderRadius.circular(100),
                                                    color: FColorSkin.primary,
                                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                                    child: Text(
                                                      S.of(context).auth_DangKy,
                                                      style: TextStyle(color: FColorSkin.white),
                                                    ),
                                                  )
                                                ],
                                              ))),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      S.of(context).auth_DaCoTK,
                                      style: FTypoSkin.title4
                                          .copyWith(color: FColorSkin.title),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => SignInScreen()));
                                      },
                                      child: Text(
                                        S.of(context).auth_nDangNhap,
                                        style: FTypoSkin.title4.copyWith(
                                            color: FColorSkin.error),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
