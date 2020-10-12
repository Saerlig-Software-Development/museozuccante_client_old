class RoomRemoteModel {
  String title;
  int floor;
  int number;
  double offsetX;
  double offsetY;
  String id;

  RoomRemoteModel({
    this.title,
    this.floor,
    this.number,
    this.offsetX,
    this.offsetY,
    this.id,
  });

  RoomRemoteModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    floor = json['floor'];
    number = json['number'];
    offsetX = json['pixel_x'] != null ? json['pixel_x'].toDouble() : null;
    offsetY = json['pixel_y'] != null ? json['pixel_y'].toDouble() : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['floor'] = this.floor;
    data['number'] = this.number;
    data['pixel_x'] = this.offsetX;
    data['pixel_y'] = this.offsetY;
    data['id'] = this.id;
    return data;
  }

  @override
  String toString() {
    return 'RoomRemoteModel(title: $title, floor: $floor, number: $number, offsetX: $offsetX, offsetY: $offsetY, id: $id)';
  }
}
