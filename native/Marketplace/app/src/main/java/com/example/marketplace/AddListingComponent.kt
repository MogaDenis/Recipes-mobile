package com.example.marketplace

import android.net.Uri
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
//noinspection UsingMaterialAndMaterial3Libraries
import androidx.compose.material.AlertDialog
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import coil.compose.AsyncImage
import com.example.marketplace.constants.CarData
import com.example.marketplace.constants.Colors
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
    navController: NavController
) {
    val attemptedSubmit = remember { mutableStateOf(false) }
    val validationErrorDialogOpened = remember { mutableStateOf(false) }
    val discardChangesDialogOpened = remember { mutableStateOf(false) }
    var imageUri by remember { mutableStateOf<Uri?>(null) }

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

    val defaultModifier: Modifier = Modifier
        .fillMaxWidth()
        .padding(8.dp)

    val launcher = rememberLauncherForActivityResult(
        contract = ActivityResultContracts.GetContent(),
        onResult = { uri: Uri? ->
            imageUri = uri
        }
    )

    Column(
        modifier = modifier
            .verticalScroll(scrollState)
    ) {
        Text(
            modifier = defaultModifier,
            text = "Create a new listing",
            style = MaterialTheme.typography.headlineMedium,
            fontWeight = FontWeight.Bold
        )

        when {
            validationErrorDialogOpened.value -> {
                AlertDialog(
                    text = {
                        Text("Please provide all required fields.")
                    },
                    onDismissRequest = {
                        validationErrorDialogOpened.value = false
                    },
                    confirmButton = {
                        Button(
                            onClick = {
                                validationErrorDialogOpened.value = false
                            }
                        ) {
                            Text("Dismiss")
                        }
                    }
                )
            }
        }

        when {
            discardChangesDialogOpened.value -> {
                AlertDialog(
                    title = {
                        Text("Discard changes?")
                    },
                    text = {
                        Text("Your changes will be lost.")
                    },
                    onDismissRequest = {
                        discardChangesDialogOpened.value = false
                    },
                    confirmButton = {
                        Button(
                            colors = ButtonDefaults.buttonColors(Colors.red),
                            onClick = {
                                discardChangesDialogOpened.value = false

                                navController.navigate("listings_list")
                            }
                        ) {
                            Text("Discard")
                        }
                    },
                    dismissButton = {
                        Button(
                            colors = ButtonDefaults.buttonColors(Colors.mediumGray),
                            onClick = {
                                discardChangesDialogOpened.value = false
                            }
                        ) {
                            Text("Cancel")
                        }
                    }
                )
            }
        }

        Card(
            modifier = defaultModifier
                .height(150.dp),
        ) {
            Box(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(16.dp)
            ) {
                if (imageUri == null) {
                    Button(
                        modifier = Modifier.align(Alignment.Center),
                        onClick = { launcher.launch("image/*") }
                    ) {
                        Text("Choose image")
                    }
                }
                else {
                    AsyncImage(
                        model = imageUri,
                        contentDescription = null,
                        modifier = Modifier
                            .fillMaxHeight()
                            .align(Alignment.Center)
                            .padding(4.dp)
                            .clip(RoundedCornerShape(12.dp))
                            .clickable(
                                onClick = {
                                    launcher.launch("image/*")
                                }
                            ),
                        contentScale = ContentScale.Fit,
                    )
                }
            }
        }

        Spacer(modifier = Modifier.height(8.dp))

        // Title
        OutlinedTextField(
            value = title,
            onValueChange = { title = it },
            modifier = defaultModifier,
            label = {
                Text("Title")
            },
            isError = title.isEmpty() && attemptedSubmit.value
        )

        Spacer(modifier = Modifier.height(8.dp))

        // Brand
        DropdownMenuComponent(
            value = brand,
            options = CarData.CarBrands,
            onChange = {
                newBrand -> run {
                    brand = newBrand
                    model = ""
                }
            },
            label = "Brand",
            textFieldModifier = defaultModifier,
            isError = brand.isEmpty() && attemptedSubmit.value
        )

        Spacer(modifier = Modifier.height(8.dp))

        // Model
        DropdownMenuComponent(
            value = model,
            options = if (!CarData.CarModels.containsKey(brand)) listOf() else CarData.CarModels[brand]!!,
            onChange = { newModel -> model = newModel },
            label = "Model",
            textFieldModifier = defaultModifier,
            isError = model.isEmpty() && attemptedSubmit.value
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
                },
                isError = price == 0 && attemptedSubmit.value
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
                options = CarData.Colours,
                onChange = { newColour -> colour = newColour },
                label = "Colour",
                dropDownModifier = Modifier
                    .weight(0.5f)
                    .padding(8.dp),
                isError = colour.isEmpty() && attemptedSubmit.value
            )

            DropdownMenuComponent(
                value = manufactureYear,
                options = CarData.YearsList,
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
                },
                isError = mileage == 0 && attemptedSubmit.value
            )

            DropdownMenuComponent(
                value = emissionStandard,
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
            modifier = defaultModifier
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
                colors = ButtonDefaults.buttonColors(containerColor = Colors.red),
                onClick = {
                    discardChangesDialogOpened.value = true
                }
            ) {
                Text("Discard")
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
                        emissionStandard = EmissionStandard.valueOf(emissionStandard),
                        imageUri = imageUri
                    )

                    if (!newListing.isValidListing()) {
                        attemptedSubmit.value = true
                        validationErrorDialogOpened.value = true
                    }
                    else {
                        viewModel.addListing(newListing)

                        navController.navigate("listings_list")
                    }

                }
            ) {
                Text("Post listing")
            }
        }
    }
}