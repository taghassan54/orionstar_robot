class PersonResDataModel {
  int? age;
  int? angle;
  double? angleInView;
  int? bodyX;
  int? bodyY;
  int? bodyheight;
  int? bodywidth;
  double? distance;
  double? faceAngleX;
  double? faceAngleY;
  int? faceX;
  int? faceY;
  int? faceheight;
  int? facewidth;
  bool? fakeFace;
  int? gender;
  int? glasses;
  int? headSpeed;
  int? id;
  bool? isNewUser;
  bool? isStaff;
  int? latency;
  double? mouthmoveScore;
  int? mouthstate;
  String? name;
  bool? otherFace;
  int? roleId;
  int? timestamp;
  double? ukfBodyOmega;
  double? ukfBodyVel;
  bool? withBody;
  bool? withFace;

  PersonResDataModel(
      {this.age,
        this.angle,
        this.angleInView,
        this.bodyX,
        this.bodyY,
        this.bodyheight,
        this.bodywidth,
        this.distance,
        this.faceAngleX,
        this.faceAngleY,
        this.faceX,
        this.faceY,
        this.faceheight,
        this.facewidth,
        this.fakeFace,
        this.gender,
        this.glasses,
        this.headSpeed,
        this.id,
        this.isNewUser,
        this.isStaff,
        this.latency,
        this.mouthmoveScore,
        this.mouthstate,
        this.name,
        this.otherFace,
        this.roleId,
        this.timestamp,
        this.ukfBodyOmega,
        this.ukfBodyVel,
        this.withBody,
        this.withFace});

  PersonResDataModel.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    angle = json['angle'];
    angleInView = json['angleInView'];
    bodyX = json['bodyX'];
    bodyY = json['bodyY'];
    bodyheight = json['bodyheight'];
    bodywidth = json['bodywidth'];
    distance = json['distance'];
    faceAngleX = json['faceAngleX'];
    faceAngleY = json['faceAngleY'];
    faceX = json['faceX'];
    faceY = json['faceY'];
    faceheight = json['faceheight'];
    facewidth = json['facewidth'];
    fakeFace = json['fake_face'];
    gender = json['gender']!=null?int.parse("${json['gender']}"):0;
    glasses = json['glasses'];
    headSpeed = json['headSpeed'];
    id = json['id'];
    isNewUser = json['isNewUser'];
    isStaff = json['isStaff'];
    latency = json['latency'];
    mouthmoveScore = json['mouthmove_score']!=null?double.parse("${json['mouthmove_score']}"):0;
    mouthstate = json['mouthstate'];
    name = json['name'];
    otherFace = json['other_face'];
    roleId = json['role_id'];
    timestamp = json['timestamp'];
    ukfBodyOmega = json['ukfBodyOmega']!=null?double.parse("${json['ukfBodyOmega']}"):0;
    ukfBodyVel = json['ukfBodyVel']!=null?double.parse("${json['ukfBodyVel']}"):0;
    withBody = json['with_body'];
    withFace = json['with_face'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    data['angle'] = this.angle;
    data['angleInView'] = this.angleInView;
    data['bodyX'] = this.bodyX;
    data['bodyY'] = this.bodyY;
    data['bodyheight'] = this.bodyheight;
    data['bodywidth'] = this.bodywidth;
    data['distance'] = this.distance;
    data['faceAngleX'] = this.faceAngleX;
    data['faceAngleY'] = this.faceAngleY;
    data['faceX'] = this.faceX;
    data['faceY'] = this.faceY;
    data['faceheight'] = this.faceheight;
    data['facewidth'] = this.facewidth;
    data['fake_face'] = this.fakeFace;
    data['gender'] = this.gender;
    data['glasses'] = this.glasses;
    data['headSpeed'] = this.headSpeed;
    data['id'] = this.id;
    data['isNewUser'] = this.isNewUser;
    data['isStaff'] = this.isStaff;
    data['latency'] = this.latency;
    data['mouthmove_score'] = this.mouthmoveScore;
    data['mouthstate'] = this.mouthstate;
    data['name'] = this.name;
    data['other_face'] = this.otherFace;
    data['role_id'] = this.roleId;
    data['timestamp'] = this.timestamp;
    data['ukfBodyOmega'] = this.ukfBodyOmega;
    data['ukfBodyVel'] = this.ukfBodyVel;
    data['with_body'] = this.withBody;
    data['with_face'] = this.withFace;
    return data;
  }
}
