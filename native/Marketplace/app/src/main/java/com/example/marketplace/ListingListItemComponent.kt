package com.example.marketplace

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Card
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import coil.compose.AsyncImage
import com.example.marketplace.models.Listing

@Composable
fun ListingListItemComponent(
    listing: Listing,
    navController: NavController
) {
    Card(
        modifier = Modifier
            .height(160.dp)
    ) {
        Row(
            modifier = Modifier
                .fillMaxSize()
                .padding(8.dp)
                .clickable(
                    onClick = {
                        navController.navigate("listing_details/${listing.listingId}")
                    }
                ),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Box(
                modifier = Modifier
                    .weight(0.5f)
                    .fillMaxHeight()
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
                            .fillMaxHeight()
                            .padding(4.dp)
                            .clip(RoundedCornerShape(12.dp)),
                        contentScale = ContentScale.Crop,
                    )
                }
            }


            Column(
                modifier = Modifier
                    .weight(0.5f),
                horizontalAlignment = Alignment.End
            ) {
                Text(
                    text = listing.title,
                    style = MaterialTheme.typography.bodyLarge,
                    fontWeight = FontWeight.Bold
                )

                Spacer(modifier = Modifier.height(5.dp))

                Text(
                    text = listing.brand + " " + listing.model,
                    style = MaterialTheme.typography.bodyMedium
                )

                Spacer(modifier = Modifier.height(5.dp))

                Text(
                    text = "Fuel: " + listing.fuelType,
                    style = MaterialTheme.typography.bodyMedium
                )

                Spacer(modifier = Modifier.height(5.dp))

                Text(
                    text = "Type: " + listing.bodyStyle,
                    style = MaterialTheme.typography.bodyMedium
                )

                Spacer(modifier = Modifier.height(5.dp))

                Text(
                    text = "Mileage: " + listing.mileage + " km",
                    style = MaterialTheme.typography.bodyMedium
                )

                Spacer(modifier = Modifier.height(5.dp))

                Text(
                    text = listing.price.toString() + " €",
                    style = MaterialTheme.typography.bodyLarge,
                    fontWeight = FontWeight.Bold
                )

            }
        }
    }

    Spacer(modifier = Modifier.height(20.dp))
}