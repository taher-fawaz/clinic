part of 'app_res.dart';

/// Color Manager - Refactored to use Figma design colors
/// This class provides access to the app's color palette extracted from Figma
abstract class ColorManager {
  // Primary Brand Colors - From Figma Design
  static Color primary = HexColor.fromHex("#3787FF"); // Primary blue from Figma
  static Color primaryDark = HexColor.fromHex("#2563EB"); // Darker variant
  static Color primaryLight = HexColor.fromHex("#60A5FA"); // Lighter variant
  
  // Secondary Colors
  static Color secondary = HexColor.fromHex("#10B981"); // Green accent
  static Color secondaryDark = HexColor.fromHex("#059669");
  static Color secondaryLight = HexColor.fromHex("#34D399");
  
  // Background Colors - From Figma Design
  static Color backgroundPrimary = HexColor.fromHex("#FFFFFF"); // Pure white
  static Color backgroundSecondary = HexColor.fromHex("#E4F1F8"); // Light blue from Figma
  static Color backgroundTertiary = HexColor.fromHex("#F8FAFC"); // Very light grey
  
  // Surface Colors
  static Color surface = HexColor.fromHex("#FFFFFF"); // Card/surface background
  static Color surfaceVariant = HexColor.fromHex("#F1F5F9"); // Alternative surface
  static Color surfaceContainer = HexColor.fromHex("#E2E8F0"); // Container background
  
  // Text Colors - From Figma Design
  static Color textPrimary = HexColor.fromHex("#060302"); // Main text from Figma
  static Color textSecondary = HexColor.fromHex("#767372"); // Secondary text from Figma
  static Color textTertiary = HexColor.fromHex("#94A3B8"); // Tertiary/hint text
  static Color textOnPrimary = HexColor.fromHex("#FFFFFF"); // Text on primary color
  
  // On-Color Text (for text on colored backgrounds)
  static Color onPrimary = HexColor.fromHex("#FFFFFF"); // Text on primary background
  static Color onSecondary = HexColor.fromHex("#FFFFFF"); // Text on secondary background
  static Color onSurface = HexColor.fromHex("#060302"); // Text on surface background
  static Color onSuccess = HexColor.fromHex("#FFFFFF"); // Text on success background
  static Color onWarning = HexColor.fromHex("#FFFFFF"); // Text on warning background
  static Color onError = HexColor.fromHex("#FFFFFF"); // Text on error background
  
  // Semantic Colors
  static Color success = HexColor.fromHex("#10B981"); // Success/positive actions
  static Color warning = HexColor.fromHex("#F59E0B"); // Warning states
  static Color error = HexColor.fromHex("#EF4444"); // Error/danger states
  static Color info = HexColor.fromHex("#3787FF"); // Information states (using primary)
  
  // Onboarding Colors - Updated to use Figma colors
  static Color onboardingPrimary = HexColor.fromHex("#3787FF"); // Use primary blue
  static Color onboardingSecondary = HexColor.fromHex("#10B981"); // Use secondary green
  static Color onboardingAccent = HexColor.fromHex("#F59E0B"); // Orange accent for highlights
  
  // Neutral Colors
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color black = HexColor.fromHex("#000000");
  static Color grey = HexColor.fromHex("#6B7280"); // Standard grey
  static Color greyLight = HexColor.fromHex("#D1D5DB"); // Light grey
  static Color greyDark = HexColor.fromHex("#374151"); // Dark grey
  
  // Border Colors
  static Color border = HexColor.fromHex("#E5E7EB"); // Default border
  static Color borderFocus = HexColor.fromHex("#3787FF"); // Focused border (using primary)
  static Color borderError = HexColor.fromHex("#EF4444"); // Error border
  
  // Shadow Colors
  static Color shadowColor = HexColor.fromHex("#00000010"); // Light shadow
  static Color shadowDark = HexColor.fromHex("#00000020"); // Darker shadow
  
  // Gradients - Updated to use Figma colors
  static LinearGradient primaryGradient = LinearGradient(
    colors: [HexColor.fromHex("#3787FF"), HexColor.fromHex("#2563EB")],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static LinearGradient secondaryGradient = LinearGradient(
    colors: [HexColor.fromHex("#10B981"), HexColor.fromHex("#059669")],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static LinearGradient backgroundGradient = LinearGradient(
    colors: [HexColor.fromHex("#E4F1F8"), HexColor.fromHex("#F8FAFC")],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Essential legacy colors (minimal set for backward compatibility)
  static Color darkPrimary = primaryDark; // Alias to new primary dark
  static Color secondry = secondary; // Keep typo for compatibility, point to new secondary
  static Color lightBlue = primary; // Alias to new primary
  static Color redColor = error; // Alias to error color
  static Color green = success; // Alias to success color
  static Color yellow = warning; // Alias to warning color
  
  // Essential legacy gradients
  static LinearGradient linearBlackTop = LinearGradient(
    colors: [Colors.black.withOpacity(0.5), Colors.transparent],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Legacy text colors (aliases to new system)
  static Color greyTextColor = textSecondary; // Alias to new secondary text
  static Color blackText = textPrimary; // Alias to new primary text
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
