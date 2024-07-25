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

  /// ``
  String get _______________date__________________________ {
    return Intl.message(
      '',
      name: '_______________date__________________________',
      desc: '',
      args: [],
    );
  }

  /// `day`
  String get day {
    return Intl.message(
      'day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `ago`
  String get ago {
    return Intl.message(
      'ago',
      name: 'ago',
      desc: '',
      args: [],
    );
  }

  /// `minute`
  String get minute {
    return Intl.message(
      'minute',
      name: 'minute',
      desc: '',
      args: [],
    );
  }

  /// `hour`
  String get hour {
    return Intl.message(
      'hour',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `second`
  String get second {
    return Intl.message(
      'second',
      name: 'second',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message(
      'Yesterday',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get _________________authentication________________ {
    return Intl.message(
      '',
      name: '_________________authentication________________',
      desc: '',
      args: [],
    );
  }

  /// `Skip for now`
  String get skip_for_now {
    return Intl.message(
      'Skip for now',
      name: 'skip_for_now',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get Welcome {
    return Intl.message(
      'Welcome',
      name: 'Welcome',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get create_an_account {
    return Intl.message(
      'Create an account',
      name: 'create_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get log_in {
    return Intl.message(
      'Log In',
      name: 'log_in',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `GO`
  String get go {
    return Intl.message(
      'GO',
      name: 'go',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Sign up `
  String get sign_up {
    return Intl.message(
      'Sign up ',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get first_name {
    return Intl.message(
      'First name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get last_name {
    return Intl.message(
      'Last name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Your mobile number`
  String get your_mobile_number {
    return Intl.message(
      'Your mobile number',
      name: 'your_mobile_number',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get already_have_an_account {
    return Intl.message(
      'Already have an account? ',
      name: 'already_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get sign_in {
    return Intl.message(
      'Sign in',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Phone verification`
  String get phone_verification {
    return Intl.message(
      'Phone verification',
      name: 'phone_verification',
      desc: '',
      args: [],
    );
  }

  /// `Enter your `
  String get enter_code {
    return Intl.message(
      'Enter your ',
      name: 'enter_code',
      desc: '',
      args: [],
    );
  }

  /// `OTP`
  String get otp {
    return Intl.message(
      'OTP',
      name: 'otp',
      desc: '',
      args: [],
    );
  }

  /// ` code`
  String get your_code {
    return Intl.message(
      ' code',
      name: 'your_code',
      desc: '',
      args: [],
    );
  }

  /// `Didn’t receive code? `
  String get did_not_receive_code {
    return Intl.message(
      'Didn’t receive code? ',
      name: 'did_not_receive_code',
      desc: '',
      args: [],
    );
  }

  /// `Resend again`
  String get resend_again {
    return Intl.message(
      'Resend again',
      name: 'resend_again',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Set password`
  String get set_password {
    return Intl.message(
      'Set password',
      name: 'set_password',
      desc: '',
      args: [],
    );
  }

  /// `Set your password`
  String get set_your_password {
    return Intl.message(
      'Set your password',
      name: 'set_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Password`
  String get enter_Your_Password {
    return Intl.message(
      'Enter Your Password',
      name: 'enter_Your_Password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_Password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_Password',
      desc: '',
      args: [],
    );
  }

  /// `At least 1 number or a special character`
  String get at_least_number_or_a_special_character {
    return Intl.message(
      'At least 1 number or a special character',
      name: 'at_least_number_or_a_special_character',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get full_Name {
    return Intl.message(
      'Full Name',
      name: 'full_Name',
      desc: '',
      args: [],
    );
  }

  /// `Forget password?`
  String get forget_password {
    return Intl.message(
      'Forget password?',
      name: 'forget_password',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account? `
  String get do_not_have_an_account {
    return Intl.message(
      'Don’t have an account? ',
      name: 'do_not_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get __________________________home______________________________ {
    return Intl.message(
      '',
      name: '__________________________home______________________________',
      desc: '',
      args: [],
    );
  }

  /// `home`
  String get home {
    return Intl.message(
      'home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Add car`
  String get add_car {
    return Intl.message(
      'Add car',
      name: 'add_car',
      desc: '',
      args: [],
    );
  }

  /// `Brand`
  String get brand {
    return Intl.message(
      'Brand',
      name: 'brand',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Model`
  String get model {
    return Intl.message(
      'Model',
      name: 'model',
      desc: '',
      args: [],
    );
  }

  /// `Photo`
  String get photo {
    return Intl.message(
      'Photo',
      name: 'photo',
      desc: '',
      args: [],
    );
  }

  /// `Additional specifications of the car`
  String get additional_specifications_of_the_car {
    return Intl.message(
      'Additional specifications of the car',
      name: 'additional_specifications_of_the_car',
      desc: '',
      args: [],
    );
  }

  /// `Pick a color`
  String get pick_a_color {
    return Intl.message(
      'Pick a color',
      name: 'pick_a_color',
      desc: '',
      args: [],
    );
  }

  /// `Weight: `
  String get weight {
    return Intl.message(
      'Weight: ',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `Cost: `
  String get cost {
    return Intl.message(
      'Cost: ',
      name: 'cost',
      desc: '',
      args: [],
    );
  }

  /// `Porters: `
  String get porters {
    return Intl.message(
      'Porters: ',
      name: 'porters',
      desc: '',
      args: [],
    );
  }

  /// `Start point`
  String get start_point {
    return Intl.message(
      'Start point',
      name: 'start_point',
      desc: '',
      args: [],
    );
  }

  /// `End point`
  String get end_point {
    return Intl.message(
      'End point',
      name: 'end_point',
      desc: '',
      args: [],
    );
  }

  /// `More details`
  String get more_details {
    return Intl.message(
      'More details',
      name: 'more_details',
      desc: '',
      args: [],
    );
  }

  /// `Order details`
  String get order_details {
    return Intl.message(
      'Order details',
      name: 'order_details',
      desc: '',
      args: [],
    );
  }

  /// `Accept order`
  String get accept_order {
    return Intl.message(
      'Accept order',
      name: 'accept_order',
      desc: '',
      args: [],
    );
  }

  /// `Photos`
  String get photos {
    return Intl.message(
      'Photos',
      name: 'photos',
      desc: '',
      args: [],
    );
  }

  /// `Pick a car`
  String get pick_a_car {
    return Intl.message(
      'Pick a car',
      name: 'pick_a_car',
      desc: '',
      args: [],
    );
  }

  /// `Advantages`
  String get advantages {
    return Intl.message(
      'Advantages',
      name: 'advantages',
      desc: '',
      args: [],
    );
  }

  /// `There is nothing to show`
  String get there_is_nothing_to_show {
    return Intl.message(
      'There is nothing to show',
      name: 'there_is_nothing_to_show',
      desc: '',
      args: [],
    );
  }

  /// `SYP`
  String get syp {
    return Intl.message(
      'SYP',
      name: 'syp',
      desc: '',
      args: [],
    );
  }

  /// `There are no advantages`
  String get there_are_no_advantages {
    return Intl.message(
      'There are no advantages',
      name: 'there_are_no_advantages',
      desc: '',
      args: [],
    );
  }

  /// `Required advantages`
  String get required_advantages {
    return Intl.message(
      'Required advantages',
      name: 'required_advantages',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get __________________________wallet______________________________ {
    return Intl.message(
      '',
      name: '__________________________wallet______________________________',
      desc: '',
      args: [],
    );
  }

  /// `wallet`
  String get wallet {
    return Intl.message(
      'wallet',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }

  /// `Total money: `
  String get total_money {
    return Intl.message(
      'Total money: ',
      name: 'total_money',
      desc: '',
      args: [],
    );
  }

  /// `Pending money: `
  String get pending_money {
    return Intl.message(
      'Pending money: ',
      name: 'pending_money',
      desc: '',
      args: [],
    );
  }

  /// `Available money`
  String get available_money {
    return Intl.message(
      'Available money',
      name: 'available_money',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get __________________________chat________________________________ {
    return Intl.message(
      '',
      name: '__________________________chat________________________________',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message(
      'Chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `Write a message`
  String get write_message {
    return Intl.message(
      'Write a message',
      name: 'write_message',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get __________________________order_______________________________ {
    return Intl.message(
      '',
      name: '__________________________order_______________________________',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Active orders`
  String get active_orders {
    return Intl.message(
      'Active orders',
      name: 'active_orders',
      desc: '',
      args: [],
    );
  }

  /// `Orders done`
  String get done_orders {
    return Intl.message(
      'Orders done',
      name: 'done_orders',
      desc: '',
      args: [],
    );
  }

  /// `Sub orders`
  String get sub_orders {
    return Intl.message(
      'Sub orders',
      name: 'sub_orders',
      desc: '',
      args: [],
    );
  }

  /// `Order accepted date`
  String get order_accepted_date {
    return Intl.message(
      'Order accepted date',
      name: 'order_accepted_date',
      desc: '',
      args: [],
    );
  }

  /// `Order arrived date`
  String get order_arrived_date {
    return Intl.message(
      'Order arrived date',
      name: 'order_arrived_date',
      desc: '',
      args: [],
    );
  }

  /// `Order delivered date`
  String get order_delivered_date {
    return Intl.message(
      'Order delivered date',
      name: 'order_delivered_date',
      desc: '',
      args: [],
    );
  }

  /// `Order pickedUp date`
  String get order_pickedUp_date {
    return Intl.message(
      'Order pickedUp date',
      name: 'order_pickedUp_date',
      desc: '',
      args: [],
    );
  }

  /// `Order driver Assigned date`
  String get order_driverAssigned_date {
    return Intl.message(
      'Order driver Assigned date',
      name: 'order_driverAssigned_date',
      desc: '',
      args: [],
    );
  }

  /// `Order arrives`
  String get driver_arrived {
    return Intl.message(
      'Order arrives',
      name: 'driver_arrived',
      desc: '',
      args: [],
    );
  }

  /// `Set order pickedUp`
  String get set_order_picked_up {
    return Intl.message(
      'Set order pickedUp',
      name: 'set_order_picked_up',
      desc: '',
      args: [],
    );
  }

  /// `Set order delivered`
  String get set_order_delivered {
    return Intl.message(
      'Set order delivered',
      name: 'set_order_delivered',
      desc: '',
      args: [],
    );
  }

  /// `Order status`
  String get order_status {
    return Intl.message(
      'Order status',
      name: 'order_status',
      desc: '',
      args: [],
    );
  }

  /// `Order date`
  String get order_date {
    return Intl.message(
      'Order date',
      name: 'order_date',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for customer confirmation`
  String get waiting_for_customer_confirmation {
    return Intl.message(
      'Waiting for customer confirmation',
      name: 'waiting_for_customer_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `The customer has confirmed the order`
  String get the_customer_has_confirmed_the_order {
    return Intl.message(
      'The customer has confirmed the order',
      name: 'the_customer_has_confirmed_the_order',
      desc: '',
      args: [],
    );
  }

  /// `Order on the way`
  String get order_on_the_way {
    return Intl.message(
      'Order on the way',
      name: 'order_on_the_way',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get delivered {
    return Intl.message(
      'Delivered',
      name: 'delivered',
      desc: '',
      args: [],
    );
  }

  /// `the number of floors`
  String get the_number_of_floors {
    return Intl.message(
      'the number of floors',
      name: 'the_number_of_floors',
      desc: '',
      args: [],
    );
  }

  /// `The driver agreed to the order`
  String get the_driver_agreed_to_the_request {
    return Intl.message(
      'The driver agreed to the order',
      name: 'the_driver_agreed_to_the_request',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle advantages`
  String get vehicle_advantages {
    return Intl.message(
      'Vehicle advantages',
      name: 'vehicle_advantages',
      desc: '',
      args: [],
    );
  }

  /// `driver name`
  String get driver_name {
    return Intl.message(
      'driver name',
      name: 'driver_name',
      desc: '',
      args: [],
    );
  }

  /// `car model`
  String get car_model {
    return Intl.message(
      'car model',
      name: 'car_model',
      desc: '',
      args: [],
    );
  }

  /// `car color`
  String get car_color {
    return Intl.message(
      'car color',
      name: 'car_color',
      desc: '',
      args: [],
    );
  }

  /// `car brand`
  String get car_brand {
    return Intl.message(
      'car brand',
      name: 'car_brand',
      desc: '',
      args: [],
    );
  }

  /// `Your order is under scrutiny by the admin, please wait`
  String get your_order_is_under_scrutiny_by_the_admin_please_wait {
    return Intl.message(
      'Your order is under scrutiny by the admin, please wait',
      name: 'your_order_is_under_scrutiny_by_the_admin_please_wait',
      desc: '',
      args: [],
    );
  }

  /// `Your order was rejected by the admin`
  String get your_order_was_rejected_by_the_admin {
    return Intl.message(
      'Your order was rejected by the admin',
      name: 'your_order_was_rejected_by_the_admin',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for the driver to arrive and pickUp the order`
  String get waiting_for_the_driver_to_arrive_and_pickUp_the_order {
    return Intl.message(
      'Waiting for the driver to arrive and pickUp the order',
      name: 'waiting_for_the_driver_to_arrive_and_pickUp_the_order',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get canceled {
    return Intl.message(
      'Canceled',
      name: 'canceled',
      desc: '',
      args: [],
    );
  }

  /// `Confirm the order`
  String get confirm_the_order {
    return Intl.message(
      'Confirm the order',
      name: 'confirm_the_order',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for drivers to be hired`
  String get waiting_for_drivers_to_be_hired {
    return Intl.message(
      'Waiting for drivers to be hired',
      name: 'waiting_for_drivers_to_be_hired',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get __________________________profile______________________________ {
    return Intl.message(
      '',
      name: '__________________________profile______________________________',
      desc: '',
      args: [],
    );
  }

  /// `profile`
  String get profile {
    return Intl.message(
      'profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get Save {
    return Intl.message(
      'Save',
      name: 'Save',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Edit Phone Number`
  String get edit_phone {
    return Intl.message(
      'Edit Phone Number',
      name: 'edit_phone',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get about_us {
    return Intl.message(
      'About Us',
      name: 'about_us',
      desc: '',
      args: [],
    );
  }

  /// `Help and Support`
  String get help_and_support {
    return Intl.message(
      'Help and Support',
      name: 'help_and_support',
      desc: '',
      args: [],
    );
  }

  /// `LogOut`
  String get logOut {
    return Intl.message(
      'LogOut',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Cars`
  String get cars {
    return Intl.message(
      'Cars',
      name: 'cars',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get are_you_sure_you_want_to_log_out {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'are_you_sure_you_want_to_log_out',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get delete_account {
    return Intl.message(
      'Delete Account',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account? Please read how account deletion will affect.\nDeleting your account removes personal information our database.`
  String get are_you_sure_you_want_to_delete_account {
    return Intl.message(
      'Are you sure you want to delete your account? Please read how account deletion will affect.\nDeleting your account removes personal information our database.',
      name: 'are_you_sure_you_want_to_delete_account',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Delete car`
  String get delete_car {
    return Intl.message(
      'Delete car',
      name: 'delete_car',
      desc: '',
      args: [],
    );
  }

  /// `Are ypu sure delete this car?`
  String get are_you_sure_delete_this_car {
    return Intl.message(
      'Are ypu sure delete this car?',
      name: 'are_you_sure_delete_this_car',
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
      Locale.fromSubtags(languageCode: 'ar'),
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
