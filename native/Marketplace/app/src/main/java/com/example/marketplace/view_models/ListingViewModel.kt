package com.example.marketplace.view_models

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.marketplace.models.Listing
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

class ListingViewModel : ViewModel() {
    private val _listings = MutableStateFlow<List<Listing>>(emptyList())
    val listings = _listings.asStateFlow()

    private var nextId = 1

    fun addListing(listing: Listing) {
        val newListing = listing.copy(listingId = nextId++)
        _listings.value += newListing
    }

    fun deleteListing(listingId: Int) {
        _listings.value = _listings.value.filter { it.listingId != listingId }
    }
}