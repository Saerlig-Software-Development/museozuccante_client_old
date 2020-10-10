class ItemRemoteModel {
  String title;
  String subtitle;
  String poster;
  String body;
  RoomRemoteModel room;
  String id;

  ItemRemoteModel({
    this.title,
    this.subtitle,
    this.poster,
    this.body,
    this.room,
    this.id,
  });

  ItemRemoteModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    poster = json['poster'];
    body = json['body'];
    room = json['room'] != null
        ? new RoomRemoteModel.fromJson(json['room'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['poster'] = this.poster;
    data['body'] = this.body;
    if (this.room != null) {
      data['room'] = this.room.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class RoomRemoteModel {
  String id;
  String title;
  int floor;
  int number;

  RoomRemoteModel({
    this.id,
    this.title,
    this.floor,
    this.number,
  });

  RoomRemoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    floor = json['floor'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['floor'] = this.floor;
    data['number'] = this.number;
    return data;
  }
}
