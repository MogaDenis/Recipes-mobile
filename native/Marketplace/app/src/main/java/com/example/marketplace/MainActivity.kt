package com.example.marketplace

import android.annotation.SuppressLint
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
//noinspection UsingMaterialAndMaterial3Libraries
import androidx.compose.material.IconButton
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.marketplace.models.Listing
import com.example.marketplace.ui.theme.MarketplaceTheme
import com.example.marketplace.view_models.ListingViewModel

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        enableEdgeToEdge()
        super.onCreate(savedInstanceState)
        setContent {
            MarketplaceTheme(darkTheme = false, dynamicColor = false) {
                MarketplaceApp()
            }
        }
    }
}

@SuppressLint("UnusedMaterial3ScaffoldPaddingParameter")
@Composable
fun MarketplaceApp() {
    val navController = rememberNavController()
    val listingViewModel = ListingViewModel()

    Scaffold(
        bottomBar = {
            MarketplaceBottomAppBar(navController)
        }
    ) { paddingValues ->
        NavHost(navController = navController, startDestination = "listing_list") {
            composable("listing_list") {
                ListingsListComponent(
                    viewModel = listingViewModel,
                    modifier = Modifier.padding(paddingValues)
                )
            }
            composable("add_listing") {
                AddListingComponent(
                    viewModel = listingViewModel,
                    modifier = Modifier.padding(paddingValues),
                    onListingAdded = { navController.popBackStack() }
                )
            }
        }
    }
}

@Composable
fun ListingListItem(listing: Listing, onDelete: () -> Unit) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(8.dp),
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        Column {
            Text(text = listing.title, style = MaterialTheme.typography.bodyLarge)
            Text(text = listing.description, style = MaterialTheme.typography.bodySmall)
        }
        IconButton(onClick = onDelete) {
            Icon(imageVector = Icons.Default.Delete, contentDescription = "Delete Listing")
        }
    }
}



