package com.example.marketplace

import android.annotation.SuppressLint
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
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
        NavHost(navController = navController, startDestination = "listings_list") {
            composable("listings_list") {
                ListingsListComponent(
                    viewModel = listingViewModel,
                    modifier = Modifier.padding(paddingValues),
                    navController = navController
                )
            }

            composable("add_listing") {
                AddListingComponent(
                    viewModel = listingViewModel,
                    modifier = Modifier.padding(paddingValues),
                    navController = navController
                )
            }

            composable("edit_listing/{listingId}") { backStackEntry ->
                val listingId = backStackEntry.arguments?.getString("listingId")?.toIntOrNull()

                EditListingComponent(
                    listingId = listingId,
                    viewModel = listingViewModel,
                    modifier = Modifier.padding(paddingValues),
                    navController = navController
                )
            }

            composable("listing_details/{listingId}") { backStackEntry ->
                val listingId = backStackEntry.arguments?.getString("listingId")?.toIntOrNull()

                ListingDetailsComponent(
                    listingId = listingId,
                    viewModel = listingViewModel,
                    modifier = Modifier.padding(paddingValues),
                    navController = navController
                )
            }
        }
    }
}





