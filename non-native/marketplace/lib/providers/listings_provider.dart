import 'package:flutter/material.dart';
import 'package:marketplace/models/listing.dart';
import 'package:marketplace/repository/listings_repository.dart';

class ListingsProvider with ChangeNotifier {
  final _listingRepository = ListingRepository();

  List<Listing> get listings => [..._listingRepository.listings];

  Future<void> init() async {
    await _listingRepository.loadListings();
  }

  void addListing(Listing listing) {
    _listingRepository.addListing(listing);
    notifyListeners();
  }

  void updateListing(Listing listing) {
    _listingRepository.updateListing(listing);
    notifyListeners();
  }

  void deleteListing(int listingId) {
    _listingRepository.deleteListing(listingId);
    notifyListeners();
  }
}
