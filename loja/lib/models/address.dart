class Address {
  Address(
      {this.street,
      this.number,
      this.complement,
      this.district,
      this.zipCode,
      this.city,
      this.state,
      this.lat,
      this.long});

  String street;
  String number;
  String complement;
  String district;
  String zipCode;
  String city;
  String state;

  double lat;
  double long;

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'number': number,
      'complement': complement,
      'district': district,
      'zipCode': zipCode,
      'city': city,
      'state': state,
      'lat': lat,
      'long': long
    };
  }

  static Address fromMap(Map<String, dynamic> data) {
    return Address(
        street: data['street'],
        number: data['number'],
        complement: data['complement'],
        district: data['district'],
        zipCode: data['zipCode'],
        city: data['city'],
        state: data['state'],
        lat: data['lat'],
        long: data['long']);
  }
}
