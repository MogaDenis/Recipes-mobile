package com.example.marketplace.constants

object CarData {
    val CarBrands = listOf("Toyota", "Honda", "Ford", "BMW", "Mercedes-Benz", "Audi", "Seat").sorted()

    val CarModels = mapOf(
        "Toyota" to listOf("Yaris", "Supra", "Corolla", "Camry", "Prius", "C-HR").sorted(),
        "Honda" to listOf("Accord", "Civic", "CR-V").sorted(),
        "Ford" to listOf("Focus", "Mondeo", "EcoSport", "Kuga", "Fiesta", "Ka").sorted(),
        "BMW" to listOf("1-series", "2-series", "3-series").sorted(),
        "Mercedes-Benz" to listOf("C-klass", "A-klass", "E-klass", "S-klass").sorted(),
        "Audi" to listOf("A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "R8").sorted(),
        "Seat" to listOf("Exeo", "Leon", "Ibiza").sorted(),
        "" to listOf()
    )

    val Colours = listOf("Black", "White", "Red", "Blue", "Silver", "Green", "Yellow").sorted()

    val YearsList = (1980..2024).reversed().toList()
}