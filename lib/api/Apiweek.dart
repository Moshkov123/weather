class Apiweek {
  Location? location;
  Current? current;
  Forecast? forecast;

  Apiweek({this.location, this.current, this.forecast});

  Apiweek.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    current =
    json['current'] != null ? new Current.fromJson(json['current']) : null;
    if (json['forecast'] != null) {
      forecast = new Forecast.fromJson(json['forecast']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.current != null) {
      data['current'] = this.current!.toJson();
    }
    if (this.forecast != null) {
      data['forecast'] = this.forecast!.toJson();
    }
    return data;
  }
}
class Forecast {
  List<Days>? forecastday;

  Forecast({this.forecastday});

  Forecast.fromJson(Map<String, dynamic> json) {
    if (json['forecastday'] != null) {
      forecastday = (json['forecastday'] as List)
          .map((i) => Days.fromJson(i))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.forecastday != null) {
      data['forecastday'] = this.forecastday!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Days {
  String? date;
  Day? day; // Add this line to represent the nested 'day' object
  Condition? condition;
  double? maxtempC;
  double? mintempC;
  double? avgtempC;
  double? totalprecipMm;

  Days({this.date, this.day, this.condition, this.maxtempC, this.mintempC, this.avgtempC, this.totalprecipMm});

  Days.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    // Parse the nested 'day' object
    if (json['day'] != null) {
      day = new Day.fromJson(json['day']);
    }
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
    maxtempC = json['maxtemp_c'];
    mintempC = json['mintemp_c'];
    avgtempC = json['avgtemp_c'];
    totalprecipMm = json['totalprecip_mm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.day != null) {
      data['day'] = this.day!.toJson();
    }
    if (this.condition != null) {
      data['condition'] = this.condition!.toJson();
    }
    data['maxtemp_c'] = this.maxtempC;
    data['mintemp_c'] = this.mintempC;
    data['avgtemp_c'] = this.avgtempC;
    data['totalprecip_mm'] = this.totalprecipMm;
    return data;
  }
}

// Define the Day class to represent the nested 'day' object
class Day {
  double? maxtempC;
  double? mintempC;
  double? avgtempC;
  // Add other fields as needed

  Day({this.maxtempC, this.mintempC, this.avgtempC});

  Day.fromJson(Map<String, dynamic> json) {
    maxtempC = json['maxtemp_c'];
    mintempC = json['mintemp_c'];
    avgtempC = json['avgtemp_c'];
    // Parse other fields as needed
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maxtemp_c'] = this.maxtempC;
    data['mintemp_c'] = this.mintempC;
    data['avgtemp_c'] = this.avgtempC;
    // Add other fields to the map as needed
    return data;
  }
}
class Location {
  String? name;
  String? country;
  String? localtime;

  Location({this.name, this.country, this.localtime});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    localtime = json['localtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['country'] = this.country;
    data['localtime'] = this.localtime;
    return data;
  }
}

class Current {
  double? tempC;
  int? isDay;
  Condition? condition;
  double? windKph;
  double? precipMm;
  int? humidity;
  double? uv;

  Current(
      {this.tempC,
        this.isDay,
        this.condition,
        this.windKph,
        this.precipMm,
        this.humidity,
        this.uv});

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    isDay = json['is_day'];
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
    windKph = json['wind_kph'];
    precipMm = json['precip_mm'];
    humidity = json['humidity'];
    uv = json['uv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp_c'] = this.tempC;
    data['is_day'] = this.isDay;
    if (this.condition != null) {
      data['condition'] = this.condition!.toJson();
    }
    data['wind_kph'] = this.windKph;
    data['precip_mm'] = this.precipMm;
    data['humidity'] = this.humidity;
    data['uv'] = this.uv;
    return data;
  }
}

class Condition {
  String? text;
  String? icon;
  int? code;

  Condition({this.text, this.icon, this.code});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['icon'] = this.icon;
    data['code'] = this.code;
    return data;
  }
}

