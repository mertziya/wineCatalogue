# Wine Catalog App

This is an iOS application built to demonstrate the understanding of **MVVM architecture**, integration of the **RxSwift** library, and usage of **Alamofire** for network requests. The app showcases a collection of different wine types (red, white, sparkling, rosé, etc.) retrieved from an API. 

It features a **tab bar** navigation system, each tab displaying a list of wines with optimized performance through pagination. Users can select a wine from the list to view its detailed information on a dedicated screen.

---

## Demo

Check out the live demo of the application: [Wine Catalog App Demo](https://drive.google.com/drive/folders/17GMqzXO9Won6zUK0PadR8v0VBefbvC4M)

---

## Features

### 1. Tab Bar Navigation
- Each tab represents a wine category (Red, White, Sparkling, Rosé, etc.).
- Seamless navigation between tabs for a better user experience.

### 2. Table View with Pagination
- Each tab contains a **Table View** that displays a list of wines for that category.
- **Pagination logic** ensures only one cell loads at a time as the user scrolls, improving performance and speed.

### 3. Detail Screen
- Tapping on a wine cell navigates to a detailed screen.
- The detailed screen displays information about the selected wine, fetched dynamically based on the selected cell.

---

## Architecture
The application follows the **MVVM (Model-View-ViewModel)** architecture to ensure modular, testable, and scalable code.

- **Model**: Represents wine data received from the API.
- **View**: Handles the UI components, such as Table Views and Detail Views.
- **ViewModel**: Processes data from the Model and updates the View using reactive bindings with **RxSwift**.

---

## Libraries Used

- **RxSwift**: Reactive programming to manage data binding between the View and ViewModel.
- **Alamofire**: Network library used for API requests to fetch wine data.
- **UIKit**: Core framework for building UI components like Tab Bars, Table Views, and Navigation.

---

## API
The app connects to a custom API that provides data for various wine categories, including:
- Red Wines : https://api.sampleapis.com/wines/reds
- White Wines : https://api.sampleapis.com/wines/whites
- Sparkling Wines : https://api.sampleapis.com/wines/sparkling
- Rosé Wines : https://api.sampleapis.com/wines/rose

The API supports pagination to load wine data in chunks.

---

## Key Implementation Details

### Pagination
- **Logic**: Data loads incrementally as the user scrolls to the bottom of the list.
- **Performance**: Only one Table View cell loads at a time to improve speed and minimize memory usage.

### Navigation
- **Tab Bar**: Divides the app into different wine categories for better organization.
- **Navigation Bar**: Facilitates smooth navigation to the detail screen for selected items.

---

## Installation

1. Clone the repository:
   ```bash
   git clone <repository_url>

   

   
