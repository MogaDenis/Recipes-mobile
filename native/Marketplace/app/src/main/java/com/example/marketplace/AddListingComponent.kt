package com.example.marketplace

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Button
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import com.example.marketplace.enums.BodyStyle
import com.example.marketplace.enums.Condition
import com.example.marketplace.enums.EmissionStandard
import com.example.marketplace.enums.FuelType
import com.example.marketplace.models.Listing
import com.example.marketplace.view_models.ListingViewModel

@Composable
fun AddListingComponent(
    viewModel: ListingViewModel,
    modifier: Modifier,
    onListingAdded: () -> Unit
) {
    val scrollState = rememberScrollState()

    var title by remember { mutableStateOf("") }
    var description by remember { mutableStateOf("") }
    var price by remember { mutableIntStateOf(0) }
    var condition by remember { mutableStateOf(Condition.New.toString()) }
    var brand by remember { mutableStateOf("") }
    var model by remember { mutableStateOf("") }
    var fuelType by remember { mutableStateOf(FuelType.Diesel.toString()) }
    var bodyStyle by remember { mutableStateOf(BodyStyle.Sedan.toString()) }
    var colour by remember { mutableStateOf("") }
    var manufactureYear by remember { mutableIntStateOf(2000) }
    var mileage by remember { mutableIntStateOf(0) }
    var emissionStandard by remember { mutableStateOf(EmissionStandard.Non_euro.toString()) }

    val carBrands = listOf("Toyota", "Honda", "Ford", "BMW", "Mercedes", "Audi")

    val carModels = mapOf(
        "Audi" to listOf("A3", "A4", "A5", "A6"),
        "BMW" to listOf("1-series", "2-series", "3-series"),
        "" to listOf()
    )

    val colours = listOf("Black", "White", "Red", "Blue")
    val yearsList = (1980..2024).reversed().toList()

    val textFieldModifier: Modifier = Modifier
        .fillMaxWidth()
        .padding(8.dp)

    Column(
        modifier = modifier
            .verticalScroll(scrollState)
    ) {
        // Title
        OutlinedTextField(
            value = title,
            onValueChange = { title = it },
            modifier = textFieldModifier,
            label = {
                Text("Title")
            }
        )

        Spacer(modifier = Modifier.height(8.dp))

        // Brand
        DropdownMenuComponent(
            value = brand,
            options = carBrands,
            onChange = {
                newBrand -> run {
                    brand = newBrand
                    model = ""
                }
            },
            label = "Brand",
            textFieldModifier = textFieldModifier
        )

        Spacer(modifier = Modifier.height(8.dp))

        // Model
        DropdownMenuComponent(
            value = model,
            options = if (!carModels.containsKey(brand)) listOf() else carModels[brand]!!,
            onChange = { newModel -> model = newModel },
            label = "Model",
            textFieldModifier = textFieldModifier
        )

        Spacer(modifier = Modifier.height(8.dp))

        // Condition and price
        Row(
            modifier = Modifier
                .fillMaxWidth()
        ) {
            DropdownMenuComponent(
                value = condition,
                options = Condition.entries,
                onChange = { newCondition -> condition = newCondition.toString() },
                label = "Condition",
                dropDownModifier = Modifier
                    .weight(0.5f)
                    .padding(8.dp)
            )

            OutlinedTextField(
                value = if (price != 0) price.toString() else "",
                onValueChange = { price = it.toIntOrNull() ?: 0 },
                keyboardOptions = KeyboardOptions(
                    keyboardType = KeyboardType.Number
                ),
                modifier = Modifier
                    .weight(0.5f)
                    .padding(8.dp),
                label = {
                    Text("Price")
                }
            )
        }

        Spacer(modifier = Modifier.height(8.dp))

        // Body style and fuel type
        Row(
            modifier = Modifier
                .fillMaxWidth()
        ) {
            DropdownMenuComponent(
                value = bodyStyle,
                options = BodyStyle.entries,
                onChange = { newBodyStyle -> bodyStyle = newBodyStyle.toString() },
                label = "Body style",
                dropDownModifier = Modifier
                    .weight(0.5f)
                    .padding(8.dp)
            )

            DropdownMenuComponent(
                value = fuelType,
                options = FuelType.entries,
                onChange = { newFuelType -> fuelType = newFuelType.toString() },
                label = "Fuel type",
                dropDownModifier = Modifier
                    .weight(0.5f)
                    .padding(8.dp)
            )
        }

        Spacer(modifier = Modifier.height(16.dp))

        // Colour and manufacture year
        Row(
            modifier = Modifier
                .fillMaxWidth()
        ) {
            DropdownMenuComponent(
                value = colour,
                options = colours,
                onChange = { newColour -> colour = newColour.toString() },
                label = "Colour",
                dropDownModifier = Modifier
                    .weight(0.5f)
                    .padding(8.dp)
            )

            DropdownMenuComponent(
                value = manufactureYear,
                options = yearsList,
                onChange = { newManufactureYear -> manufactureYear = newManufactureYear },
                label = "Manufacture year",
                dropDownModifier = Modifier
                    .weight(0.5f)
                    .padding(8.dp)
            )
        }

        Spacer(modifier = Modifier.height(16.dp))

        // Mileage and emission standard
        Row(
            modifier = Modifier
                .fillMaxWidth()
        ) {
            OutlinedTextField(
                value = if (mileage != 0) mileage.toString() else "",
                onValueChange = { mileage = it.toIntOrNull() ?: 0 },
                keyboardOptions = KeyboardOptions(
                    keyboardType = KeyboardType.Number
                ),
                modifier = Modifier
                    .weight(0.5f)
                    .padding(8.dp),
                label = {
                    Text("Mileage")
                }
            )

            DropdownMenuComponent(
                value = emissionStandard.toString(),
                options = EmissionStandard.entries,
                onChange = { newEmissionStandard -> emissionStandard = newEmissionStandard.toString() },
                label = "Emission standard",
                dropDownModifier = Modifier
                    .weight(0.5f)
                    .padding(8.dp)
            )
        }

        Spacer(modifier = Modifier.height(16.dp))

        // Description
        OutlinedTextField(
            value = description,
            onValueChange = { description = it },
            modifier = textFieldModifier
                .height(100.dp),
            label = {
                Text("Description")
            }
        )

        Spacer(modifier = Modifier.height(16.dp))

        Row(
            modifier = modifier
                .fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceAround
        ) {
            Button(
                onClick = {

                }
            ) {
                Text("Preview listing")
            }

            Button(
                onClick = {
                    val newListing = Listing(
                        title = title,
                        description = description,
                        price = price,
                        condition = Condition.valueOf(condition),
                        brand = brand,
                        model = model,
                        fuelType = FuelType.valueOf(fuelType),
                        bodyStyle = BodyStyle.valueOf(bodyStyle),
                        colour = colour,
                        manufactureYear = manufactureYear,
                        mileage = mileage,
                        emissionStandard = EmissionStandard.valueOf(emissionStandard)
                    )

                    viewModel.addListing(newListing)

                    onListingAdded()
                }
            ) {
                Text("Post listing")
            }
        }
    }
}