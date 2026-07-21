import 'package:flowery/features/register/domain/entities/register_entity.dart';
import 'package:json_annotation/json_annotation.dart';


part 'register_dto_request.g.dart';

@JsonSerializable()
class RegisterDto {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "user")
    User? user;
    @JsonKey(name: "token")
    String? token;
    @JsonKey(name: "error")
    String? error;
    RegisterDto({
        this.message,
        this.user,
        this.token,
        this.error
    });
    RegisterEntity toModel(){
      return RegisterEntity(massage: message, error: error);
    }
    factory RegisterDto.fromJson(Map<String, dynamic> json) => _$RegisterDtoFromJson(json);

    Map<String, dynamic> toJson() => _$RegisterDtoToJson(this);
}

@JsonSerializable()
class User {
    @JsonKey(name: "firstName")
    String? firstName;
    @JsonKey(name: "lastName")
    String? lastName;
    @JsonKey(name: "email")
    String? email;
    @JsonKey(name: "gender")
    String? gender;
    @JsonKey(name: "age")
    int? age;
    @JsonKey(name: "weight")
    int? weight;
    @JsonKey(name: "height")
    int? height;
    @JsonKey(name: "activityLevel")
    String? activityLevel;
    @JsonKey(name: "goal")
    String? goal;
    @JsonKey(name: "photo")
    String? photo;
    @JsonKey(name: "_id")
    String? id;
    @JsonKey(name: "createdAt")
    DateTime? createdAt;

    User({
        this.firstName,
        this.lastName,
        this.email,
        this.gender,
        this.age,
        this.weight,
        this.height,
        this.activityLevel,
        this.goal,
        this.photo,
        this.id,
        this.createdAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

    Map<String, dynamic> toJson() => _$UserToJson(this);
}