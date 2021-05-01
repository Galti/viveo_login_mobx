import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'form_store.g.dart';

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  final FormErrorState error = FormErrorState();

  @observable
  String userName = '';

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  late List<ReactionDisposer> _disposers;

  void setupValidations() {
    _disposers = [
      reaction((_) => userName, validateUsername),
      reaction((_) => password, validatePassword),
      reaction((_) => confirmPassword, validateConfirmPassword),
    ];
  }

  @action
  void setUsername(String value) {
    userName = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

  @action
  void resetValues() {
    confirmPassword = '';
    error.username = null;
    error.password = null;
    error.confirmPassword = null;
  }

  @action
  void validateUsername(String value) {
    error.username = isNull(value) || value.isEmpty ? 'Cannot be blank' : null;
  }

  @action
  void validatePassword(String value) {
    error.password = isNull(value) || value.isEmpty ? 'Cannot be blank' : null;
  }

  @action
  void validateConfirmPassword(String value) {
    error.confirmPassword =
        isNull(value) || value.isEmpty ? 'Cannot be blank' : null;

    if (error.confirmPassword == null) {
      error.confirmPassword =
          value == password ? null : "Passwords don't match";
    }
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  bool validateLogin() {
    validateUsername(userName);
    validatePassword(password);

    return isNull(error.username) && isNull(error.password);
  }

  bool validateSignUp() {
    validateUsername(userName);
    validatePassword(password);
    validateConfirmPassword(confirmPassword);

    return isNull(error.username) &&
        isNull(error.password) &&
        isNull(error.confirmPassword);
  }
}

class FormErrorState = _FormErrorState with _$FormErrorState;

abstract class _FormErrorState with Store {
  @observable
  String? username;

  @observable
  String? password;

  @observable
  String? confirmPassword;
}
