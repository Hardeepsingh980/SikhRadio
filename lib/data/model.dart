import 'package:equatable/equatable.dart';

class RadioObject extends Equatable {
  final String name;
  final String desc;
  final String imgUrl;
  final String radioUrl;
  final int type;

  RadioObject({this.name, this.desc, this.imgUrl, this.radioUrl, this.type});

  factory RadioObject.fromJson(Map<String, dynamic> json) {
    return RadioObject(
        name: json['name'],
        desc: json['description'],
        imgUrl: json['img'],
        type: json['type'],
        radioUrl: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "description": this.desc,
      "img": this.imgUrl,
      "type": this.type,
      "url": this.radioUrl
    };
  }

  @override
  List<Object> get props => throw UnimplementedError();
}
