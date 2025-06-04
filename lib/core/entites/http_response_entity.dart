final class HttpResponseEntity<T> {
  const HttpResponseEntity({
    this.data,
    this.statusCode,
  });

  /// Response body. may have been transformed, please refer to [ResponseType].
  final T? data;

  /// Http status code.
  final int? statusCode;
}