abstract class UserDataEvent {}


class UserDataLoad extends UserDataEvent {

    final String userId;

    UserDataLoad({required this.userId});


}