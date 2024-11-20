import 'package:flutter/material.dart';
import 'package:marketplace/widgets/top_app_bar.dart';
import 'package:marketplace/enums/enums.dart';
import 'package:marketplace/models/listing.dart';
import 'package:marketplace/providers/listings_provider.dart';
import 'package:provider/provider.dart';

class AddEditScreen extends StatefulWidget {
  final Listing? listing;

  const AddEditScreen({super.key, this.listing});

  @override
  State<AddEditScreen> createState() => _AddEditScreen();
}

class _AddEditScreen extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _title;
  late String _description;
  late int _price;
  late Condition _condition;
  late String _brand;
  late String _model;
  late FuelType _fuelType;
  late BodyStyle _bodyStyle;
  late String _colour;
  late int _manufactureYear;
  late int _mileage;
  late EmissionStandard _emissionStandard;
  late String? _imagePath;

  @override
  void initState() {
    super.initState();

    _title = widget.listing?.title ?? '';
    _description = widget.listing?.description ?? '';
    _price = widget.listing?.price ?? 0;
    _condition = widget.listing?.condition ?? Condition.New;
    _brand = widget.listing?.brand ?? '';
    _model = widget.listing?.model ?? '';
    _fuelType = widget.listing?.fuelType ?? FuelType.Diesel;
    _bodyStyle = widget.listing?.bodyStyle ?? BodyStyle.Sedan;
    _colour = widget.listing?.colour ?? '';
    _manufactureYear = widget.listing?.manufactureYear ?? 2000;
    _mileage = widget.listing?.mileage ?? 0;
    _emissionStandard =
        widget.listing?.emissionStandard ?? EmissionStandard.Non_euro;
    _imagePath = widget.listing?.imagePath;
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final listingsProvider =
          Provider.of<ListingsProvider>(context, listen: false);

      Listing newListing = Listing(
          title: _title,
          description: _description,
          price: _price,
          condition: _condition,
          brand: _brand,
          model: _model,
          fuelType: _fuelType,
          bodyStyle: _bodyStyle,
          colour: _colour,
          manufactureYear: _manufactureYear,
          mileage: _mileage,
          emissionStandard: _emissionStandard,
          imagePath: _imagePath);

      if (widget.listing != null) {
        newListing.listingId = widget.listing!.listingId;
        listingsProvider.updateListing(newListing);
      } else {
        listingsProvider.addListing(newListing);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
          title:
              widget.listing != null ? 'Edit listing' : 'Create new listing'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _saveForm,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
