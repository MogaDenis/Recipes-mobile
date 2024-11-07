package com.example.marketplace.models

import android.net.Uri
import com.example.marketplace.enums.BodyStyle
import com.example.marketplace.enums.Condition
import com.example.marketplace.enums.EmissionStandard
import com.example.marketplace.enums.FuelType
import java.util.Date

data class Listing (
    var listingId: Int = 0,
    var title: String = "",
    var description: String = "",
    var price: Int = 0,
    var condition: Condition = Condition.New,
    var brand: String = "",
    var model: String = "",
    var fuelType: FuelType = FuelType.Diesel,
    var bodyStyle: BodyStyle = BodyStyle.Sedan,
    var colour: String = "",
    var manufactureYear: Int = 2000,
    var mileage: Int = 0,
    var emissionStandard: EmissionStandard = EmissionStandard.Non_euro,
    var sellerId: Int = 0,
    var sellerName: String = "",
    var country: String = "",
    var city: String = "",
    var createdAt: Date = Date(),
    var imageUri: Uri? = null
) {
    fun replaceListingData(listing: Listing) {
        this.title = listing.title
        this.description = listing.description
        this.price = listing.price
        this.condition = listing.condition
        this.brand = listing.brand
        this.model = listing.model
        this.fuelType = listing.fuelType
        this.bodyStyle = listing.bodyStyle
        this.colour = listing.colour
        this.manufactureYear = listing.manufactureYear
        this.mileage = listing.mileage
        this.emissionStandard = listing.emissionStandard
        this.imageUri = listing.imageUri
    }

    fun isValidListing(): Boolean {
        if (title.isEmpty()) return false
        if (price == 0) return false
        if (brand.isEmpty()) return false
        if (model.isEmpty()) return false
        if (mileage == 0) return false

        return true
    }
}