class GlobalUser {
  final String? id;
  final String? firstname;
  final String? lastname;
  final String? username;
  final String? email;
  final String? dialCode;
  final String? mobile;
  final String? refBy;
  final String? image;
  final String? countryName;
  final String? countryCode;
  final String? city;
  final String? state;
  final String? zip;
  final String? address;
  final String? status;
  final String? ev;
  final String? sv;
  final String? tv;
  final String? profileComplete;
  final String? verCodeSendAt;
  final String? banReason;
  final String? provider;
  final String? providerId;
  final String? createdAt;
  final String? updatedAt;
  final String? imagePath;

  GlobalUser({
    this.id,
    this.firstname,
    this.lastname,
    this.username,
    this.email,
    this.dialCode,
    this.mobile,
    this.refBy,
    this.image,
    this.countryName,
    this.countryCode,
    this.city,
    this.state,
    this.zip,
    this.address,
    this.status,
    this.ev,
    this.sv,
    this.tv,
    this.profileComplete,
    this.verCodeSendAt,
    this.banReason,
    this.provider,
    this.providerId,
    this.createdAt,
    this.updatedAt,
    this.imagePath,
  });

  factory GlobalUser.fromJson(Map<String, dynamic> json) => GlobalUser(
        id: json["id"]?.toString(),
        firstname: json["firstname"]?.toString(),
        lastname: json["lastname"]?.toString(),
        username: json["username"]?.toString(),
        email: json["email"]?.toString(),
        dialCode: json["dial_code"]?.toString(),
        mobile: json["mobile"]?.toString(),
        refBy: json["ref_by"]?.toString(),
        image: json["image"]?.toString(),
        countryName: json["country_name"]?.toString(),
        countryCode: json["country_code"]?.toString(),
        city: json["city"]?.toString(),
        state: json["state"]?.toString(),
        zip: json["zip"]?.toString(),
        address: json["address"]?.toString(),
        status: json["status"]?.toString(),
        ev: json["ev"]?.toString(),
        sv: json["sv"]?.toString(),
        tv: json["tv"]?.toString(),
        profileComplete: json["profile_complete"]?.toString(),
        verCodeSendAt: json["ver_code_send_at"]?.toString(),
        banReason: json["ban_reason"]?.toString(),
        provider: json["provider"]?.toString(),
        providerId: json["provider_id"]?.toString(),
        createdAt: json["created_at"]?.toString(),
        updatedAt: json["updated_at"]?.toString(),
        imagePath: json["image_path"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "email": email,
        "dial_code": dialCode,
        "mobile": mobile,
        "ref_by": refBy,
        "image": image,
        "country_name": countryName,
        "country_code": countryCode,
        "city": city,
        "state": state,
        "zip": zip,
        "address": address,
        "status": status,
        "ev": ev,
        "sv": sv,
        "tv": tv,
        "profile_complete": profileComplete,
        "ver_code_send_at": verCodeSendAt,
        "ban_reason": banReason,
        "provider": provider,
        "provider_id": providerId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "image_path": imagePath,
      };
}
