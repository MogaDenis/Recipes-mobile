import 'dart:io';

import 'package:flutter/material.dart';
import 'package:marketplace/models/listing.dart';

class ListingListItem extends StatefulWidget {
  final Listing listing;

  const ListingListItem({super.key, required this.listing});

  @override
  State<ListingListItem> createState() => _ListingListItemState();
}

class _ListingListItemState extends State<ListingListItem> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                    if (widget.listing.imagePath == null)
                      const Text('No image')
                    else if (File(widget.listing.imagePath!).existsSync())
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(widget.listing.imagePath!),
                          height: 120,
                          width: 160,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    else
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          widget.listing.imagePath!,
                          height: 120,
                          width: 160,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.listing.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text("${widget.listing.brand} ${widget.listing.model}"),
                        const SizedBox(height: 5),
                        Text("Fuel: ${widget.listing.fuelTypeToString}"),
                        const SizedBox(height: 5),
                        Text("Fuel: ${widget.listing.bodyStyleToString}"),
                        const SizedBox(height: 5),
                        Text("Mileage: ${widget.listing.mileage} km"),
                        const SizedBox(height: 5),
                        Text("Price ${widget.listing.price} €"),
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
