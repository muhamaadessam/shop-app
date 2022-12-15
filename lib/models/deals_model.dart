class DealsModel {
  List<Deals>? deals;

  DealsModel(
      {this.deals,
      required id,
      required title,
      required category,
      required description,
      required price});

  DealsModel.fromJson(Map<String, dynamic> json) {
    if (json['deals'] != null) {
      deals = <Deals>[];
      json['deals'].forEach((v) {
        deals!.add(Deals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.deals != null) {
      data['deals'] = this.deals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Deals {
  String? title;
  int? id;
  String? description;
  String? time;
  bool? favorite;
  int? price;
  int? oldPrice;

  Deals(
      {this.title,
      this.id,
      this.description,
      this.time,
      this.favorite,
      this.price,
      this.oldPrice,
      required category});

  Deals.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    description = json['description'];
    time = json['time'];
    favorite = json['favorite'];
    price = json['price'];
    oldPrice = json['oldPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.id;
    data['description'] = this.description;
    data['time'] = this.time;
    data['favorite'] = this.favorite;
    data['price'] = this.price;
    data['oldPrice'] = this.oldPrice;
    return data;
  }
}
