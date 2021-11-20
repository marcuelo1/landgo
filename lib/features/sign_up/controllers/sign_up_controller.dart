import 'package:flutter/material.dart';
import 'package:ryve_mobile/core/widgets/pop_up.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/shared/shared_function.dart';

class SignUpController {
  String signUpUrl = "${SharedUrl.root}/${SharedUrl.version}/buyers/";
  String _email = "";
  String _password = "";
  String _firstName = "";
  String _lastName = "";
  String _confirmPassword = "";
  var _mobileNumber;

  String? validateFirstname(value) {
    if (value!.isEmpty) {
      return "First Name is required";
    }
  }

  String? validateLastName(value) {
    if (value!.isEmpty) {
      return "Last Name is required";
    }
  }

  String? validateMobileNumber(value) {
    int? check = int.tryParse(value!);
    // check if empty or not numeric
    if (check == null) {
      return "Please put valid mobile number";
    }

    // check if it has 10 numbers
    if (value.length < 10) {
      return "Please put 10 digit mobile number";
    }
  }

  String? validateEmail(value) {
    if (value!.isEmpty) {
      return "Email is required";
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Please enter a valid email";
    }
  }

  String? validatePassword(value) {
    if (value!.isEmpty) {
      return "Password is required";
    }
  }

  String? validateConfirmPassword(value) {
    if (value!.isEmpty) {
      return "Confirm Password is required";
    }
    // check if password and confirm password is the same
    if (value != _password) {
      return "Confirm Password is not same with Password";
    }
  }

  void saveEmail(value) {
    _email = value;
  }

  void savePassword(value) {
    _password = value;
  }

  void saveFirstName(value) {
    _firstName = value;
  }

  void saveLastName(value) {
    _lastName = value;
  }

  void saveMoblieNumber(value) {
    _mobileNumber = value;
  }

  void saveConfirmPassword(value) {
    _confirmPassword = value;
  }

  Future sendData(BuildContext context) async {
    Map _data = {
      "email": _email,
      "password": _password,
      "first_name": _firstName,
      "last_name": _lastName,
      "phone_number": _mobileNumber
    };
    Map _response = await SharedFunction.sendData(this.signUpUrl, {}, _data);
    Map _responseBody = _response['body'];

    if (_response['status'] == 200) {
      // successful
      // go to signin
      Navigator.pushNamed(context, 'signin');
    } else if (_response['status'] == 422) {
      // email has already been taken
      PopUp.error(context, _responseBody['errors']['full_messages'][0]);
    } else {
      // 500 error
      PopUp.error(context);
    }
  }
}
