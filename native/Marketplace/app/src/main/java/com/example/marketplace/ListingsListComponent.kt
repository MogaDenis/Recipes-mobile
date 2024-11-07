package com.example.marketplace

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.example.marketplace.view_models.ListingViewModel

@Composable
fun ListingsListComponent(viewModel: ListingViewModel, modifier: Modifier, navController: NavController ) {
    val listings by viewModel.listings.collectAsState(initial = emptyList())
    val listState = rememberLazyListState()

    Column(
        modifier = modifier
            .padding(10.dp)
    ) {
        Text(
            text = "Your listings",
            style = MaterialTheme.typography.headlineMedium,
            fontWeight = FontWeight.Bold
        )

        Spacer(modifier = Modifier.height(10.dp))

        LazyColumn(
            state = listState,
            reverseLayout = true
        ) {
            items(listings.count()) { index ->
                ListingListItemComponent(
                    listing = listings[index],
                    navController = navController
                )
            }
        }
    }

    LaunchedEffect(listings) {
        if (listings.isNotEmpty()) {
            listState.scrollToItem(listings.size - 1)
        }
    }
}