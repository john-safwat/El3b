
FirebaseImageDatabaseExceptionsHandler injectFirebaseImageDatabaseExceptionsHandler(){
  return FirebaseImageDatabaseExceptionsHandler.getInstance();
}

class FirebaseImageDatabaseExceptionsHandler {

  FirebaseImageDatabaseExceptionsHandler._();
  static FirebaseImageDatabaseExceptionsHandler? instance;
  static getInstance(){
    return instance??= FirebaseImageDatabaseExceptionsHandler._();
  }

  String handleFirebaseImageDatabaseExceptionsEnglish({required String error}) {
    switch (error) {
      case "storage/unknown":
        error = "storage/unknown";
        break;
      case "storage/object-not-found":
        error = "storage/object-not-found";
        break;
      case "storage/bucket-not-found":
        error = "No bucket is configured for Cloud Storage";
        break;
      case "storage/project-not-found":
        error = "No project is configured for Cloud Storage";
        break;
      case "storage/quota-exceeded":
        error = "Quota on your Cloud Storage bucket has been exceeded. If you're on the no-cost tier, upgrade to a paid plan. If you're on a paid plan, reach out to Firebase support.";
        break;
      case "storage/unauthenticated":
        error = "User is unauthenticated, please authenticate and try again.";
        break;
      case "storage/unauthorized":
        error = "User is not authorized to perform the desired action, check your security rules to ensure they are correct.";
        break;
      case "storage/retry-limit-exceeded":
        error = "The maximum time limit on an operation (upload, download, delete, etc.) has been excceded. Try uploading again.";
        break;
      case "storage/invalid-checksum":
        error = "File on the client does not match the checksum of the file received by the server. Try uploading again.";
        break;
      case "storage/canceled":
        error = "User canceled the operation.";
        break;
      case "storage/invalid-event-name":
        error = "Invalid event name provided. Must be one of [running, progress, pause]";
        break;
      case "storage/invalid-url":
        error = "Invalid URL provided to refFromURL(). Must be of the form: gs://bucket/object or https://firebasestorage.googleapis.com/v0/b/bucket/o/object?token=<TOKEN>";
        break;
      case "storage/invalid-argument":
        error = "The argument passed to put() must be File, Blob, or UInt8 Array. The argument passed to putString() must be a raw, Base64, or Base64URL string.";
        break;
      case "storage/no-default-bucket":
        error = "No bucket has been set in your config's storageBucket property.";
        break;
      case "storage/cannot-slice-blob":
        error = "Commonly occurs when the local file has changed (deleted, saved again, etc.). Try uploading again after verifying that the file hasn't changed.";
        break;
      case "storage/server-file-wrong-size":
        error = "File on the client does not match the size of the file recieved by the server. Try uploading again.";
        break;
      default:
        error = error.toString();
    }
    return error;
  }

  String handleFirebaseImageDatabaseExceptionsArabic({required String error}) {
    switch (error) {
      case "storage/unknown":
        error = "التخزين/غير معروف";
        break;
      case "storage/object-not-found":
        error = "التخزين/الكائن غير موجود";
        break;
      case "storage/bucket-not-found":
        error = "لم يتم تكوين أي حاوية للتخزين السحابي";
        break;
      case "storage/project-not-found":
        error = "لم يتم تكوين أي مشروع للتخزين السحابي";
        break;
      case "storage/quota-exceeded":
        error = "لقد تم تجاوز الحصة المخصصة لحاوية التخزين السحابي الخاصة بك. إذا كنت في المستوى المجاني، قم بالترقية إلى الخطة المدفوعة. إذا كنت تستخدم خطة مدفوعة، فاتصل بدعم Firebase.";
        break;
      case "storage/unauthenticated":
        error = "لم يتم التحقق من المستخدم، يرجى التحقق والمحاولة مرة أخرى.";
        break;
      case "storage/unauthorized":
        error = "المستخدم غير مصرح له بتنفيذ الإجراء المطلوب، تحقق من قواعد الأمان الخاصة بك للتأكد من صحتها.";
        break;
      case "storage/retry-limit-exceeded":
        error = "تم تجاوز الحد الأقصى للوقت المحدد للعملية (التحميل، التنزيل، الحذف، وما إلى ذلك). حاول التحميل مرة أخرى.";
        break;
      case "storage/invalid-checksum":
        error = "الملف الموجود على العميل لا يتطابق مع المجموع الاختباري للملف الذي يتلقاه الخادم. حاول التحميل مرة أخرى.";
        break;
      case "storage/canceled":
        error = "ألغى المستخدم العملية.";
        break;
      case "storage/invalid-event-name":
        error = "تم تقديم اسم حدث غير صالح. يجب أن يكون واحدًا من [التشغيل، التقدم، الإيقاف المؤقت]";
        break;
      case "storage/invalid-url":
        error = "تم تقديم عنوان URL غير صالح إلى refFromURL(). يجب أن يكون بالشكل: gs://bucket/object أو https://firebasestorage.googleapis.com/v0/b/bucket/o/object?token=<TOKEN>";
        break;
      case "storage/invalid-argument":
        error = "يجب أن تكون الوسيطة التي تم تمريرها إلى put() هي File أو Blob أو UInt8 Array. يجب أن تكون الوسيطة التي تم تمريرها إلى putString() عبارة عن سلسلة خام أو Base64 أو Base64URL.";
        break;
      case "storage/no-default-bucket":
        error = "لم يتم تعيين أي حاوية في خاصية StorageBucket الخاصة بالتكوين الخاص بك.";
        break;
      case "storage/cannot-slice-blob":
        error = "يحدث هذا عادةً عند تغيير الملف المحلي (حذفه أو حفظه مرة أخرى وما إلى ذلك). حاول التحميل مرة أخرى بعد التأكد من عدم تغيير الملف.";
        break;
      case "storage/server-file-wrong-size":
        error = "الملف الموجود على العميل لا يتطابق مع حجم الملف الذي يتلقاه الخادم. حاول التحميل مرة أخرى.";
        break;
      default:
        error = error.toString();
    }
    return error;
  }

}