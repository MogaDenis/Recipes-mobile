package com.example.marketplace.ui.theme

import android.os.Build
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.dynamicDarkColorScheme
import androidx.compose.material3.dynamicLightColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.platform.LocalContext
import com.example.marketplace.constants.Colors

private val DarkColorScheme = darkColorScheme(
    primary = Purple80,
    secondary = PurpleGrey80,
    tertiary = Pink80
)

private val LightColorScheme = lightColorScheme(
    primary = Colors.darkGray,            // Dark Gray for key buttons or app bars
    onPrimary = Colors.white,           // White for text/icons on primary areas
    primaryContainer = Colors.lightGray,    // Light Gray for backgrounds of primary elements (e.g., cards)
    onPrimaryContainer = Colors.darkGray,  // Dark Gray text/icons on primaryContainer

    secondary = Colors.mediumGray,           // Medium Gray for secondary buttons or icons
    onSecondary = Colors.white,         // White text/icons on secondary elements
    secondaryContainer = Colors.extraLightGray,  // Lighter Gray for secondary backgrounds (like text fields)
    onSecondaryContainer = Colors.darkGray,// Dark Gray text/icons on secondaryContainer

    background = Colors.white,          // Light Gray for the app’s general background
    onBackground = Colors.darkGray,        // Dark Gray for text on the background

    surface = Colors.white,             // White for card backgrounds or surfaces
    onSurface = Colors.darkGray,           // Dark Gray for text/icons on surfaces

    surfaceVariant = Colors.extraLightGray,      // Light Gray variant for surface backgrounds
    onSurfaceVariant = Colors.darkGray,    // Dark Gray text on surfaceVariant

    error = Colors.red,               // Red for error messages
    onError = Colors.white,             // White for text/icons on error surfaces
    errorContainer = Colors.lightRed,      // Light Red for error backgrounds
    onErrorContainer = Colors.red,    // Dark Red for text on errorContainer

    outline = Colors.lightGray,             // Light Gray for borders or outlines
    surfaceTint = Colors.darkGray
)

@Composable
fun MarketplaceTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    // Dynamic color is available on Android 12+
    dynamicColor: Boolean = true,
    content: @Composable () -> Unit
) {
    val colorScheme = when {
        dynamicColor && Build.VERSION.SDK_INT >= Build.VERSION_CODES.S -> {
            val context = LocalContext.current
            if (darkTheme) dynamicDarkColorScheme(context) else dynamicLightColorScheme(context)
        }

        darkTheme -> DarkColorScheme
        else -> LightColorScheme
    }

    MaterialTheme(
        colorScheme = colorScheme,
        typography = Typography,
        content = content
    )
}