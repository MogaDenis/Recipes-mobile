package com.example.marketplace.view_models

import android.net.Uri
import androidx.lifecycle.ViewModel
import com.example.marketplace.R
import com.example.marketplace.enums.BodyStyle
import com.example.marketplace.enums.Condition
import com.example.marketplace.enums.EmissionStandard
import com.example.marketplace.enums.FuelType
import com.example.marketplace.models.Listing
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow

class ListingViewModel : ViewModel() {
    private val _listings = MutableStateFlow(listOf(
        Listing(
            listingId = 1,
            title = "I hate Prius",
            description = "The ugliest car after Fiat Multipla",
            price = 300,
            condition = Condition.Bad,
            brand = "Toyota",
            model = "Prius",
            fuelType = FuelType.Hybrid,
            bodyStyle = BodyStyle.Wagon,
            colour = "Black",
            manufactureYear = 2010,
            mileage = 150201,
            emissionStandard = EmissionStandard.Euro_5,
            imageUri = Uri.parse("android.resource://com.example.marketplace/${R.drawable.toyota_prius}")
        ),
        Listing(
            listingId = 2,
            title = "Selling Audi A4",
            description = "Good car, runs and drives, no low-ballers I know what I have",
            price = 2100,
            condition = Condition.Fair,
            brand = "Audi",
            model = "A4",
            fuelType = FuelType.Diesel,
            bodyStyle = BodyStyle.Sedan,
            colour = "Silver",
            manufactureYear = 2002,
            mileage = 315981,
            emissionStandard = EmissionStandard.Euro_3,
            imageUri = Uri.parse("android.resource://com.example.marketplace/${R.drawable.audi_a4}")
        ),
        Listing(
            listingId = 3,
            title = "Seat Exeo for sale",
            description = "Right hand drive, need to go ASAP, asking price or best offer",
            price = 3000,
            condition = Condition.Good,
            brand = "Seat",
            model = "Exeo",
            fuelType = FuelType.Diesel,
            bodyStyle = BodyStyle.Wagon,
            colour = "Blue",
            manufactureYear = 2010,
            mileage = 182950,
            emissionStandard = EmissionStandard.Euro_5,
            imageUri = Uri.parse("android.resource://com.example.marketplace/${R.drawable.seat_exeo}")
        ),
        Listing(
            listingId = 4,
            title = "BMW M3 G80",
            description = "Brand new car, high performance sedan",
            price = 88000,
            condition = Condition.New,
            brand = "BMW",
            model = "3-series",
            fuelType = FuelType.Petrol,
            bodyStyle = BodyStyle.Sedan,
            colour = "Blue",
            manufactureYear = 2023,
            mileage = 14,
            emissionStandard = EmissionStandard.Euro_6,
            imageUri = Uri.parse("android.resource://com.example.marketplace/${R.drawable.bmw_g80}")
        )
    ))
    val listings = _listings.asStateFlow()

    private var nextId = _listings.value.size + 1

    fun getListing(listingId: Int): Listing? {
        return _listings.value.find { it.listingId == listingId }
    }

    fun addListing(listing: Listing) {
        val newListing = listing.copy(listingId = nextId++)

        _listings.value += newListing
    }

    fun updateListing(listing: Listing) {
        val listingToUpdate = _listings.value.find { it.listingId == listing.listingId }
        listingToUpdate?.replaceListingData(listing)

        _listings.value = _listings.value
    }

    fun deleteListing(listingId: Int) {
        _listings.value = _listings.value.filter { it.listingId != listingId }
    }
}