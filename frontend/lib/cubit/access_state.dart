part of 'access_cubit.dart';

abstract class AccessState {
  const AccessState();
}

final class AccessInit extends AccessState {
  const AccessInit();
}

final class Splash extends AccessState {
  const Splash();
}

final class Register extends AccessState {
  const Register();
}

final class LogIn extends AccessState {
  const LogIn();
}

final class UserIn extends AccessState {
  const UserIn();
}
