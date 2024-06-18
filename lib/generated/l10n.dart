// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Shop is currently closed!`
  String get shop_closed {
    return Intl.message(
      'Shop is currently closed!',
      name: 'shop_closed',
      desc: '',
      args: [],
    );
  }

  /// `Shop is currently opening!`
  String get shop_opened {
    return Intl.message(
      'Shop is currently opening!',
      name: 'shop_opened',
      desc: '',
      args: [],
    );
  }

  /// `January`
  String get common_Thang1 {
    return Intl.message(
      'January',
      name: 'common_Thang1',
      desc: '',
      args: [],
    );
  }

  /// `February`
  String get common_Thang2 {
    return Intl.message(
      'February',
      name: 'common_Thang2',
      desc: '',
      args: [],
    );
  }

  /// `March`
  String get common_Thang3 {
    return Intl.message(
      'March',
      name: 'common_Thang3',
      desc: '',
      args: [],
    );
  }

  /// `April`
  String get common_Thang4 {
    return Intl.message(
      'April',
      name: 'common_Thang4',
      desc: '',
      args: [],
    );
  }

  /// `May`
  String get common_Thang5 {
    return Intl.message(
      'May',
      name: 'common_Thang5',
      desc: '',
      args: [],
    );
  }

  /// `June`
  String get common_Thang6 {
    return Intl.message(
      'June',
      name: 'common_Thang6',
      desc: '',
      args: [],
    );
  }

  /// `July`
  String get common_Thang7 {
    return Intl.message(
      'July',
      name: 'common_Thang7',
      desc: '',
      args: [],
    );
  }

  /// `August`
  String get common_Thang8 {
    return Intl.message(
      'August',
      name: 'common_Thang8',
      desc: '',
      args: [],
    );
  }

  /// `September`
  String get common_Thang9 {
    return Intl.message(
      'September',
      name: 'common_Thang9',
      desc: '',
      args: [],
    );
  }

  /// `October`
  String get common_Thang10 {
    return Intl.message(
      'October',
      name: 'common_Thang10',
      desc: '',
      args: [],
    );
  }

  /// `November`
  String get common_Thang11 {
    return Intl.message(
      'November',
      name: 'common_Thang11',
      desc: '',
      args: [],
    );
  }

  /// `December`
  String get common_Thang12 {
    return Intl.message(
      'December',
      name: 'common_Thang12',
      desc: '',
      args: [],
    );
  }

  /// `Quarter`
  String get common_quy {
    return Intl.message(
      'Quarter',
      name: 'common_quy',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get common_Thang {
    return Intl.message(
      'Month',
      name: 'common_Thang',
      desc: '',
      args: [],
    );
  }

  /// `Choose`
  String get common_Chon {
    return Intl.message(
      'Choose',
      name: 'common_Chon',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get common_ThanhCong {
    return Intl.message(
      'Success',
      name: 'common_ThanhCong',
      desc: '',
      args: [],
    );
  }

  /// `Error occurred`
  String get common_LoiXayRa {
    return Intl.message(
      'Error occurred',
      name: 'common_LoiXayRa',
      desc: '',
      args: [],
    );
  }

  /// `Field cannot be empty!`
  String get common_LoiThongTinTrong {
    return Intl.message(
      'Field cannot be empty!',
      name: 'common_LoiThongTinTrong',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get common_LoiEmailKhongHopLe {
    return Intl.message(
      'Invalid email',
      name: 'common_LoiEmailKhongHopLe',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters long`
  String get common_LoiMK8KyTu {
    return Intl.message(
      'Password must be at least 8 characters long',
      name: 'common_LoiMK8KyTu',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get common_LoiMKKhac {
    return Intl.message(
      'Passwords do not match',
      name: 'common_LoiMKKhac',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get common_ThongBao {
    return Intl.message(
      'Notification',
      name: 'common_ThongBao',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to use this feature`
  String get common_DNTruoc {
    return Intl.message(
      'Sign in to use this feature',
      name: 'common_DNTruoc',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get common_QuayLai {
    return Intl.message(
      'Back',
      name: 'common_QuayLai',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get common_DangNhap {
    return Intl.message(
      'Sign in',
      name: 'common_DangNhap',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get common_TimKiem {
    return Intl.message(
      'Search',
      name: 'common_TimKiem',
      desc: '',
      args: [],
    );
  }

  /// `No results found`
  String get common_KhongCoKQ {
    return Intl.message(
      'No results found',
      name: 'common_KhongCoKQ',
      desc: '',
      args: [],
    );
  }

  /// `Search again`
  String get common_TimKiemKhac {
    return Intl.message(
      'Search again',
      name: 'common_TimKiemKhac',
      desc: '',
      args: [],
    );
  }

  /// `I understand`
  String get common_ToiDaHieu {
    return Intl.message(
      'I understand',
      name: 'common_ToiDaHieu',
      desc: '',
      args: [],
    );
  }

  /// `No rights to access this feature`
  String get common_KhongCoQuyen {
    return Intl.message(
      'No rights to access this feature',
      name: 'common_KhongCoQuyen',
      desc: '',
      args: [],
    );
  }

  /// `Empty Data`
  String get common_DuLieuTrong {
    return Intl.message(
      'Empty Data',
      name: 'common_DuLieuTrong',
      desc: '',
      args: [],
    );
  }

  /// `Choose language`
  String get common_ChonNgonNgu {
    return Intl.message(
      'Choose language',
      name: 'common_ChonNgonNgu',
      desc: '',
      args: [],
    );
  }

  /// `Vietnamese`
  String get common_TiengViet {
    return Intl.message(
      'Vietnamese',
      name: 'common_TiengViet',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get common_TiengAnh {
    return Intl.message(
      'English',
      name: 'common_TiengAnh',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Information`
  String get common_ThongTinKhongHopLe {
    return Intl.message(
      'Invalid Information',
      name: 'common_ThongTinKhongHopLe',
      desc: '',
      args: [],
    );
  }

  /// `Do not leave any information field blank!`
  String get common_ThieuThongTin {
    return Intl.message(
      'Do not leave any information field blank!',
      name: 'common_ThieuThongTin',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Email`
  String get common_EmailKhongHopLe {
    return Intl.message(
      'Invalid Email',
      name: 'common_EmailKhongHopLe',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get common_XacNhan {
    return Intl.message(
      'Confirm',
      name: 'common_XacNhan',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get common_BoLoc {
    return Intl.message(
      'Filter',
      name: 'common_BoLoc',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get common_ThietLapLai {
    return Intl.message(
      'Reset',
      name: 'common_ThietLapLai',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get common_ApDung {
    return Intl.message(
      'Apply',
      name: 'common_ApDung',
      desc: '',
      args: [],
    );
  }

  /// `Phone numbers include 10 characters and start with a prefix available in Vietnam`
  String get common_SDTGom10KyTu {
    return Intl.message(
      'Phone numbers include 10 characters and start with a prefix available in Vietnam',
      name: 'common_SDTGom10KyTu',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get auth_DangNhap {
    return Intl.message(
      'Log in',
      name: 'auth_DangNhap',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get auth_DangKy {
    return Intl.message(
      'Sign up',
      name: 'auth_DangKy',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get auth_MatKhau {
    return Intl.message(
      'Password',
      name: 'auth_MatKhau',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get auth_NhapLaiMatKhau {
    return Intl.message(
      'Confirm Password',
      name: 'auth_NhapLaiMatKhau',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get auth_QuenMK {
    return Intl.message(
      'Forgot Password',
      name: 'auth_QuenMK',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? Try `
  String get auth_ChuaCoTK {
    return Intl.message(
      'Don\'t have an account? Try ',
      name: 'auth_ChuaCoTK',
      desc: '',
      args: [],
    );
  }

  /// `signing up`
  String get auth_nDangKy {
    return Intl.message(
      'signing up',
      name: 'auth_nDangKy',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get auth_Hoac {
    return Intl.message(
      'Or',
      name: 'auth_Hoac',
      desc: '',
      args: [],
    );
  }

  /// `Log in as guest`
  String get auth_DangNhapKhach {
    return Intl.message(
      'Log in as guest',
      name: 'auth_DangNhapKhach',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? Try `
  String get auth_DaCoTK {
    return Intl.message(
      'Already have an account? Try ',
      name: 'auth_DaCoTK',
      desc: '',
      args: [],
    );
  }

  /// `logging in`
  String get auth_nDangNhap {
    return Intl.message(
      'logging in',
      name: 'auth_nDangNhap',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get auth_NhapEmail {
    return Intl.message(
      'Enter your email',
      name: 'auth_NhapEmail',
      desc: '',
      args: [],
    );
  }

  /// `Send reset password email`
  String get auth_Gui {
    return Intl.message(
      'Send reset password email',
      name: 'auth_Gui',
      desc: '',
      args: [],
    );
  }

  /// `No such email in the database`
  String get auth_ChuaCoEmail {
    return Intl.message(
      'No such email in the database',
      name: 'auth_ChuaCoEmail',
      desc: '',
      args: [],
    );
  }

  /// `Reset password email sent`
  String get auth_DaGui {
    return Intl.message(
      'Reset password email sent',
      name: 'auth_DaGui',
      desc: '',
      args: [],
    );
  }

  /// `Schedule your appointment now at`
  String get home_DatLichNgay {
    return Intl.message(
      'Schedule your appointment now at',
      name: 'home_DatLichNgay',
      desc: '',
      args: [],
    );
  }

  /// `Popular Cuts`
  String get home_KieuTocThinhHanh {
    return Intl.message(
      'Popular Cuts',
      name: 'home_KieuTocThinhHanh',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get home_XinChao {
    return Intl.message(
      'Hello',
      name: 'home_XinChao',
      desc: '',
      args: [],
    );
  }

  /// `Learn more`
  String get home_TimHieuThem {
    return Intl.message(
      'Learn more',
      name: 'home_TimHieuThem',
      desc: '',
      args: [],
    );
  }

  /// `Featured Services`
  String get home_DichVuNoiBat {
    return Intl.message(
      'Featured Services',
      name: 'home_DichVuNoiBat',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get home_GiaTu {
    return Intl.message(
      'From',
      name: 'home_GiaTu',
      desc: '',
      args: [],
    );
  }

  /// `Haircut`
  String get home_CatToc {
    return Intl.message(
      'Haircut',
      name: 'home_CatToc',
      desc: '',
      args: [],
    );
  }

  /// `Hair Dye`
  String get home_NhuomToc {
    return Intl.message(
      'Hair Dye',
      name: 'home_NhuomToc',
      desc: '',
      args: [],
    );
  }

  /// `Hair Styling`
  String get home_TaoKieu {
    return Intl.message(
      'Hair Styling',
      name: 'home_TaoKieu',
      desc: '',
      args: [],
    );
  }

  /// `Image Gallery`
  String get gallery_ThuVienAnh {
    return Intl.message(
      'Image Gallery',
      name: 'gallery_ThuVienAnh',
      desc: '',
      args: [],
    );
  }

  /// `No photos in the gallery`
  String get gallery_KhongCoAnhTrongThuVien {
    return Intl.message(
      'No photos in the gallery',
      name: 'gallery_KhongCoAnhTrongThuVien',
      desc: '',
      args: [],
    );
  }

  /// `Delete Image`
  String get gallery_XoaAnh {
    return Intl.message(
      'Delete Image',
      name: 'gallery_XoaAnh',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete this image?`
  String get gallery_BanCoChacXoaAnhNay {
    return Intl.message(
      'Are you sure to delete this image?',
      name: 'gallery_BanCoChacXoaAnhNay',
      desc: '',
      args: [],
    );
  }

  /// `Successfully delete image`
  String get gallery_XoaThanhCong {
    return Intl.message(
      'Successfully delete image',
      name: 'gallery_XoaThanhCong',
      desc: '',
      args: [],
    );
  }

  /// `Error delete image`
  String get gallery_XoaThatBai {
    return Intl.message(
      'Error delete image',
      name: 'gallery_XoaThatBai',
      desc: '',
      args: [],
    );
  }

  /// `Book now`
  String get booking_DatNgay {
    return Intl.message(
      'Book now',
      name: 'booking_DatNgay',
      desc: '',
      args: [],
    );
  }

  /// `Schedule appointment`
  String get booking_DatLichHen {
    return Intl.message(
      'Schedule appointment',
      name: 'booking_DatLichHen',
      desc: '',
      args: [],
    );
  }

  /// `Service`
  String get booking_DichVu {
    return Intl.message(
      'Service',
      name: 'booking_DichVu',
      desc: '',
      args: [],
    );
  }

  /// `Select service`
  String get booking_HintDichVu {
    return Intl.message(
      'Select service',
      name: 'booking_HintDichVu',
      desc: '',
      args: [],
    );
  }

  /// `Select barber`
  String get booking_ChonBarber {
    return Intl.message(
      'Select barber',
      name: 'booking_ChonBarber',
      desc: '',
      args: [],
    );
  }

  /// `Select date`
  String get booking_ChonNgay {
    return Intl.message(
      'Select date',
      name: 'booking_ChonNgay',
      desc: '',
      args: [],
    );
  }

  /// `Select a date to book`
  String get booking_HintChonNgay {
    return Intl.message(
      'Select a date to book',
      name: 'booking_HintChonNgay',
      desc: '',
      args: [],
    );
  }

  /// `Select time slot`
  String get booking_ChonTimeSlot {
    return Intl.message(
      'Select time slot',
      name: 'booking_ChonTimeSlot',
      desc: '',
      args: [],
    );
  }

  /// `Book appointment`
  String get booking_DatLichBtn {
    return Intl.message(
      'Book appointment',
      name: 'booking_DatLichBtn',
      desc: '',
      args: [],
    );
  }

  /// `You haven't selected a service!`
  String get booking_TBChonDichVu {
    return Intl.message(
      'You haven\'t selected a service!',
      name: 'booking_TBChonDichVu',
      desc: '',
      args: [],
    );
  }

  /// `You haven't selected a barber!`
  String get booking_TBChonBarber {
    return Intl.message(
      'You haven\'t selected a barber!',
      name: 'booking_TBChonBarber',
      desc: '',
      args: [],
    );
  }

  /// `You haven't selected an appointment date!`
  String get booking_TBChonNgay {
    return Intl.message(
      'You haven\'t selected an appointment date!',
      name: 'booking_TBChonNgay',
      desc: '',
      args: [],
    );
  }

  /// `You haven't selected a time slot!`
  String get booking_TBChonTimeSlot {
    return Intl.message(
      'You haven\'t selected a time slot!',
      name: 'booking_TBChonTimeSlot',
      desc: '',
      args: [],
    );
  }

  /// `No services available`
  String get booking_KhongCoDichVu {
    return Intl.message(
      'No services available',
      name: 'booking_KhongCoDichVu',
      desc: '',
      args: [],
    );
  }

  /// `Fee`
  String get booking_ChiPhi {
    return Intl.message(
      'Fee',
      name: 'booking_ChiPhi',
      desc: '',
      args: [],
    );
  }

  /// `No barbers available`
  String get booking_KhongCoBarber {
    return Intl.message(
      'No barbers available',
      name: 'booking_KhongCoBarber',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Booking`
  String get booking_XacNhan {
    return Intl.message(
      'Confirm Booking',
      name: 'booking_XacNhan',
      desc: '',
      args: [],
    );
  }

  /// `Chosen barber`
  String get booking_DialogBarber {
    return Intl.message(
      'Chosen barber',
      name: 'booking_DialogBarber',
      desc: '',
      args: [],
    );
  }

  /// `Time chosen`
  String get booking_DialogThoiGian {
    return Intl.message(
      'Time chosen',
      name: 'booking_DialogThoiGian',
      desc: '',
      args: [],
    );
  }

  /// `Service chosen`
  String get booking_DialogDichVu {
    return Intl.message(
      'Service chosen',
      name: 'booking_DialogDichVu',
      desc: '',
      args: [],
    );
  }

  /// `Update Appointment`
  String get booking_CapNhat {
    return Intl.message(
      'Update Appointment',
      name: 'booking_CapNhat',
      desc: '',
      args: [],
    );
  }

  /// `Confirm update`
  String get booking_XacNhanCapNhat {
    return Intl.message(
      'Confirm update',
      name: 'booking_XacNhanCapNhat',
      desc: '',
      args: [],
    );
  }

  /// `Booking History`
  String get history_LichSuCat {
    return Intl.message(
      'Booking History',
      name: 'history_LichSuCat',
      desc: '',
      args: [],
    );
  }

  /// `Log in first to see your history`
  String get history_DangNhapTruoc {
    return Intl.message(
      'Log in first to see your history',
      name: 'history_DangNhapTruoc',
      desc: '',
      args: [],
    );
  }

  /// `There's no appointment booked`
  String get history_LichSuTrong {
    return Intl.message(
      'There\'s no appointment booked',
      name: 'history_LichSuTrong',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get history_Huy {
    return Intl.message(
      'Cancel',
      name: 'history_Huy',
      desc: '',
      args: [],
    );
  }

  /// `Resume`
  String get history_TiepTuc {
    return Intl.message(
      'Resume',
      name: 'history_TiepTuc',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get history_DangCho {
    return Intl.message(
      'Pending',
      name: 'history_DangCho',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get history_DaHuy {
    return Intl.message(
      'Cancelled',
      name: 'history_DaHuy',
      desc: '',
      args: [],
    );
  }

  /// `Finished`
  String get history_HoanThanh {
    return Intl.message(
      'Finished',
      name: 'history_HoanThanh',
      desc: '',
      args: [],
    );
  }

  /// `Confirm cancel?`
  String get history_XacNhanHuy {
    return Intl.message(
      'Confirm cancel?',
      name: 'history_XacNhanHuy',
      desc: '',
      args: [],
    );
  }

  /// `Confirm resume booking?`
  String get history_XacNhanTiepTuc {
    return Intl.message(
      'Confirm resume booking?',
      name: 'history_XacNhanTiepTuc',
      desc: '',
      args: [],
    );
  }

  /// `Booked`
  String get history_DaDat {
    return Intl.message(
      'Booked',
      name: 'history_DaDat',
      desc: '',
      args: [],
    );
  }

  /// `Choose Barber`
  String get history_ChonBarber {
    return Intl.message(
      'Choose Barber',
      name: 'history_ChonBarber',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get history_TrangThai {
    return Intl.message(
      'Status',
      name: 'history_TrangThai',
      desc: '',
      args: [],
    );
  }

  /// `Edit Appointment`
  String get history_ChinhSua {
    return Intl.message(
      'Edit Appointment',
      name: 'history_ChinhSua',
      desc: '',
      args: [],
    );
  }

  /// `Guest`
  String get profile_Khach {
    return Intl.message(
      'Guest',
      name: 'profile_Khach',
      desc: '',
      args: [],
    );
  }

  /// `Account information`
  String get profile_ThongTinTaiKhoan {
    return Intl.message(
      'Account information',
      name: 'profile_ThongTinTaiKhoan',
      desc: '',
      args: [],
    );
  }

  /// `Staff history`
  String get profile_LichSuNhanVien {
    return Intl.message(
      'Staff history',
      name: 'profile_LichSuNhanVien',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get profile_DangNhap {
    return Intl.message(
      'Sign in',
      name: 'profile_DangNhap',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get profile_DangXuat {
    return Intl.message(
      'Log out',
      name: 'profile_DangXuat',
      desc: '',
      args: [],
    );
  }

  /// `Personal information`
  String get profile_ThongTinCaNhan {
    return Intl.message(
      'Personal information',
      name: 'profile_ThongTinCaNhan',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get profile_ChinhSua {
    return Intl.message(
      'Edit',
      name: 'profile_ChinhSua',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get profile_HoTen {
    return Intl.message(
      'Name',
      name: 'profile_HoTen',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get profile_Email {
    return Intl.message(
      'Email',
      name: 'profile_Email',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get profile_SDT {
    return Intl.message(
      'Phone number',
      name: 'profile_SDT',
      desc: '',
      args: [],
    );
  }

  /// `Role`
  String get profile_VaiTro {
    return Intl.message(
      'Role',
      name: 'profile_VaiTro',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get profile_NgaySinh {
    return Intl.message(
      'Date of birth',
      name: 'profile_NgaySinh',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number`
  String get profile_HintSDT {
    return Intl.message(
      'Enter phone number',
      name: 'profile_HintSDT',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get profile_HintHoTen {
    return Intl.message(
      'Enter your name',
      name: 'profile_HintHoTen',
      desc: '',
      args: [],
    );
  }

  /// `Choose date of birth`
  String get profile_HintNgaySinh {
    return Intl.message(
      'Choose date of birth',
      name: 'profile_HintNgaySinh',
      desc: '',
      args: [],
    );
  }

  /// `Update information`
  String get profile_CapNhatThongTin {
    return Intl.message(
      'Update information',
      name: 'profile_CapNhatThongTin',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get profile_NgonNgu {
    return Intl.message(
      'Language',
      name: 'profile_NgonNgu',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get profile_DoiMatKhau {
    return Intl.message(
      'Change Password',
      name: 'profile_DoiMatKhau',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get profile_MatKhauHienTai {
    return Intl.message(
      'Current Password',
      name: 'profile_MatKhauHienTai',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get profile_HintMatKhau {
    return Intl.message(
      'Enter Password',
      name: 'profile_HintMatKhau',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get profile_MatKhauMoi {
    return Intl.message(
      'New Password',
      name: 'profile_MatKhauMoi',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter Password`
  String get profile_NhapLaiMatKhau {
    return Intl.message(
      'Re-enter Password',
      name: 'profile_NhapLaiMatKhau',
      desc: '',
      args: [],
    );
  }

  /// `Password doesn't match current password`
  String get profile_KhongTrungMatKhauHienTai {
    return Intl.message(
      'Password doesn\'t match current password',
      name: 'profile_KhongTrungMatKhauHienTai',
      desc: '',
      args: [],
    );
  }

  /// `Password matches current password`
  String get profile_TrungMatKhauHienTai {
    return Intl.message(
      'Password matches current password',
      name: 'profile_TrungMatKhauHienTai',
      desc: '',
      args: [],
    );
  }

  /// `Password doesn't match`
  String get profile_MatKhauKhongKhop {
    return Intl.message(
      'Password doesn\'t match',
      name: 'profile_MatKhauKhongKhop',
      desc: '',
      args: [],
    );
  }

  /// `Revenue`
  String get profile_DoanhThu {
    return Intl.message(
      'Revenue',
      name: 'profile_DoanhThu',
      desc: '',
      args: [],
    );
  }

  /// `Finished appointments`
  String get staffInfo_HenHoanThanh {
    return Intl.message(
      'Finished appointments',
      name: 'staffInfo_HenHoanThanh',
      desc: '',
      args: [],
    );
  }

  /// `Incoming appointments`
  String get staffInfo_HenSapToi {
    return Intl.message(
      'Incoming appointments',
      name: 'staffInfo_HenSapToi',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled appointments`
  String get staffInfo_HenDaHuy {
    return Intl.message(
      'Cancelled appointments',
      name: 'staffInfo_HenDaHuy',
      desc: '',
      args: [],
    );
  }

  /// `Pending appointments`
  String get staffInfo_HenChoDuyet {
    return Intl.message(
      'Pending appointments',
      name: 'staffInfo_HenChoDuyet',
      desc: '',
      args: [],
    );
  }

  /// `Detailed History`
  String get staffInfo_ChiTietLichSu {
    return Intl.message(
      'Detailed History',
      name: 'staffInfo_ChiTietLichSu',
      desc: '',
      args: [],
    );
  }

  /// `List of appointments`
  String get staffInfo_DanhSachLichHen {
    return Intl.message(
      'List of appointments',
      name: 'staffInfo_DanhSachLichHen',
      desc: '',
      args: [],
    );
  }

  /// `Daily Revenue`
  String get revenue_DoanhThuNgay {
    return Intl.message(
      'Daily Revenue',
      name: 'revenue_DoanhThuNgay',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Revenue`
  String get revenue_DoanhThuThang {
    return Intl.message(
      'Monthly Revenue',
      name: 'revenue_DoanhThuThang',
      desc: '',
      args: [],
    );
  }

  /// `Select date`
  String get revenue_ChonNgay {
    return Intl.message(
      'Select date',
      name: 'revenue_ChonNgay',
      desc: '',
      args: [],
    );
  }

  /// `Select month`
  String get revenue_ChonThang {
    return Intl.message(
      'Select month',
      name: 'revenue_ChonThang',
      desc: '',
      args: [],
    );
  }

  /// `Date Revenue`
  String get revenue_DoanhThuTrongNgay {
    return Intl.message(
      'Date Revenue',
      name: 'revenue_DoanhThuTrongNgay',
      desc: '',
      args: [],
    );
  }

  /// `Number of Appointments`
  String get revenue_SoLichHen {
    return Intl.message(
      'Number of Appointments',
      name: 'revenue_SoLichHen',
      desc: '',
      args: [],
    );
  }

  /// `Shop services`
  String get service_DichVu {
    return Intl.message(
      'Shop services',
      name: 'service_DichVu',
      desc: '',
      args: [],
    );
  }

  /// `Our haircut service offers a professional experience with skilled barbers who always stay updated with the latest trends. Customers receive personalized consultations to choose the most suitable hairstyle. Our luxurious and comfortable space helps you relax and enjoy your new look.`
  String get service_MoTaCatToc {
    return Intl.message(
      'Our haircut service offers a professional experience with skilled barbers who always stay updated with the latest trends. Customers receive personalized consultations to choose the most suitable hairstyle. Our luxurious and comfortable space helps you relax and enjoy your new look.',
      name: 'service_MoTaCatToc',
      desc: '',
      args: [],
    );
  }

  /// `Our hair wash service provides relaxation and optimal hair care. Using high-quality products, we deeply cleanse and nourish your hair and scalp, leaving you feeling refreshed and rejuvenated.`
  String get service_MoTaGoiDau {
    return Intl.message(
      'Our hair wash service provides relaxation and optimal hair care. Using high-quality products, we deeply cleanse and nourish your hair and scalp, leaving you feeling refreshed and rejuvenated.',
      name: 'service_MoTaGoiDau',
      desc: '',
      args: [],
    );
  }

  /// `Our styling service ensures you have the perfect hairstyle for any occasion. Our professional stylists will consult with you and create styles ranging from simple to complex, tailored to your unique personality and style.`
  String get service_MoTaTaoKieu {
    return Intl.message(
      'Our styling service ensures you have the perfect hairstyle for any occasion. Our professional stylists will consult with you and create styles ranging from simple to complex, tailored to your unique personality and style.',
      name: 'service_MoTaTaoKieu',
      desc: '',
      args: [],
    );
  }

  /// `Our ear cleaning service offers comfort and cleanliness. With gentle and hygienic techniques, we safely and effectively clean your ears, providing a pleasant and soothing experience.`
  String get service_MoTaNgoayTai {
    return Intl.message(
      'Our ear cleaning service offers comfort and cleanliness. With gentle and hygienic techniques, we safely and effectively clean your ears, providing a pleasant and soothing experience.',
      name: 'service_MoTaNgoayTai',
      desc: '',
      args: [],
    );
  }

  /// `Our shaving service delivers neatness and elegance. Professional barbers use sharp tools and safe techniques to give you a clean and confident look.`
  String get service_MoTaCaoRau {
    return Intl.message(
      'Our shaving service delivers neatness and elegance. Professional barbers use sharp tools and safe techniques to give you a clean and confident look.',
      name: 'service_MoTaCaoRau',
      desc: '',
      args: [],
    );
  }

  /// `Our hair coloring service uses high-quality dyes to ensure long-lasting and vibrant colors while keeping your hair safe. We offer a variety of colors and techniques to meet all your needs and styles.`
  String get service_MoTaNhuomToc {
    return Intl.message(
      'Our hair coloring service uses high-quality dyes to ensure long-lasting and vibrant colors while keeping your hair safe. We offer a variety of colors and techniques to meet all your needs and styles.',
      name: 'service_MoTaNhuomToc',
      desc: '',
      args: [],
    );
  }

  /// `Our head massage service helps you relax and reduce stress. With professional massage techniques, we stimulate blood circulation, relieve headaches, and provide an overall sense of relaxation.`
  String get service_MoTaMassageDau {
    return Intl.message(
      'Our head massage service helps you relax and reduce stress. With professional massage techniques, we stimulate blood circulation, relieve headaches, and provide an overall sense of relaxation.',
      name: 'service_MoTaMassageDau',
      desc: '',
      args: [],
    );
  }

  /// `Price from: `
  String get service_GiaTu {
    return Intl.message(
      'Price from: ',
      name: 'service_GiaTu',
      desc: '',
      args: [],
    );
  }

  /// `Approximate time: `
  String get service_ThoiGian {
    return Intl.message(
      'Approximate time: ',
      name: 'service_ThoiGian',
      desc: '',
      args: [],
    );
  }

  /// ` minutes`
  String get service_Phut {
    return Intl.message(
      ' minutes',
      name: 'service_Phut',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
