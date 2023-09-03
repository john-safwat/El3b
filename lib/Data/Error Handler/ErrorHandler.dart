
ErrorHandler injectErrorHandler() {
  return ErrorHandler.getErrorHandler();
}

class ErrorHandler {

  ErrorHandler._();
  static ErrorHandler? instance;
  static getErrorHandler(){
    return instance??= ErrorHandler._();
  }

  String handleFirebaseImageDatabaseExceptions({required String error}) {
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

  String handleFirebaseAuthException({required String error}){
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


  String handleLoginError(String error){
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


  String handleFirebaseFireStoreError(String error){
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

}