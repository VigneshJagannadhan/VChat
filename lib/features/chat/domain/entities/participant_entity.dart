import 'package:equatable/equatable.dart';

class ParticipantEntity extends Equatable {
  final String? id;
  final String? username;
  final String? email;

  const ParticipantEntity({
    required this.id,
    required this.username,
    required this.email,
  });

  @override
  List<Object?> get props => [id, username, email];
}
