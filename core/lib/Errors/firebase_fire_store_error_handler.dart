
FirebaseFireStoreErrorHandler injectFirebaseFireStoreErrorHandler(){
  return FirebaseFireStoreErrorHandler.getInstance();
}

class FirebaseFireStoreErrorHandler {

  FirebaseFireStoreErrorHandler._();
  static FirebaseFireStoreErrorHandler? instance;
  static getInstance(){
    return instance??= FirebaseFireStoreErrorHandler._();
  }

  String handleFirebaseFireStoreErrorEnglish(String error){
    switch (error) {
      case "ABORTED":
        error = "The operation was aborted, typically due to a concurrency issue like transaction aborts, etc.";
        break;
      case "ALREADY_EXISTS":
        error = "Some document that we attempted to create already exists.";
        break;
      case "CANCELLED":
        error = "The operation was cancelled (typically by the caller).";
        break;
      case "DATA_LOSS":
        error = 'Unrecoverable data loss or corruption.';
        break;
      case "DEADLINE_EXCEEDED":
        error = "Deadline expired before operation could complete.";
        break;
      case "FAILED_PRECONDITION":
        error = "Operation was rejected because the system is not in a state required for the operation's execution.";
        break;
      case "INTERNAL":
        error = "Internal errors.";
        break;
      case "INVALID_ARGUMENT":
        error = "Client specified an invalid argument.";
        break;
      case "NOT_FOUND":
        error = "Some requested document was not found.";
        break;
      case "OK":
        error = "The operation completed successfully.";
        break;
      case "OUT_OF_RANGE":
        error = "Operation was attempted past the valid range.";
        break;
      case "PERMISSION_DENIED":
        error = "The caller does not have permission to execute the specified operation.";
        break;
      case "RESOURCE_EXHAUSTED":
        error = "Some resource has been exhausted, perhaps a per-user quota, or perhaps the entire file system is out of space.";
        break;
      case "UNAUTHENTICATED":
        error = "The request does not have valid authentication credentials for the operation.";
        break;
      case "UNAVAILABLE":
        error = "The service is currently unavailable.";
        break;
      case "UNIMPLEMENTED":
        error = "Operation is not implemented or not supported/enabled.";
        break;
      case "UNKNOWN":
        error = "Unknown error or an error from a different error domain.";
        break;
      default:
        error = "Some Thing Went Wrong";
        break;
    }
    return error;
  }

  String handleFirebaseFireStoreErrorArabic(String error){
    switch (error) {
      case "ABORTED":
        error = "تم إحباط العملية، عادةً بسبب مشكلة في التزامن مثل إحباط المعاملة، وما إلى ذلك.";
        break;
      case "ALREADY_EXISTS":
        error = "بعض المستندات التي حاولنا إنشاءها موجودة بالفعل.";
        break;
      case "CANCELLED":
        error = "تم إلغاء العملية (عادةً بواسطة المتصل).";
        break;
      case "DATA_LOSS":
        error = 'فقدان البيانات أو تلفها بشكل غير قابل للاسترداد.';
        break;
      case "DEADLINE_EXCEEDED":
        error = "انتهى الموعد النهائي قبل أن تكتمل العملية.";
        break;
      case "FAILED_PRECONDITION":
        error = "تم رفض العملية لأن النظام ليس في الحالة المطلوبة لتنفيذ العملية.";
        break;
      case "INTERNAL":
        error = "الأخطاء الداخلية.";
        break;
      case "INVALID_ARGUMENT":
        error = "حدد العميل وسيطة غير صالحة.";
        break;
      case "NOT_FOUND":
        error = "لم يتم العثور على بعض المستندات المطلوبة.";
        break;
      case "OK":
        error = "تمت العملية بنجاح.";
        break;
      case "OUT_OF_RANGE":
        error = "تمت محاولة العملية بعد النطاق الصالح.";
        break;
      case "PERMISSION_DENIED":
        error = "المتصل ليس لديه الإذن بتنفيذ العملية المحددة.";
        break;
      case "RESOURCE_EXHAUSTED":
        error = "تم استنفاد بعض الموارد، ربما تكون الحصة النسبية لكل مستخدم، أو ربما نفدت مساحة نظام الملفات بأكمله.";
        break;
      case "UNAUTHENTICATED":
        error = "لا يحتوي الطلب على بيانات اعتماد مصادقة صالحة للعملية.";
        break;
      case "UNAVAILABLE":
        error = "الخدمة غير متوفرة حاليا.";
        break;
      case "UNIMPLEMENTED":
        error = "لم يتم تنفيذ العملية أو أنها غير مدعومة/ممكّنة.";
        break;
      case "UNKNOWN":
        error = "خطأ غير معروف أو خطأ من مجال خطأ مختلف.";
        break;
      default:
        error = "هناك خطأ ما";
        break;
    }
    return error;
  }

}