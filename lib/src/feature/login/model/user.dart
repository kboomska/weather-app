import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String? idToken;
  final String? email;
  final String? refreshToken;
  final String? expiresIn;
  final String? localId;
  final bool? registered;
  final String? displayName;

  const User({
    required this.idToken,
    required this.email,
    required this.refreshToken,
    required this.expiresIn,
    required this.localId,
    required this.registered,
    required this.displayName,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.idToken == idToken &&
        other.email == email &&
        other.refreshToken == refreshToken &&
        other.expiresIn == expiresIn &&
        other.localId == localId &&
        other.registered == registered &&
        other.displayName == displayName;
  }

  @override
  int get hashCode {
    return idToken.hashCode ^
        email.hashCode ^
        refreshToken.hashCode ^
        expiresIn.hashCode ^
        localId.hashCode ^
        registered.hashCode ^
        displayName.hashCode;
  }
}
