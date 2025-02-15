class PropertyList {
  List<Property> properties;

  PropertyList({required this.properties});

  // Factory method to create an instance from JSON
  factory PropertyList.fromJson(Map<String, dynamic> json) {
    return PropertyList(
      properties: (json['properties'] as List)
          .map((item) => Property.fromJson(item))
          .toList(),
    );
  }

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'properties': properties.map((item) => item.toJson()).toList(),
    };
  }
}

class Property {
  String image;
  int amount;
  String address;
  int bedrooms;
  int bathrooms;
  int area;
  int garage;
  double lat;
  double long;
  String description;

  Property({
    required this.image,
    required this.amount,
    required this.address,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.garage,
    required this.lat,
    required this.long,
    required this.description,
  });

  // Factory method to create an instance from JSON
  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      image: json['image'],
      amount: json['amount'],
      address: json['address'],
      bedrooms: json['bedrooms'],
      bathrooms: json['bathrooms'],
      area: json['area'],
      garage: json['garage'],
      lat: json['lat'],
      long: json['long'],
      description: json['description'],
    );
  }

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'amount': amount,
      'address': address,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'area': area,
      'garage': garage,
      'lat': lat,
      'long': long,
      'description': description,
    };
  }
}
