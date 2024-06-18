import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_barberapp/Utils/Loading.dart';
import 'package:doan_barberapp/project/booking/widgets/CommonDialog.dart';
import 'package:doan_barberapp/shared/models/UserModel.dart';
import 'package:doan_barberapp/shared/repository/DataRepository.dart';
import 'package:doan_barberapp/utils/ViewFile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/skin/color_skin.dart';
import '../../../components/skin/typo_skin.dart';
import '../../../components/style/icon_data.dart';
import '../../../components/widget/SnackBar.dart';
import '../../../components/widget/app_bar.dart';
import '../../../components/widget/icon.dart';
import '../../../components/widget/text_button.dart';
import '../../../generated/l10n.dart';
import '../../../shared/constant.dart';

class ImageGallery extends StatefulWidget {
  const ImageGallery({super.key, this.user});

  final UserModel? user;

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  File? img;

  Future<File?> pickImage() async {
    File? image;
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        image = File(pickedImage.path);
        if (mounted) {
          LoadingCore.loadingDialogIos(context);
        }
        await DataRepository().saveImage(file: image,userId: widget.user?.uid);
        if (mounted) {
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      SnackBarCore.fail(title: 'Error picking image');
    }
    return image;
  }

  void selectImage() async {
    img = await pickImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppBar(
        toolbarHeight: 88,
        backgroundColor: FColorSkin.primary,
        leading: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: FTextButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: FIcon(
              icon: FOutlined.left_arrow,
              color: FColorSkin.white,
              size: 20,
            ),
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            S.of(context).gallery_ThuVienAnh,
            style: FTypoSkin.title2
                .copyWith(color: FColorSkin.white, fontWeight: FontWeight.w500),
          ),
        ),
        actions: widget.user?.role == 'barber'
            ? [
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: FTextButton.icon(
                      child: FIcon(
                        icon: FOutlined.folder_add,
                        color: FColorSkin.white,
                        size: 20,
                      ),
                      onPressed: selectImage),
                )
              ]
            : [],
      ),
      backgroundColor: FColorSkin.white,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('gallery').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildLoading();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(S.of(context).common_LoiXayRa),
            );
          } else if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.docs.isEmpty) {
            return BuildEmptyData(
                title: S.of(context).gallery_KhongCoAnhTrongThuVien);
          }
          final data = snapshot.data?.docs;
          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: data?.length ?? 0,
            itemBuilder: (context, index) {
              final img = data?[index].data()['image'];
              print(data?[index].id);
              return GestureDetector(
                  onLongPress: widget.user?.role == 'barber'
                      ? () {
                          showDialog(
                            context: context,
                            builder: (context) => CommonDialog(
                                type: EnumTypeDialog.error,
                                title: S.of(context).gallery_XoaAnh,
                                subtitle:
                                    S.of(context).gallery_BanCoChacXoaAnhNay,
                                cancelTitle: S.of(context).common_QuayLai,
                                continueTitle: S.of(context).common_XacNhan,
                                onContinue: () async {
                                  LoadingCore.loadingDialogIos(context);
                                  try {
                                    await FirebaseFirestore.instance
                                        .collection('gallery')
                                        .doc(data?[index].id)
                                        .delete();
                                    if (context.mounted) {
                                      SnackBarCore.success(
                                          title: S
                                              .of(context)
                                              .gallery_XoaThanhCong);
                                    }
                                  } on FirebaseException catch (e) {
                                    if (context.mounted) {
                                      SnackBarCore.fail(
                                          title: e.message ??
                                              S.of(context).gallery_XoaThatBai);
                                    }
                                  } catch (e) {
                                    rethrow;
                                  }
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  }
                                }),
                          );
                        }
                      : null,
                  child: BuildImage(ratio: 1, url: img ?? ''));
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 12),
          );
        },
      ),
    );
  }

  Widget buildLoading() {
    return BuildShimmer(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
            0, 16, 0, 0 + MediaQuery.of(context).padding.bottom),
        child: Column(
          children: [
            ...List.generate(
              10,
              (index) => Container(
                margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                height: 182,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: FColorSkin.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
