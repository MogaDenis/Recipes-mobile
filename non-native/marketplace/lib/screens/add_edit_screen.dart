import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketplace/constants/car_data.dart';
import 'package:marketplace/widgets/bottom_nav_bar.dart';
import 'package:marketplace/widgets/dropdown_menu_widget.dart';
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
  final ImagePicker _picker = ImagePicker();

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

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  void _removeImage() {
    setState(() {
      _imagePath = null;
    });
  }

  @override
  void initState() {
    super.initState();

    _title = widget.listing?.title ?? '';
    _description = widget.listing?.description ?? '';
    _price = widget.listing?.price ?? 0;
    _condition = widget.listing?.condition ?? Condition.New;
    _brand = widget.listing?.brand ?? CarData.carBrands[0];
    _model =
        widget.listing?.model ?? CarData.carModels[CarData.carBrands[0]]![0];
    _fuelType = widget.listing?.fuelType ?? FuelType.Diesel;
    _bodyStyle = widget.listing?.bodyStyle ?? BodyStyle.Sedan;
    _colour = widget.listing?.colour ?? CarData.colours[0];
    _manufactureYear = widget.listing?.manufactureYear ?? 2000;
    _mileage = widget.listing?.mileage ?? 0;
    _emissionStandard =
        widget.listing?.emissionStandard ?? EmissionStandard.Non_euro;
    _imagePath = widget.listing?.imagePath;
  }

  void _saveForm() async {
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
        await listingsProvider.updateListing(newListing);
      } else {
        await listingsProvider.addListing(newListing);
      }

      Navigator.of(context).popUntil((route) => route.isFirst);
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  child: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: _imagePath == null
                        ? Center(
                            child: TextButton(
                              onPressed: _pickImage,
                              child: const Text("Choose Image"),
                            ),
                          )
                        : Stack(
                            fit: StackFit.expand,
                            children: [
                              File(_imagePath!).existsSync()
                                  ? Image.file(
                                      File(_imagePath!),
                                      height: 180,
                                      width: double.infinity,
                                      fit: BoxFit.fitHeight,
                                    )
                                  : Image.asset(
                                      _imagePath!,
                                      height: 180,
                                      width: double.infinity,
                                      fit: BoxFit.fitHeight,
                                    ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  child: IconButton(
                                    icon: const Icon(Icons.close,
                                        color: Colors.white),
                                    onPressed: _removeImage,
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
                ),
                TextFormField(
                  initialValue: _title,
                  decoration: const InputDecoration(labelText: 'Title'),
                  onChanged: (value) => _title = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  child: DropdownMenuWidget(
                      label: "Brand",
                      value: _brand,
                      options: CarData.carBrands,
                      onChanged: (String? value) {
                        setState(() {
                          _brand = value!;
                          _model = CarData.carModels[_brand]![0];
                        });
                      }),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  child: DropdownMenuWidget(
                      label: "Model",
                      value: _model,
                      options: CarData.carModels[_brand] ?? [],
                      onChanged: (String? value) {
                        setState(() {
                          _model = value!;
                        });
                      }),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: DropdownMenuWidget(
                          label: "Condition",
                          value: _condition.toString().split('.').last,
                          options: Condition.values
                              .map((e) => e.toString().split('.').last)
                              .toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _condition = Condition.values.firstWhere(
                                  (e) => e.toString() == 'Condition.${value!}');
                            });
                          }),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        initialValue: _price != 0 ? _price.toString() : "",
                        decoration: const InputDecoration(labelText: 'Price'),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          setState(() {
                            _price = int.tryParse(value) ?? 0;
                          });
                        },
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null) {
                            return 'Please enter a valid price';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: DropdownMenuWidget(
                          label: "Body",
                          value: _bodyStyle.toString().split('.').last,
                          options: BodyStyle.values
                              .map((e) => e.toString().split('.').last)
                              .toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _bodyStyle = BodyStyle.values.firstWhere(
                                  (e) => e.toString() == 'BodyStyle.${value!}');
                            });
                          }),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: DropdownMenuWidget(
                          label: "Fuel",
                          value: _fuelType.toString().split('.').last,
                          options: FuelType.values
                              .map((e) => e.toString().split('.').last)
                              .toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _fuelType = FuelType.values.firstWhere(
                                  (e) => e.toString() == 'FuelType.${value!}');
                            });
                          }),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: DropdownMenuWidget(
                          label: "Colour",
                          value: _colour,
                          options: CarData.colours,
                          onChanged: (String? value) {
                            setState(() {
                              _colour = value!;
                            });
                          }),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: DropdownMenuWidget(
                          label: "Manufacture year",
                          value: _manufactureYear.toString(),
                          options: CarData.yearsList
                              .map((e) => e.toString())
                              .toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _manufactureYear = int.tryParse(value!) ?? 2000;
                            });
                          }),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        initialValue: _mileage != 0 ? _price.toString() : "",
                        decoration: const InputDecoration(labelText: 'Mileage'),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          setState(() {
                            _mileage = int.tryParse(value) ?? 0;
                          });
                        },
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null) {
                            return 'Please enter a valid mileage';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: DropdownMenuWidget(
                          label: "Emission standard",
                          value: _emissionStandard.toString().split('.').last,
                          options: EmissionStandard.values
                              .map((e) => e.toString().split('.').last)
                              .toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _emissionStandard = EmissionStandard.values
                                  .firstWhere((e) =>
                                      e.toString() ==
                                      'EmissionStandard.${value!}');
                            });
                          }),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  initialValue: _description,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    alignLabelWithHint: true,
                  ),
                  onChanged: (value) => _description = value,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 120, 120, 120),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text("Discard changes?"),
                                  content:
                                      const Text("Your changes will be lost"),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, "Cancel"),
                                        child: const Text("Cancel")),
                                    TextButton(
                                        onPressed: () => {
                                              Navigator.pop(context, "Discard"),
                                              Navigator.of(context).pop()
                                            },
                                        child: const Text("Discard")),
                                  ],
                                ));
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 71, 70, 70),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _saveForm,
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
