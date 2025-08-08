# Parking Booking Flutter App

A Flutter application for managing parking slot bookings with real-time updates using Firebase Firestore.

## Features

- View available parking slots (P1 to P10).
- Book a parking slot by entering your name.
- Free a booked parking slot.
- Real-time synchronization of parking slot status across devices (Flutter app and Web).
- User authentication with logout functionality.
- Responsive UI with grid layout for parking slots.


## Getting Started

### Prerequisites

- Flutter SDK installed ([Flutter installation guide](https://flutter.dev/docs/get-started/install))
- A Firebase project set up with Firestore enabled.
- Connected your Flutter app to Firebase (Android/iOS).

### Installation

1. Clone the repository:
   git clone https://github.com/Ashutosh-Dhodad/Parking-Booking-Flutter-App.git
   cd Parking-Booking-Flutter-App

2. Install dependencies:
   flutter pub get

3. Run the app:
   flutter run

4. login credentials:
   email:test@gmail.com
   password:123456


## Folder Structure
lib/

  Models/ — Data models like ParkingSlotModel.
  
  Services/ — Firebase Firestore interaction & slot booking logic.
  
  Controllers/ — Authentication and other controllers.
  
  Screens/ — UI screens like HomePage.
  
  Widgets/ — Reusable widgets.
