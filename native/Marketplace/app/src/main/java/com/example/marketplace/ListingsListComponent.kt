package com.example.marketplace

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.rememberLazyListState
//noinspection UsingMaterialAndMaterial3Libraries
import androidx.compose.material.AlertDialog
//noinspection UsingMaterialAndMaterial3Libraries
import androidx.compose.material.Divider
//noinspection UsingMaterialAndMaterial3Libraries
import androidx.compose.material.TextButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import com.example.marketplace.view_models.ListingViewModel

@Composable
fun ListingsListComponent(viewModel: ListingViewModel, modifier: Modifier) {
    val listings by viewModel.listings.collectAsState(initial = emptyList())
    val listState = rememberLazyListState()
    val deleteDialogOpened = remember { mutableStateOf(false) }
    val listingId = remember { mutableIntStateOf(-1) }

    Column(modifier = modifier) {
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
                        TextButton(
                            onClick = {
                                viewModel.deleteListing(listingId.intValue)
                                listingId.intValue = -1
                                deleteDialogOpened.value = false
                            }
                        ) {
                            Text("Delete")
                        }
                    },
                    dismissButton = {
                        TextButton(
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

        LazyColumn(
            state = listState,
            reverseLayout = true
        ) {
            items(listings.count()) { index ->
                ListingListItem(
                    listing = listings[index],
                    onDelete = {
                        listingId.intValue = listings[index].listingId
                        deleteDialogOpened.value = true
                    }
                )
                Divider()
            }
        }
    }

    LaunchedEffect(listings) {
        if (listings.isNotEmpty()) {
            listState.scrollToItem(0)
        }
    }
}