class Validators {
  static bool email(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  static bool string(String val) {
    return val.trim().length > 1;
  }

  static bool password(String val) {
    return val.trim().length > 6;
  }
}
