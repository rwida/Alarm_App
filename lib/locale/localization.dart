import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:superk_new/favorite_tow.dart';
import 'package:superk_new/locale/messages_all.dart';



class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }


  String get home {
    return Intl.message('home', name: 'home');
  }
  String get favorite {
    return Intl.message('favorite', name: 'favorite');
  }
  String get deals {
    return Intl.message('deals', name: 'deals');
  }
  String get cart {
    return Intl.message('cart', name: 'cart');
  }
  String get settings {
    return Intl.message('settings', name: 'settings');
  }
  String get language {
    return Intl.message('language', name: 'language');
  }
  String get lang {
    return Intl.message('lang', name: 'lang');
  }
  String get LE {
    return Intl.message('LE', name: 'LE');
  }
  String get Account {
    return Intl.message('Account', name: 'Account');
  }
  String get Profile {
    return Intl.message('Profile', name: 'Profile');
  }
  String get order_info {
    return Intl.message('order_info', name: 'order_info');
  }
  String get order_history {
    return Intl.message('order_history', name: 'order_history');
  }
  String get app_settings {
    return Intl.message('app_settings', name: 'app_settings');
  }
  String get about_us {
    return Intl.message('about_us', name: 'about_us');
  }
  String get privacy {
    return Intl.message('privacy', name: 'privacy');
  }
  String get share_app {
    return Intl.message('share_app', name: 'share_app');
  }
  String get send_mail {
    return Intl.message('send_mail', name: 'send_mail');
  }
  String get call_us {
    return Intl.message('call_us', name: 'call_us');
  }
  String get Communicate {
    return Intl.message('Communicate', name: 'Communicate');
  }
  String get login {
    return Intl.message('login', name: 'login');
  }
  String get logout {
    return Intl.message('logout', name: 'logout');
  }
  String get shopping_cart {
    return Intl.message('shopping_cart', name: 'shopping_cart');
  }
  String get total_price {
    return Intl.message('total_price', name: 'total_price');
  }
  String get Savings {
    return Intl.message('Savings', name: 'Savings');
  }
  String get confirm_payment {
    return Intl.message('confirm_payment', name: 'confirm_payment');
  }
  String get off {
    return Intl.message('off', name: 'off');
  }
  String get express {
    return Intl.message('express', name: 'express');
  }
  String get Products {
    return Intl.message('Products', name: 'Products');
  }
  String get search_any {
    return Intl.message('search_any', name: 'search_any');
  }
  String get all_category {
    return Intl.message('all_category', name: 'all_category');
  }
  String get near_stores {
    return Intl.message('near_stores', name: 'near_stores');
  }
  String get Product {
    return Intl.message('Product', name: 'Product');
  }
  String get all_orders {
    return Intl.message('all_orders', name: 'all_orders');
  }
  String get personal_data {
    return Intl.message('personal_data', name: 'personal_data');
  }
  String get invoice {
    return Intl.message('invoice', name: 'invoice');
  }
  String get Sold_by {
    return Intl.message('Sold_by', name: 'Sold_by');
  }
  String get add_to_cart {
    return Intl.message('add_to_cart', name: 'add_to_cart');
  }
  String get ProductDesc {
    return Intl.message('ProductDesc', name: 'ProductDesc');
  }
  String get Specification {
    return Intl.message('Specification', name: 'Specification');
  }
  String get UserReview {
    return Intl.message('UserReview', name: 'UserReview');
  }
  String get Email {
    return Intl.message('Email', name: 'Email');
  }
  String get Password {
    return Intl.message('Password', name: 'Password');
  }
  String get Username {
    return Intl.message('Username', name: 'Username');
  }
  String get dont_have {
    return Intl.message('dont_have', name: 'dont_have');
  }
  String get Register {
    return Intl.message('Register', name: 'Register');
  }
  String get Forgot_Password {
    return Intl.message('Forgot_Password', name: 'Forgot_Password');
  }
  String get back {
    return Intl.message('back', name: 'back');
  }
  String get login_facebook {
    return Intl.message('login_facebook', name: 'login_facebook');
  }
  String get login_google {
    return Intl.message('login_google', name: 'login_google');
  }
  String get Already_have {
    return Intl.message('Already_have', name: 'Already_have');
  }
  String get order_in {
    return Intl.message('order_in', name: 'order_in');
  }
  String get login_error_message {
    return Intl.message('login_error_message', name: 'login_error_message');
  }
  String get hot_deals {
    return Intl.message('hot_deals', name: 'hot_deals');
  }
  String get shop_now {
    return Intl.message('shop_now', name: 'shop_now');
  }
  String get phone {
    return Intl.message('phone', name: 'phone');
  }
  String get Free_delivery {
    return Intl.message('Free_delivery', name: 'Free_delivery');
  }
  String get supermarket_offers {
    return Intl.message('supermarket_offers', name: 'supermarket_offers');
  }
  String get pharmacy_offers {
    return Intl.message('pharmacy_offers', name: 'pharmacy_offers');
  }
  String get profile {
    return Intl.message('profile', name: 'profile');
  }
  String get Location {
    return Intl.message('Location', name: 'Location');
  }
  String get Select_Location {
    return Intl.message('Select_Location', name: 'Select_Location');
  }
  String get reviewPro {
    return Intl.message('reviewPro', name: 'reviewPro');
  }
  String get proImp {
    return Intl.message('proImp', name: 'proImp');
  }
  String get save {
    return Intl.message('save', name: 'save');
  }
}

class SpecificLocalizationDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<AppLocalizations> load(Locale locale) =>
      AppLocalizations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => true;
}
