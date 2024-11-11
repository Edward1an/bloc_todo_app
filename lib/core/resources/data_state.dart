abstract class DataState<T> {
  final T? data;
  final String? message;
  final int? statusCode;

  const DataState({this.data, this.message, this.statusCode});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailure<T> extends DataState<T> {
  const DataFailure(String message, int statusCode)
      : super(message: message, statusCode: statusCode);
}
