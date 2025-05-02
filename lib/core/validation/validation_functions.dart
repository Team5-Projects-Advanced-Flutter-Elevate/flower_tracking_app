class ValidateFunctions {
  static ValidateFunctions? _instance;

  ValidateFunctions._init();

  static ValidateFunctions getInstance() {
    if (_instance == null) {
      _instance = ValidateFunctions._init();
    } else {
      _instance!;
    }
    return _instance!;
  }

  // String? validationOfFullName(String? inputText) {
  //   if (inputText?.trim().isEmpty == true || inputText == null) {
  //     return LocaleKeys.pleaseEnterName.tr();
  //   }
  //   return null;
  // }
  //
  // String? validationOfUserName(String? inputText) {
  //   if (inputText?.trim().isEmpty == true || inputText == null) {
  //     return LocaleKeys.pleaseEnterUserName.tr();
  //   }
  //   if (inputText.length < 3 || inputText.length > 16) {
  //     return LocaleKeys.userNameLength.tr();
  //   }
  //
  //   if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(inputText)) {
  //     return LocaleKeys.userNameRules.tr();
  //   }
  //   return null;
  // }
  //
  // String? validationOfFirstOrLastName(String? inputText,
  //     {bool isFirstName = true}) {
  //   RegExp nameRegExp = RegExp(r'^[A-Za-z]+$');
  //
  //   if (inputText?.trim().isEmpty == true || inputText == null) {
  //     return isFirstName
  //         ? LocaleKeys.pleaseEnterFirstName.tr()
  //         : LocaleKeys.pleaseEnterLastName.tr();
  //   }
  //   if (inputText.trim().length < 3) {
  //     return LocaleKeys.namesLengthRule.tr();
  //   }
  //   if (!nameRegExp.hasMatch(inputText)) {
  //     return LocaleKeys.namesRules.tr();
  //   }
  //   return null;
  // }
  //
  // String? validationOfAddress(String? inputText) {
  //   final RegExp addressRegex = RegExp(r"^[\p{L}\d\s,.\-\/#]+$", unicode: true);
  //
  //   if (inputText == null || inputText.trim().isEmpty) {
  //     return LocaleKeys.pleaseEnterAddress.tr();
  //   }
  //
  //   if (!addressRegex.hasMatch(inputText.trim())) {
  //     return LocaleKeys.pleaseEnterValidAddress.tr();
  //   }
  //
  //   return null;
  // }
  // String? validationOfRecipient(String? inputText) {
  //   final RegExp addressRegex = RegExp(r"^[\p{L}\d\s,.\-\/#]+$", unicode: true);
  //
  //   if (inputText == null || inputText.trim().isEmpty) {
  //     return LocaleKeys.pleaseEnterValidRecipient.tr();
  //   }
  //
  //   if (!addressRegex.hasMatch(inputText.trim())) {
  //     return LocaleKeys.pleaseEnterValidRecipient.tr();
  //   }
  //
  //   return null;
  // }
  //
  //
  //
  //
  // String? validationOfEmail(String? inputText) {
  //   RegExp gmailRegExp =
  //       RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  //   if (inputText?.trim().isEmpty == true || inputText == null) {
  //     return LocaleKeys.pleaseEnterEmail.tr();
  //   }
  //   if (!gmailRegExp.hasMatch(inputText)) {
  //     return LocaleKeys.pleaseEnterValidEmail.tr();
  //   }
  //   return null;
  // }
  //
  // String? validationOfPhoneNumber(String? inputText) {
  //   RegExp phoneNumber = RegExp(r'^(\+2)?(010|011|012|015)[0-9]{8}$');
  //   if (inputText?.trim().isEmpty == true || inputText == null) {
  //     return LocaleKeys.pleaseEnterPhoneNumber.tr();
  //   } else if (!phoneNumber.hasMatch(inputText)) {
  //     return LocaleKeys.phoneNumberRules.tr();
  //   }
  //   return null;
  // }
  //
  // String? validationOfPassword(String? inputText) {
  //   // RegExp passValid = RegExp(
  //   //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\$%^&*-]).{8,}\$');
  //   if (inputText?.trim().isEmpty == true || inputText == null) {
  //     return LocaleKeys.pleaseEnterPassword.tr();
  //   } else if (inputText.length < 8) {
  //     return LocaleKeys.passwordLength.tr();
  //   } else if (!RegExp(r'(?=.*?[A-Z])').hasMatch(inputText)) {
  //     return LocaleKeys.uppercaseRulePassword.tr();
  //   } else if (!RegExp(r'(?=.*?[a-z])').hasMatch(inputText)) {
  //     return LocaleKeys.lowercaseRulePassword.tr();
  //   } else if (!RegExp(r'(?=.*?[0-9])').hasMatch(inputText)) {
  //     return LocaleKeys.digitRulePassword.tr();
  //   } else if (!RegExp(r'(?=.*?[#?!@$%^&*-])').hasMatch(inputText)) {
  //     return LocaleKeys.specialCharactersRulePassword.tr();
  //   }
  //   return null;
  // }
  //
  // String? validationOfConfirmPassword(
  //     String? inputText, String passwordToMatchWith) {
  //   if (inputText?.trim().isEmpty == true || inputText == null) {
  //     return LocaleKeys.pleaseConfirmPassword.tr();
  //   } else if (inputText != passwordToMatchWith) {
  //     return LocaleKeys.noMatch.tr();
  //   }
  //   return null;
  // }
}
