
sealed class RegisterEvents {}
class Register extends RegisterEvents {}

class RegisterNextStep extends RegisterEvents{}

class RegisterPreviousStep extends RegisterEvents{}

class NavigateToLoginEvent extends RegisterEvents{}

class ShowMassageEvent extends RegisterEvents{
    final String massage;
    ShowMassageEvent(this.massage);
}

class ShowLoadingEvent extends RegisterEvents{}
class HideLoadingEvent extends RegisterEvents{}
