# MovieApp 🎬

This app fetches movie data from the OMDb API and presents a blurred movie poster to the user, who tries to guess the correct movie title. The image gradually becomes clearer, helping the user recognize and identify the movie as they guess.

## 📲 Features
- **Fetch Movie Data:** Retrieves detailed information about movies using the OMDb API.
- **Blurred Image Effect:** Presents the movie poster as blurred, progressively revealing it to help the user make a guess.
- **Search by Genre:** Allows users to search for movies by genre.
- **Error Handling:** Manages API connection errors and data-loading issues smoothly.

## 🛠️ Technologies Used
- **SwiftUI:** For UI design and interactive components.
- **Combine Framework:** Manages API data flows and asynchronous data updates in the app.
- **OMDb API:** Provides the app's movie data.
- **URLSession:** Manages HTTP requests for API calls and data processing.

## 📐 Project Architecture
- The app follows the MVVM (Model-View-ViewModel) architecture. This structure keeps data and the UI separate, ensuring a maintainable codebase.
