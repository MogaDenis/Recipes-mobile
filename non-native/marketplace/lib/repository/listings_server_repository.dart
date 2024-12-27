import 'dart:convert';

import 'package:marketplace/models/listing.dart';
import 'package:marketplace/repository/listings_repository.dart';
import 'package:http/http.dart' as http;

class ListingsServerRepository extends ListingsRepository {
  final baseURI = "http://192.168.1.135:5293/api/Listings";

  @override
  Future<List<Listing>> loadListings() async {
    final response = await http.get(Uri.parse(baseURI));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);

      return jsonData.map((data) => Listing.fromJson(data)).toList();
    } else {
      throw Exception("Failed to load listings!");
    }
  }

  @override
  Future<int> addListing(Listing listing) async {
    final response = await http.post(Uri.parse(baseURI),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(listing.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to add listing!");
    }

    dynamic jsonData = jsonDecode(response.body);
    return jsonData['listingId'];
  }

  @override
  Future<void> updateListing(Listing listing) async {
    final response = await http.put(Uri.parse("$baseURI/${listing.listingId}"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(listing.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to update listing!");
    }
  }

  @override
  Future<void> deleteListing(int listingId) async {
    final response = await http.delete(Uri.parse("$baseURI/$listingId"));

    if (response.statusCode != 200) {
      throw Exception("Failed to remove listing!");
    }
  }
}
