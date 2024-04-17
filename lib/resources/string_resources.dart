import 'package:intl/intl.dart';
class StringResources{
  static const String splashMiddleText = "Food Rider App";
  static const String companyName = "ATRULE Technologies";
  static const String skip = "SKIP";
  static const String next = "NEXT";
  static const String getStarted = "GET STARTED NOW";
  static const String location = "App will use your current location to search restaurants near you";
  static const String okLocation = "OK";
  static const String otherLocation = "Choose another location";
  static const String search = "Search";
  static const String feature = "Featured";
  static const String allRes = "All restaurants";
  static const String about = "About";
  static const String reviews = "Reviews";
  static bool visible = false;
  static final kEmailValidatorRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  static final RegExp kPhoneValidatorRegExp =
  RegExp(r"^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$");
  static String phoneExp =
      r"^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$";

  static final RegExp kcnicValidatorRegExp =
  RegExp(r"^[0-9]{5}-[0-9]{7}-[0-9]{1}$");
  static final RegExp klicenseValidatorRegExp =
  RegExp(r"^[a-zA-Z]{2}[0-9]{2}[a-zA-Z]{2}[0-9]{4}$");
  static final RegExp kvehicleValidatorRegExp =
  RegExp(r"^[a-zA-Z]{3}[0-9]{4}$");

  static const kLabelCardNumber = 'Number';
  static const kHintCardNumber = 'XXXX XXXX XXXX XXXX';
  static const kLabelCardExpiryDate = 'Expired Date';
  static const kHintCardExpiryDate = 'XX/XX';
  static const kLabelCardCVV = 'CVV';
  static const kHintCardCVV = 'XXX';
  static const kLabelCardHolder = 'Card Holder';
  static const kHintCardHolder = 'Card Holder';

  static String name = '';
  static String email = '';
  static String phoneNumber = '';
  static String cnicNumber = '';
  static String licenseNumber = '';
  static String vehicleNumber = '';
  static String password = '';
  static String confirmPassword = '';

  static String comment = '';

  static const bool isOnline = false;

  static const String kTextMyAccount = "My Account";

  static const String kTextNotifications = "Notifications";
  static const String kTextSettings = "Settings";
  static const String kTextHelp = "Help Center";
  static const String kTextLogout= "Logout";

  static const String tab1= "Status";
  static const String tab2= "Delivery";
  static const String tab3= "Map";
  static const String tab4= "History";
  static const String tab5= "Wallet";

  static const String userName = "Name";
  static const String userEmail = "Email";
  static const String userPhoneNumber = "Phone Number";
  static const String userCNICNumber = "CNIC Number";
  static const String userVehicleNumber = "Vehicle Number";
  static const String userLicenseNumber = "License Number";
  static const String userPassword = "Password";
  static const String userConfirmPassword= "Confirm Password";
  static String selectedDate = DateFormat.yMMMMd().format(DateTime.now());

  static String vehicleType = '';
  static String boxType = '';
  static String restaurantCode = '';
  static String confirmAmount = '';
  static String failureReason = '';

  static const String walletTransaction = "Transaction List";
  static const String walletCash = "Cash Collected";
  static const String orderList = "Orders List";
  static const String mapText = "Permission is disabled.";
  static const String confirmItemText = "Confirm items before pick up.";
  static const String restaurantNameText = "Restaurant Name";
  static const String acceptOrderText = "ACCEPT ORDER";
  static const String goToRestaurant = "Go To The Restaurant";
}