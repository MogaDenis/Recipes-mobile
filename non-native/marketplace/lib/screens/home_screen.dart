import 'package:flutter/material.dart';
import 'package:marketplace/widgets/bottom_nav_bar.dart';
import 'package:marketplace/widgets/listing_list_item.dart';
import 'package:marketplace/widgets/top_app_bar.dart';
import 'package:marketplace/providers/listings_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final listingsProvider = Provider.of<ListingsProvider>(context);

    return Scaffold(
        appBar: const TopAppBar(
          title: 'Marketplace',
        ),
        body: ListView.builder(
          itemCount: listingsProvider.listings.length,
          itemBuilder: (ctx, index) {
            final listing = listingsProvider.listings[index];

            return ListingListItem(listing: listing);
          },
        ),
        bottomNavigationBar: const BottomNavBar());
  }
}
