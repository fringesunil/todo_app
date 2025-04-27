class Validators {
  String? Function(String?) emailValidator = (email) {
    RegExp reg =
        RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|'
            r'(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\'
            r'.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (email!.isEmpty) {
      return "Email is required";
    } else if (!reg.hasMatch(email)) {
      return "Invalid Email ID";
    } else {
      return null;
    }
  };
  String? Function(String?) passwordValidator = (password) {
    if (password!.isEmpty) {
      return 'Password is required';
    } else if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  };
  String? Function(String?) nameValidator = (name) {
    if (name!.isEmpty) {
      return 'User Name is required';
    }
    return null;
  };
}
