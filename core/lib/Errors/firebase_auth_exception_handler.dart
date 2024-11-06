
FirebaseAuthExceptionHandler injectFirebaseAuthExceptionHandler(){
  return FirebaseAuthExceptionHandler.getInstance();
}

class FirebaseAuthExceptionHandler {

  FirebaseAuthExceptionHandler._();
  static FirebaseAuthExceptionHandler? instance;
  static getInstance(){
    return instance??= FirebaseAuthExceptionHandler._();
  }

  String handleFirebaseAuthExceptionEnglish({required String error}){
    switch (error) {
      case "error_invalid_email":
        error = "Invalid Email Address";
        break;
      case "error_too_many_requests":
        error = "To Many Requests";
        break;
      case "error_operation_not_allowed":
        error = "Cannot Create Account Now Try Again Later";
        break;
      case "email-already-in-use":
        error = "Email Already In Use";
        break;
      default:
        error = error.toString();
    }
    return error;
  }


  String handleFirebaseAuthExceptionArabic({required String error}){
    switch (error) {
      case "error_invalid_email":
        error = "عنوان البريد الإلكتروني غير صالح";
        break;
      case "error_too_many_requests":
        error = "للعديد من الطلبات";
        break;
      case "error_operation_not_allowed":
        error = "لا يمكن إنشاء حساب الآن حاول مرة أخرى لاحقًا";
        break;
      case "email-already-in-use":
        error = "البريد الاليكتروني قيد الاستخدام";
        break;
      default:
        error = error.toString();
    }
    return error;
  }

}