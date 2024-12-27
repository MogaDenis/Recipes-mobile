import 'package:marketplace/models/listing.dart';

abstract class ListingsRepository {
  Future<List<Listing>> loadListings();
  Future<void> addListing(Listing listing);
  Future<void> updateListing(Listing listing);
  Future<void> deleteListing(int listingId);
}
