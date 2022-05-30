class CartModel {
  int? id;
  String? name;

  int? price;

  String? img;
  int? quantity;
  bool? isExist;
  String? time;

  CartModel(
      {this.id,
      this.name,
      this.price,
      this.img,
      this.quantity,
      this.time,
      this.isExist});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isExist = json["isExist"];
    price = json['price'];
    quantity = json["quantity"];
    img = json['img'];
    time = json["time"];
  }
}
