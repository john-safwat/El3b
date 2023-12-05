
FirebaseLoginErrorHandler injectFirebaseLoginErrorHandler(){
  return FirebaseLoginErrorHandler.getInstance();
}

class FirebaseLoginErrorHandler{

  FirebaseLoginErrorHandler._();
  static FirebaseLoginErrorHandler? instance;
  static getInstance(){
    return instance??= FirebaseLoginErrorHandler._();
  }

  String handleLoginErrorEnglish(String error){
    switch (error) {
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        error = "Wrong email/password combination.";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        error = "No user found with this email.";
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        error = "User disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        error = "Too many requests to log into this account.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        error = "Email address is invalid.";
        break;
      default:
        error = "Login failed. Please try again.";
        break;
    }
    return error;
  }

  String handleLoginErrorArabic(String error){
    switch (error) {
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        error = "مزيج خاطئ من البريد الإلكتروني/كلمة المرور.";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        error = "لم يتم العثور على مستخدم مع هذا البريد الإلكتروني.";
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        error = "تم تعطيل المستخدم.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        error = "هناك طلبات كثيرة جدًا لتسجيل الدخول إلى هذا الحساب.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        error = "عنوان البريد الإلكتروني غير صالح.";
        break;
      default:
        error = "فشل تسجيل الدخول. حاول مرة اخرى.";
        break;
    }
    return error;
  }

}