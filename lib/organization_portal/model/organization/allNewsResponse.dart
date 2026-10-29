class TrackingResponse {
  String? message;
  List<Content>? data;
  bool? success;

  TrackingResponse({
    this.message,
    this.data,
    this.success,
  });

  factory TrackingResponse.fromJson(Map<String, dynamic> json) => TrackingResponse(
    message: json["message"],
    data: json["data"] == null ? [] : List<Content>.from(json["data"]!.map((x) => Content.fromJson(x))),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "success": success,
  };
}

class Content {
  int? id;
  String? topicName;
  String? description;
  int? userId;
  String? image;
  dynamic image2;
  dynamic image3;
  dynamic image4;
  dynamic image5;
  int? isApproved;
  DateTime? date;
  String? imageType;
  dynamic youtubeLink;
  dynamic firstName;
  dynamic lastName;
  dynamic mobileNumber;
  dynamic companyName;
  dynamic profilePicture;

  Content({
    this.id,
    this.topicName,
    this.description,
    this.userId,
    this.image,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    this.isApproved,
    this.date,
    this.imageType,
    this.youtubeLink,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.companyName,
    this.profilePicture,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    id: json["id"],
    topicName: json["topicName"],
    description: json["description"],
    userId: json["userId"],
    image: json["image"],
    image2: json["image2"],
    image3: json["image3"],
    image4: json["image4"],
    image5: json["image5"],
    isApproved: json["isApproved"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    imageType: json["imageType"],
    youtubeLink: json["youtubeLink"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    mobileNumber: json["mobileNumber"],
    companyName: json["companyName"],
    profilePicture: json["profilePicture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "topicName": topicName,
    "description": description,
    "userId": userId,
    "image": image,
    "image2": image2,
    "image3": image3,
    "image4": image4,
    "image5": image5,
    "isApproved": isApproved,
    "date": date?.toIso8601String(),
    "imageType": imageType,
    "youtubeLink": youtubeLink,
    "firstName": firstName,
    "lastName": lastName,
    "mobileNumber": mobileNumber,
    "companyName": companyName,
    "profilePicture": profilePicture,
  };
}
