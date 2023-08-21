import 'global_variables.dart';

class CustomValidator {
  static String? email(String? value) {
    if (variable == false) {
      return null;
    } else if (value!.isEmpty || value == null)
      return ' Please enter your email address';
    else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return ' Please enter valid email';
    }
    return null;
  }

  static String? password(String? value) {
    if (variable == false) {
      return null;
    } else if (value!.length == 0) {
      return ' Please enter your password';
    } else if (value.length < 6) {
      return ' Password should be greater then 6 digits';
    }
    return null;
  }

  static String? loginPassword(String? value) {
    print("Varialble");
    print(variable);
    if (variable == false) {
      return null;
    } else if (value!.isEmpty) {
      return ' Please enter your password';
    }

    return null;
  }

  static String? confirmPassword(String? value, String oldPassword) {
    if (variable == false) {
      return null;
    } else if (value!.length == 0) {
      return ' Please confirm your password';
    } else if (value.length < 6) {
      return ' Password should be greater then 6 digits';
    } else if (value != oldPassword) {
      return ' Password does not match';
    }
    return null;
  }

  static String? isEmpty(String? value) {
    if (variable == false) {
      return null;
    } else if (value!.isEmpty) {
      return ' Field cannot not be empty';
    }
    return null;
  }

  static String? isEmptyTitle(String? value) {
    if (variable == false) {
      return null;
    } else if (value!.isEmpty) {
      return 'Title is required';
    }
    return null;
  }

  static String? isEmptyDescription(String? value) {
    if (variable == false) {
      return null;
    } else if (value!.isEmpty) {
      return 'Description is required';
    }
    return null;
  }

  static String? isEmptyPrice(String? value) {
    if (variable == false) {
      return null;
    } else if (value!.isEmpty) {
      return 'Price is required';
    }
    return null;
  }

  static String? isEmptyUserName(String? value) {
    if (variable == false) {
      return null;
    } else if (value!.isEmpty) {
      return ' Please enter your username';
    }
    return null;
  }

  static String? number(String? value) {
    if (variable == false) {
      return null;
    } else if (value!.length == 0) {
      return ' Phone Number is required';
    } else if (value.length < 6) {
      return 'Phone number should be at least 6 digits';
    }
    return null;
  }

  static String? isEmptyName(String? value) {
    if (variable == false) {
      return null;
    } else if (value!.isEmpty) {
      return ' Name is required';
    }
    return null;
  }

  static String? lessThen2(String? value) {
    return (value!.length < 2) ? ' Enter more then 1 characters' : null;
  }

  static String? lessThen3(String? value) {
    return (value!.length < 3) ? ' Enter more then 2 characters' : null;
  }

  static String? lessThen4(String? value) {
    return (value!.length < 4) ? ' Enter more then 3 characters' : null;
  }

  static String? lessThen5(String? value) {
    return (value!.length < 5) ? ' Enter more then 4 characters' : null;
  }

  static String? greaterThen(String? input, double compairWith) {
    return (double.parse(input ?? '0') < compairWith)
        ? ' New input must be greater'
        : null;
  }

  static String? returnNull(String? value) => null;
}
