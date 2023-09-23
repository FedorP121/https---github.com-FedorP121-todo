// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class Failure {}

class ServerError extends Failure {
  Object error;
  ServerError({
    required this.error,
  });
}
