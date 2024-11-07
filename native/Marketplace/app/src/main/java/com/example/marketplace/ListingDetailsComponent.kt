package com.example.marketplace

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
//noinspection UsingMaterialAndMaterial3Libraries
import androidx.compose.material.AlertDialog
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import coil.compose.AsyncImage
import com.example.marketplace.constants.Colors
import com.example.marketplace.view_models.ListingViewModel

@Composable
fun ListingDetailsComponent(
    listingId: Int?,
    viewModel: ListingViewModel,
    modifier: Modifier,
    navController: NavController
) {
    val deleteDialogOpened = remember { mutableStateOf(false) }

    if (listingId == null) {
        return
    }

    val listing = viewModel.getListing(listingId) ?: return

    val scrollState = rememberScrollState()

    Column(
        modifier = modifier
            .verticalScroll(scrollState)
            .padding(10.dp)
    ) {
        when {
            deleteDialogOpened.value -> {
                AlertDialog(
                    title = {
                        Text("Delete confirmation")
                    },
                    text = {
                        Text("Are you sure you want to delete this listing?")
                    },
                    onDismissRequest = {
                        deleteDialogOpened.value = false
                    },
                    confirmButton = {
                        Button(
                            colors = ButtonDefaults.buttonColors(Colors.red),
                            onClick = {
                                deleteDialogOpened.value = false
                                navController.navigate("listings_list")
                                viewModel.deleteListing(listingId)
                            }
                        ) {
                            Text("Delete")
                        }
                    },
                    dismissButton = {
                        Button(
                            onClick = {
                                deleteDialogOpened.value = false
                            }
                        ) {
                            Text("Cancel")
                        }
                    }
                )
            }
        }

        Card(
            modifier = Modifier
                .fillMaxWidth()
                .height(150.dp),
        ) {
            Box(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(16.dp)
            ) {
                if (listing.imageUri == null) {
                    Text(
                        text = "No image",
                        modifier = Modifier.align(Alignment.Center),
                        style = MaterialTheme.typography.headlineMedium
                    )
                }
                else {
                    AsyncImage(
                        model = listing.imageUri,
                        contentDescription = null,
                        modifier = Modifier
                            .align(Alignment.Center)
                            .fillMaxWidth()
                            .padding(4.dp)
                            .clip(RoundedCornerShape(12.dp)),
                        contentScale = ContentScale.Fit,
                    )
                }
            }
        }

        Spacer(modifier = Modifier.height(8.dp))

        // Title
        Text(
            text = listing.title,
            style = MaterialTheme.typography.headlineMedium,
            fontWeight = FontWeight.Bold
        )

        Spacer(modifier = Modifier.height(8.dp))

        Row(
            modifier = Modifier
                .fillMaxWidth(),
            horizontalArrangement = Arrangement.End
        ) {
            Column {
                // Price
                Text(
                    text = "Price: ${listing.price} €",
                    style = MaterialTheme.typography.bodyLarge,
                    fontWeight = FontWeight.Bold
                )

                Spacer(modifier = Modifier.height(8.dp))

                // Condition
                Text(
                    text = "Condition: ${listing.condition}",
                    style = MaterialTheme.typography.bodyLarge,
                    fontWeight = FontWeight.Bold
                )
            }

        }

        Spacer(modifier = Modifier.height(20.dp))

        Text(
            text = "Basic information:",
            style = MaterialTheme.typography.bodyLarge,
            fontWeight = FontWeight.Bold
        )

        Spacer(modifier = Modifier.height(10.dp))

        Card(
            modifier = Modifier
                .fillMaxWidth()
        ) {
            Column(
                modifier = Modifier
                    .padding(10.dp)
            ) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    // Brand, Model
                    Text(
                        text = "Brand: ${listing.brand}",
                        style = MaterialTheme.typography.bodyLarge
                    )
                    Text(
                        text = "Model: ${listing.model}",
                        style = MaterialTheme.typography.bodyLarge
                    )
                }

                Spacer(modifier = Modifier.height(8.dp))

                Row(
                    modifier = Modifier
                        .fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    // Year and fuel type
                    Text(
                        text = "Year: ${listing.manufactureYear}",
                        style = MaterialTheme.typography.bodyLarge
                    )
                    Text(
                        text = "Fuel Type: ${listing.fuelType}",
                        style = MaterialTheme.typography.bodyLarge
                    )
                }

                Spacer(modifier = Modifier.height(8.dp))

                Row(
                    modifier = Modifier
                        .fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    // Body style and colour
                    Text(
                        text = "Body Style: ${listing.bodyStyle}",
                        style = MaterialTheme.typography.bodyLarge
                    )
                    Text(
                        text = "Colour: ${listing.colour}",
                        style = MaterialTheme.typography.bodyLarge
                    )
                }

                Spacer(modifier = Modifier.height(8.dp))

                Row(
                    modifier = Modifier
                        .fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    // Mileage and emission standard
                    Text(
                        text = "Mileage: ${listing.mileage} km",
                        style = MaterialTheme.typography.bodyLarge
                    )
                    Text(
                        text = "Emissions: ${listing.emissionStandard}",
                        style = MaterialTheme.typography.bodyLarge
                    )
                }
            }
        }

        Spacer(modifier = Modifier.height(20.dp))

        // Description
        Text(
            text = "More about the vehicle:",
            style = MaterialTheme.typography.bodyLarge,
            fontWeight = FontWeight.Bold
        )

        Spacer(modifier = Modifier.height(10.dp))

        Text(text = "\t\t" + listing.description, style = MaterialTheme.typography.bodyLarge)

        Spacer(modifier = Modifier.height(20.dp))

        Row(
            modifier = Modifier
                .fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceEvenly
        ) {
            Button(
                colors = ButtonDefaults.buttonColors(Colors.mediumGray),
                onClick = {
                    navController.navigate("edit_listing/$listingId")
                }
            ) {
                Text("Edit")
            }

            Button(
                colors = ButtonDefaults.buttonColors(Colors.red),
                onClick = {
                    deleteDialogOpened.value = true
                }
            ) {
                Text("Delete")
            }
        }
    }
}