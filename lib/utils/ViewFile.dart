import 'dart:io';


import 'package:flutter/material.dart';

import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../Utils/DeviceUtils.dart';
import '../../../../../Utils/Loading.dart';
import '../components/skin/color_skin.dart';
import '../components/skin/typo_skin.dart';
import '../components/style/icon_data.dart';
import '../components/widget/SnackBar.dart';
import '../components/widget/app_bar.dart';
import '../components/widget/filled_button.dart';
import '../components/widget/icon.dart';
import '../generated/l10n.dart';
import '../shared/constant.dart';

class ViewFile extends StatefulWidget {
  const ViewFile({
    Key? key,
    required this.url,
    required this.fileType,
    required this.filePath,
    required this.fileName,
  }) : super(key: key);

  final String url;
  final String fileType;
  final String filePath;
  final String fileName;

  @override
  State<ViewFile> createState() => _ViewFileState();
}

class _ViewFileState extends State<ViewFile> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.url),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1C2530),
      extendBodyBehindAppBar: true,
      appBar: FAppBar(
        toolbarHeight: 72,
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: FColorSkin.transparent,
        leading: FFilledButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          backgroundColor: FColorSkin.transparent,
          child: FIcon(
            icon: FOutlined.e_remove,
            color: FColorSkin.white,
          ),
        ),
        // actions: [
        //   if (widget.filePath.isNotEmpty)
        //     FFilledButton.icon(
        //       onPressed: () async {
        //         LoadingCore.loadingDialogIos(context);
        //
        //         final path = await BaseDA.DownloadPostFile(
        //           '${ConfigAPI.DomainApiAgency}${ConfigAPI.getUrlDownloadFile}${widget.filePath}',
        //           widget.fileName,
        //         );
        //         if(context.mounted) {
        //           Navigator.of(context).pop();
        //         }
        //
        //         if (path == '') {
        //           await SnackBarCore.fail(title: S.of(context).common_ThanhCong);
        //         } else {
        //           if (path != '1') {
        //             await SnackBarCore.success(title: S.of(context).common_LoiXayRa);
        //           }
        //         }
        //       },
        //       backgroundColor: FColorSkin.transparent,
        //       child: FIcon(
        //         icon: FFilled.data_download,
        //         color: FColorSkin.white,
        //       ),
        //     ),
        //   SizedBox(width: 12),
        // ],
      ),
      body: Column(
        children: [
          widget.fileType == 'jpeg' || widget.fileType == 'png' || widget.fileType == 'jpg'
              ? SizedBox(height: MediaQuery.of(context).padding.top)
              : Image.asset(
                  'assets/images/barber_bg.jpg',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: 72 + MediaQuery.of(context).padding.top,
                ),

          Expanded(
            child: widget.fileType == 'jpeg' || widget.fileType == 'png' || widget.fileType == 'jpg'
                ? WebViewWidget(
                    controller: controller,
                  )
                : PDF(
                    enableSwipe: true,
                    autoSpacing: Platform.isIOS,
                    pageFling: false,
                  ).cachedFromUrl(
                    widget.url,
                    placeholder: (progress) => BuildShimmer(),
                    errorWidget: (error) => Center(
                        child: Text(
                      error.toString(),
                      style: FTypoSkin.subtitle2.copyWith(
                        color: FColorSkin.white,
                      ),
                    )),
                  ),
          )
        ],
      ),
    );
  }
}
