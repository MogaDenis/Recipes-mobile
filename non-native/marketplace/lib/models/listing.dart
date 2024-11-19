import 'package:marketplace/enums/enums.dart';

class Listing {
  Listing(
      {this.listingId = 0,
      required this.title,
      required this.description,
      required this.price,
      required this.condition,
      required this.brand,
      required this.model,
      required this.fuelType,
      required this.bodyStyle,
      required this.colour,
      required this.manufactureYear,
      required this.mileage,
      required this.emissionStandard,
      this.imagePath});

  int listingId = 0;
  String title = "";
  String description = "";
  int price = 1;
  Condition condition = Condition.New;
  String brand = "";
  String model = "";
  FuelType fuelType = FuelType.Diesel;
  BodyStyle bodyStyle = BodyStyle.Sedan;
  String colour = "";
  int manufactureYear = 2000;
  int mileage = 0;
  EmissionStandard emissionStandard = EmissionStandard.Non_euro;
  String? imagePath;

  factory Listing.fromJson(Map<String, dynamic> data) {
    final listingId = data['listingId'] as int;
    final title = data['title'] as String;
    final description = data['description'] as String;
    final price = data['price'] as int;
    final condition = Condition.values.firstWhere(
      (e) => e.toString() == 'Condition.${data['condition']}',
      orElse: () => Condition.New,
    );
    final brand = data['brand'] as String;
    final model = data['model'] as String;
    final fuelType = FuelType.values.firstWhere(
      (e) => e.toString() == 'FuelType.${data['fuelType']}',
      orElse: () => FuelType.Diesel,
    );
    final bodyStyle = BodyStyle.values.firstWhere(
      (e) => e.toString() == 'BodyStyle.${data['bodyStyle']}',
      orElse: () => BodyStyle.Sedan,
    );
    final colour = data['colour'] as String;
    final manufactureYear = data['manufactureYear'] as int;
    final mileage = data['mileage'] as int;
    final emissionStandard = EmissionStandard.values.firstWhere(
      (e) => e.toString() == 'EmissionStandard.${data['emissionStandard']}',
      orElse: () => EmissionStandard.Non_euro,
    );
    final imagePath = data['imagePath'] as String?;

    return Listing(
        listingId: listingId,
        title: title,
        description: description,
        price: price,
        condition: condition,
        brand: brand,
        model: model,
        fuelType: fuelType,
        bodyStyle: bodyStyle,
        colour: colour,
        manufactureYear: manufactureYear,
        mileage: mileage,
        emissionStandard: emissionStandard,
        imagePath: imagePath);
  }

  Map<String, dynamic> toJson() {
    return {
      'listingId': listingId,
      'title': title,
      'description': description,
      'price': price,
      'condition': condition.toString().split('.').last,
      'brand': brand,
      'model': model,
      'fuelType': fuelType.toString().split('.').last,
      'bodyStyle': bodyStyle.toString().split('.').last,
      'colour': colour,
      'manufactureYear': manufactureYear,
      'mileage': mileage,
      'emissionStandard': emissionStandard.toString().split('.').last,
      'imagePath': imagePath
    };
  }
}
