class SectionItem {
  SectionItem.fromMap(Map<String, dynamic> map) {
    image = map['image'] as String;
    product = map['product'] as String;
  }

  SectionItem({this.image, this.product});
  dynamic image;

  String product;

  @override
  String toString() {
    return 'SectionItem: $image';
  }

  SectionItem clone() {
    return SectionItem(image: image, product: product);
  }

  Map<String, dynamic> toMap() {
    return {'image': image, 'product': product};
  }
}
