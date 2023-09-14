class PermissionDeniedException implements Exception {
  String errorMessage ;
  PermissionDeniedException({required this.errorMessage});
}