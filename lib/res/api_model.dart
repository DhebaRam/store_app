
class ApiResponseModel {
  ErrorModel? error;
  bool status;
  dynamic data;

  ApiResponseModel(this.data, this.error, this.status);
}

class ErrorModel {
  String title, description;
  int statusCode;

  ErrorModel(this.title, this.description, this.statusCode);
}