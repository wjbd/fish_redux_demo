class Weather {
  String date;
  String high;
  String low;
  String type;

  Weather({this.date, this.high, this.low, this.type});

  Weather.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    high = json['high'];
    low = json['low'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['high'] = this.high;
    data['low'] = this.low;
    data['type'] = this.type;
    return data;
  }

  @override
  String toString() {
    return 'Weather{data:$date}';
  }
}
