import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_barberapp/Utils/Loading.dart';
import 'package:doan_barberapp/components/skin/color_skin.dart';
import 'package:doan_barberapp/components/style/button_size.dart';
import 'package:doan_barberapp/components/widget/app_bar.dart';
import 'package:doan_barberapp/components/widget/filled_button.dart';
import 'package:doan_barberapp/components/widget/form.dart';
import 'package:doan_barberapp/components/widget/icon.dart';
import 'package:doan_barberapp/components/widget/text_button.dart';
import 'package:doan_barberapp/components/widget/text_form_field.dart';
import 'package:doan_barberapp/utils/Validate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/skin/typo_skin.dart';
import '../../../components/style/icon_data.dart';
import '../../../components/widget/SnackBar.dart';
import '../../../generated/l10n.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailTEC = TextEditingController();

  final _key = GlobalKey<FFormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: FColorSkin.grey1,
        appBar: FAppBar(
          toolbarHeight: 76,
          leading: FTextButton.icon(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: FIcon(icon: FOutlined.left_arrow),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(S.of(context).auth_QuenMK,
                style: FTypoSkin.title1.copyWith(color: FColorSkin.title)),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).auth_NhapEmail,
              style: FTypoSkin.title2.copyWith(color: FColorSkin.label),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: FForm(
                key: _key,
                child: FTextFormField(
                  controller: emailTEC,
                  hintText: 'Email',
                  style: FTypoSkin.label2,
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return Validate.commonCheckNull(value, context);
                    }
                    if (value != null) {
                      return Validate.emailValidate(value, context);
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(
              16, 8, 16, 8 + MediaQuery.of(context).padding.bottom),
          child: Row(
            children: [
              Expanded(
                child: FFilledButton(
                  size: FButtonSize.size48,
                  backgroundColor: FColorSkin.primary,
                  onPressed: () async{
                    if(_key.currentState!.validate())
                    {
                      LoadingCore.loadingDialogIos(context);
                      final data = await FirebaseFirestore.instance
                          .collection('users')
                          .where('email',isEqualTo: emailTEC.text)
                          .get();
                      if(data.docs.isEmpty){
                        if(context.mounted) {
                          SnackBarCore.fail(title: S.of(context).auth_ChuaCoEmail);
                        }
                      }
                      else{
                        try{
                          await FirebaseAuth.instance.sendPasswordResetEmail(email: emailTEC.text.trim());
                          if(context.mounted) {
                            SnackBarCore.success(title: S.of(context).auth_DaGui);
                          }
                        }
                        on FirebaseAuthException catch (e){
                          if(context.mounted) {
                            SnackBarCore.fail(title: e.message ?? S.of(context).common_LoiXayRa);
                          }
                        }
                        catch(e){
                          if(context.mounted) {
                            SnackBarCore.fail(title: e.toString());
                          }
                        }
                      }
                      if(context.mounted){
                        Navigator.of(context).pop();
                      }

                    }

                  },
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        S.of(context).auth_Gui,
                        style: FTypoSkin.buttonText1
                            .copyWith(color: FColorSkin.white),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
