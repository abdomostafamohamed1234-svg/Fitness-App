sealed class OnBoardingEvents {}

class ChangePageEvent extends OnBoardingEvents {
  final int pageNumber;
  ChangePageEvent({required this.pageNumber});
}
