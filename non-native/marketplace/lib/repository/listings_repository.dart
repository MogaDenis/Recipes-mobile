import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marketplace/models/listing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListingRepository with ChangeNotifier {
  final List<Listing> _listings = [];

  List<Listing> get listings => _listings;
  int nextId = 0;

  Future<void> loadListings() async {
    final preferences = await SharedPreferences.getInstance();
    final String? savedListings = preferences.getString('listings');

    if (savedListings != null) {
      final List<dynamic> decodedListings = jsonDecode(savedListings);
      _listings.clear();

      _listings.addAll(decodedListings.map((e) => Listing.fromJson(e)));

      int maxId = 0;
      for (final listing in _listings) {
        if (listing.listingId > maxId) {
          maxId = listing.listingId;
        }
      }
      nextId = maxId + 1;
    }
  }

  Future<void> _saveListings() async {
    final preferences = await SharedPreferences.getInstance();
    final String encodedListings =
        jsonEncode(_listings.map((listing) => listing.toJson()).toList());

    preferences.setString('listings', encodedListings);
  }

  void addListing(Listing listing) {
    listing.listingId = nextId++;
    _listings.insert(0, listing);

    _saveListings();
  }

  void updateListing(Listing listing) {
    final index = _listings.indexWhere((e) => e.listingId == listing.listingId);
    if (index != -1) {
      _listings[index] = listing;

      _saveListings();
    }
  }

  void deleteListing(int listingId) {
    _listings.removeWhere((element) => element.listingId == listingId);

    _saveListings();
  }
}
