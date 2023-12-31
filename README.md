# flutter_pageview_with_indicator
**# Flutter Pagination Package**

**This package provides a reusable component for creating a multi-page onboarding or walkthrough experience in your Flutter app.**

**Key Features:**

- **Customizable Page View:** Displays a series of pages with smooth swiping navigation.
- **Step Indicator:** Visually represents the user's progress through the pages.
- **Skip and Finish Buttons:** Allows users to skip the walkthrough or complete it early.
- **Customizable Appearance:** Easily change the background color, button styles, and other visual elements.

**Installation:**

1. Add the package to your `pubspec.yaml` file:

   ```yaml
   dependencies:
     flutter_pagination: ^1.0.0
   ```

2. Run `flutter pub get` to install the package.

**Usage:**

1. Import the package:

   ```dart
   import 'package:flutter_pagination/flutter_pagination.dart';
   ```

2. Create a list of widgets to represent the pages:

   ```dart
   final pages = [
     Center(child: Text("Page 1")),
     Center(child: Text("Page 2")),
     Center(child: Text("Page 3")),
   ];
   ```

3. Wrap your app with the `Pagination` widget:

   ```dart
   runApp(Pagination(
     children: pages,
     backgroundColor: Colors.red,
     onFinished: () => print("Finished"),
     onSkip: () => print("Skipped"),
   ));
   ```

**Customization:**

- **backgroundColor:** Sets the background color of the pages.
- **pageController:** Allows you to control the page view programmatically.
- **onFinished:** Called when the user reaches the last page.
- **onSkip:** Called when the user taps the "Skip" button.

**Additional Notes:**

- The package currently supports a fixed number of pages.
- Consider adding error handling for cases where the user might try to navigate beyond the available pages.

