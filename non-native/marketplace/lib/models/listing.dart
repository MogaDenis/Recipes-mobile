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

  String get conditionToString => condition.toString().split('.').last;
  String get fuelTypeToString => fuelType.toString().split('.').last;
  String get bodyStyleToString => bodyStyle.toString().split('.').last;
  String get emissionStandardToString =>
      emissionStandard.toString().split('.').last;

  factory Listing.fromJson(Map<String, dynamic> data) {
    final listingId = data['listingId'] ?? data['ListingId'] as int;
    final title = data['title'] ?? data['Title'] as String;
    final description = data['description'] ?? data['Description'] as String;
    final price = data['price'] ?? data['Price'] as int;
    final condition = data['condition'] != null
        ? Condition.values[data['condition']]
        : Condition.values[data['Condition']];
    final brand = data['brand'] ?? data['Brand'] as String;
    final model = data['model'] ?? data['Model'] as String;
    final fuelType = data['fuelType'] != null
        ? FuelType.values[data['fuelType']]
        : FuelType.values[data['FuelType']];
    final bodyStyle = data['bodyStyle'] != null
        ? BodyStyle.values[data['bodyStyle']]
        : BodyStyle.values[data['BodyStyle']];
    final colour = data['colour'] ?? data['Colour'] as String;
    final manufactureYear =
        data['manufactureYear'] ?? data['ManufactureYear'] as int;
    final mileage = data['mileage'] ?? data['Mileage'] as int;
    final emissionStandard = data['emissionStandard'] != null
        ? EmissionStandard.values[data['emissionStandard']]
        : EmissionStandard.values[data['EmissionStandard']];
    final imagePath = data['imagePath'] ?? data['ImagePath'] as String?;

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
      'condition': condition.index,
      'brand': brand,
      'model': model,
      'fuelType': fuelType.index,
      'bodyStyle': bodyStyle.index,
      'colour': colour,
      'manufactureYear': manufactureYear,
      'mileage': mileage,
      'emissionStandard': emissionStandard.index,
      'imagePath': imagePath
    };
  }
}
