
sealed class RegisterTempEvents {}
class NavigateToLoginTempEvent extends RegisterTempEvents {}
class ShowMassageTempEvent extends RegisterTempEvents {
  final String message;
  ShowMassageTempEvent(this.message);
}
class ShowLoadingTempEvent extends RegisterTempEvents{
  
}
class HideLoadingTempEvent extends RegisterTempEvents{

}