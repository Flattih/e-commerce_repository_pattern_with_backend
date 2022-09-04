import 'package:e_commerce/features/home/domain/models/products_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  ProductModel? product;

  CartModel(
      {this.id,
      this.name,
      this.price,
      this.img,
      this.quantity,
      this.time,
      this.isExist,
      this.product});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isExist = json["isExist"];
    price = json['price'];
    quantity = json["quantity"];
    img = json['img'];
    time = json["time"];
    product =
        json["product"] != null ? ProductModel.fromJson(json["product"]) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "price": this.price,
      "img": this.img,
      "quantity": this.quantity,
      "isExist": this.isExist,
      "time": this.time,
      "product": this.product!.toJson()
    };
  }
}
