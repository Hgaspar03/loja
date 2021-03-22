class ItemSize {
  ItemSize.fromMap(Map<String, dynamic> map) {
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }

  ItemSize();

  String name;
  num price;
  int stock;

  @override
  String toString() {
    return 'ItemSize{ Name: $name, Price: $price, Stock: $stock}';
  }

  bool get hasStock => stock > 0;
}
