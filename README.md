# MovieApp

Movie Finder App is an iOS application that allows users to search for movies and view detailed information about them. The app provides users with movie titles, release years, and posters, enabling them to explore movie details effectively.

## Features

- **Movie Search**: Users can search for movies by title using a search bar.
- **Movie Details**: Displays detailed information for each movie including title, release year, and poster image.
- **Asynchronous Image Loading**: Posters are loaded asynchronously to avoid UI blocking and improve performance.
- **Detailed View**: Provides a detailed view of each movie when selected from the search results.

## Technologies

- **SwiftUI**: Utilized for building the user interface in a modern, declarative way.
- **URLSession**: Handles API requests and data fetching.
- **AsyncImage**: Loads and displays images asynchronously.

## Code Structure

- **`Service`**: Handles API requests and data management.
- **`Movie`**: Represents the movie data model.
- **`MoviesView`**: The main view for searching and listing movies.
- **`MovieDetailView`**: Shows detailed information about the selected movie.
- **`MoviePosterView`**: Displays movie posters with asynchronous loading.

