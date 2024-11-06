package com.example.marketplace.models

import com.example.marketplace.enums.BodyStyle
import com.example.marketplace.enums.Condition
import com.example.marketplace.enums.EmissionStandard
import com.example.marketplace.enums.FuelType
import java.util.Date

data class Listing (
    var listingId: Int = 0,
    var title: String = "",
    var description: String = "",
    var price: Int = 1,
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
    var createdAt: Date = Date()
)