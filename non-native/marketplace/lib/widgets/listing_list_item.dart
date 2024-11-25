import 'dart:io';

import 'package:flutter/material.dart';
import 'package:marketplace/models/listing.dart';
import 'package:marketplace/screens/listing_details_screen.dart';

class ListingListItem extends StatelessWidget {
  final Listing listing;

  const ListingListItem({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ListingDetailsScreen(listing: listing)));
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (listing.imagePath == null)
                      const Text('No image')
                    else if (File(listing.imagePath!).existsSync())
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(listing.imagePath!),
                          height: 120,
                          width: 160,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    else
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          listing.imagePath!,
                          height: 120,
                          width: 160,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          listing.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text("${listing.brand} ${listing.model}"),
                        const SizedBox(height: 5),
                        Text("Fuel: ${listing.fuelTypeToString}"),
                        const SizedBox(height: 5),
                        Text("Fuel: ${listing.bodyStyleToString}"),
                        const SizedBox(height: 5),
                        Text("Mileage: ${listing.mileage} km"),
                        const SizedBox(height: 5),
                        Text("Price ${listing.price} €"),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
