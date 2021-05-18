part of 'models.dart';

class ApiReturnValue<T> {
  final T value;
  final String message;
  final int statusCode;

  ApiReturnValue({
    this.value,
    this.message,
    this.statusCode,
  });
}
