abstract class TeamEvent {}

final class LoadAllTeams extends TeamEvent {
  final int id;

  LoadAllTeams({required this.id});
}

final class RequestToJoin extends TeamEvent {}
