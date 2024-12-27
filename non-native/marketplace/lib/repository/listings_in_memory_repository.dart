import 'dart:convert';

import 'package:marketplace/models/listing.dart';
import 'package:marketplace/repository/listings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListingInMemoryRepository extends ListingsRepository {
  final List<Listing> _listings = [];
  int _nextId = 0;

  @override
  Future<List<Listing>> loadListings() async {
    final preferences = await SharedPreferences.getInstance();
    final String? savedListings = preferences.getString('listings');

    if (savedListings != null) {
      final List<dynamic> decodedListings = jsonDecode(savedListings);

      final listings = decodedListings.map((e) => Listing.fromJson(e)).toList();

      int maxId = 0;
      for (final listing in _listings) {
        if (listing.listingId > maxId) {
          maxId = listing.listingId;
        }
      }
      _nextId = maxId + 1;

      return listings;
    }

    return [];
  }

  Future<void> _saveListings() async {
    final preferences = await SharedPreferences.getInstance();
    final String encodedListings =
        jsonEncode(_listings.map((listing) => listing.toJson()).toList());

    preferences.setString('listings', encodedListings);
  }

  @override
  Future<int> addListing(Listing listing) async {
    listing.listingId = _nextId;
    _listings.insert(0, listing);

    _saveListings();

    return _nextId++;
  }

  @override
  Future<void> updateListing(Listing listing) async {
    final index = _listings.indexWhere((e) => e.listingId == listing.listingId);
    if (index != -1) {
      _listings[index] = listing;

      _saveListings();
    }
  }

  @override
  Future<void> deleteListing(int listingId) async {
    _listings.removeWhere((element) => element.listingId == listingId);

    _saveListings();
  }
}
