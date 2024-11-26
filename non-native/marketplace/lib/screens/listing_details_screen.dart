import 'dart:io';

import 'package:flutter/material.dart';
import 'package:marketplace/models/listing.dart';
import 'package:marketplace/providers/listings_provider.dart';
import 'package:marketplace/screens/add_edit_screen.dart';
import 'package:marketplace/widgets/bottom_nav_bar.dart';
import 'package:marketplace/widgets/top_app_bar.dart';
import 'package:provider/provider.dart';

class ListingDetailsScreen extends StatelessWidget {
  final Listing listing;

  const ListingDetailsScreen({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    final listingsProvider = Provider.of<ListingsProvider>(context);

    return Scaffold(
      appBar: const TopAppBar(
        title: 'Details',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: listing.imagePath == null
                    ? const SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: Center(child: Text('No image')),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: File(listing.imagePath!).existsSync()
                            ? Image.file(
                                File(listing.imagePath!),
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.fitHeight,
                              )
                            : Image.asset(
                                listing.imagePath!,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.fitHeight,
                              ),
                      ),
              ),
              Text(
                listing.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Price: ${listing.price} €',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Condition: ${listing.condition.toString().split('.').last}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Basic information:',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Brand: ${listing.brand}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'Model: ${listing.model}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Year: ${listing.manufactureYear}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'Fuel Type: ${listing.fuelType.toString().split('.').last}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Body Style: ${listing.bodyStyle.toString().split('.').last}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'Colour: ${listing.colour}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Mileage: ${listing.mileage} km',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'Emissions: ${listing.emissionStandard.toString().split('.').last}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (listing.description.isNotEmpty) ...[
                Text(
                  'More about the vehicle:',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  '\t\t${listing.description}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              AddEditScreen(listing: listing)));
                    },
                    child: const Text('Edit'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text("Delete confirmation"),
                                content: const Text(
                                    "Are you sure you want to delete this listing?"),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, "Cancel"),
                                      child: const Text("Cancel")),
                                  TextButton(
                                      onPressed: () => {
                                            Navigator.pop(context, "Delete"),
                                            listingsProvider.deleteListing(
                                                listing.listingId),
                                            Navigator.of(context).pop()
                                          },
                                      child: const Text("Delete")),
                                ],
                              ));
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
