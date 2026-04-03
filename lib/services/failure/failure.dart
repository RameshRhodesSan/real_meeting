abstract class Failure {
  String get message;
}

class ApiFailure extends Failure {
  @override
  final String message;

  ApiFailure({required this.message});
}
