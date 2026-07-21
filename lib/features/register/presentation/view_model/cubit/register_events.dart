
sealed class RegisterEvent {}
class Register extends RegisterEvent {}

class RegisterNextStep extends RegisterEvent{}

class RegisterPreviousStep extends RegisterEvent{}

class NavigateToLoginEvent extends RegisterEvent{}

class ShowMassageEvent extends RegisterEvent{
    final String massage;
    ShowMassageEvent(this.massage);
}

class ShowLoadingEvent extends RegisterEvent{}
class HideLoadingEvent extends RegisterEvent{}
