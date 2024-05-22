import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_barberapp/common/DropdownItem.dart';
import 'package:doan_barberapp/components/widget/icon.dart';
import 'package:doan_barberapp/utils/ConvertUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/skin/color_skin.dart';
import '../../../components/skin/typo_skin.dart';
import '../../../components/style/elevation.dart';
import '../../../components/style/icon_data.dart';
import '../../../components/widget/divider.dart';
import '../../../generated/l10n.dart';
import '../../../shared/constant.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {

  String getImg(int? id) {
    switch (id) {
      case 1:
        return 'assets/images/services/cattoc.jpg';
      case 2:
        return 'assets/images/services/goidau.jpg';
      case 3:
        return 'assets/images/services/taokieutoc.jpg';
      case 4:
        return 'assets/images/services/ngoaytai.jpg';
      case 5:
        return 'assets/images/services/caorau.jpg';
      case 6:
        return 'assets/images/services/nhuomtoc.jpg';
      case 7:
        return 'assets/images/services/massagedau.jpg';
      default:
        return '';
    }
  }

  String getDescription(int? id) {
    switch (id) {
      case 1:
        return S.of(context).service_MoTaCatToc;
      case 2:
        return S.of(context).service_MoTaGoiDau;
      case 3:
        return S.of(context).service_MoTaTaoKieu;
      case 4:
        return S.of(context).service_MoTaNgoayTai;
      case 5:
        return S.of(context).service_MoTaCaoRau;
      case 6:
        return S.of(context).service_MoTaNhuomToc;
      case 7:
        return S.of(context).service_MoTaMassageDau;
      default:
        return '';
    }
  }

  String getDuration(int? id){
    switch (id) {
      case 1:
        return '20 - 30${S.of(context).service_Phut}';
      case 2:
        return '10 - 15${S.of(context).service_Phut}';
      case 3:
        return '30 - 60${S.of(context).service_Phut}';
      case 4:
        return '5 - 10${S.of(context).service_Phut}';
      case 5:
        return '5 - 10${S.of(context).service_Phut}';
      case 6:
        return '60 - 120${S.of(context).service_Phut}';
      case 7:
        return '20 - 30${S.of(context).service_Phut}';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                S.of(context).service_DichVu,
                style: FTypoSkin.title2.copyWith(color: FColorSkin.title),
              ),
            ),
            FDivider(
              height: 0,
              color: FColorSkin.border2,
            ),
            const SizedBox(height: 16,),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('services')
                  .snapshots(),
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
                      title: S.of(context).common_DuLieuTrong);
                }
                final listService = snapshot.data?.docs;
                return ListView.separated(
                  padding: EdgeInsets.all(8),
                  physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      DropdownItem serviceItem = DropdownItem.fromJson(listService?[index].data() as Map<String,dynamic>);
                      return buildServiceItem(serviceItem);
                    },
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const SizedBox(height: 16,),
                    itemCount: listService?.length ?? 0);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildServiceItem(DropdownItem? service) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: FColorSkin.white,
          boxShadow: FElevation.elevation),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                  image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  getImg(service?.id),
                ),
              )),
              alignment: Alignment.topLeft,),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              getDescription(service?.id),
              style: FTypoSkin.bodyText2.copyWith(color: FColorSkin.body),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                FIcon(icon: FOutlined.clock),
                SizedBox(width: 4,),
                Text(
                  '${S.of(context).service_ThoiGian}${getDuration(service?.id)}',
                  style: FTypoSkin.bodyText2.copyWith(color: FColorSkin.body),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                FIcon(icon: FFilled.credit_card),
                SizedBox(width: 4,),
                Text(
                  '${S.of(context).service_GiaTu}${ConvertUtils.formatCurrency(service?.price)} VND',
                  style: FTypoSkin.bodyText2.copyWith(color: FColorSkin.body),
                ),
              ],
            ),
          ),
        ],
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
