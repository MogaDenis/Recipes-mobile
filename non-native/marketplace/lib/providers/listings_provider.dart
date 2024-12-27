import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marketplace/models/listing.dart';
import 'package:marketplace/repository/listings_repository.dart';
import 'package:marketplace/repository/listings_server_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ListingsProvider with ChangeNotifier {
  late ListingsRepository _listingRepository;
  List<Listing> listings = [];

  ListingsProvider(ListingsRepository repository) {
    _listingRepository = repository;
  }

  Future<void> init() async {
    listings = await _listingRepository.loadListings();

    if (_listingRepository is ListingsServerRepository) {
      _connectToWebSocket();
    }
  }

  void _connectToWebSocket() {
    final channel =
        WebSocketChannel.connect(Uri.parse('ws://192.168.1.135:5293/ws'));

    channel.stream.listen((message) {
      final data = jsonDecode(message);

      print('RECEIVED:${data['Data']}');
      final action = data['Action'];
      final Listing listing = Listing.fromJson(data['Data']);

      switch (action) {
        case 'add':
          addListingAndNotify(listing);
          break;
        case 'update':
          updateListingAndNotify(listing);
          break;
        case 'delete':
          deleteListingAndNotify(listing.listingId);
          break;
      }
    });
  }

  Future<void> addListing(Listing listing) async {
    await _listingRepository.addListing(listing);
  }

  Future<void> updateListing(Listing listing) async {
    await _listingRepository.updateListing(listing);
  }

  Future<void> deleteListing(int listingId) async {
    await _listingRepository.deleteListing(listingId);
  }

  void addListingAndNotify(Listing listing) {
    listings.insert(0, listing);
    notifyListeners();
  }

  void updateListingAndNotify(Listing listing) {
    final index = listings.indexWhere((e) => e.listingId == listing.listingId);

    if (index != -1) {
      listings[index] = listing;
    }
    notifyListeners();
  }

  void deleteListingAndNotify(int listingId) {
    listings.removeWhere((element) => element.listingId == listingId);
    notifyListeners();
  }
}
