# Rabbit Hole
![RabbitHole_Presentation](https://github.com/user-attachments/assets/28624978-24f8-4579-9307-434822a686ff)
Rabbit Hole is a mobile application designed to help users build and maintain routines. Users can create routines and add relevant activities and tasks. Each activity has scheduled periods that enable users to seamlessly navigate through their routines. Users can also see the overviews of their progress in different periods to track their performance.

## Technology Stack

- Flutter
  - _[Installation Guide](https://docs.flutter.dev/get-started/install/windows/mobile)_
- Firebase

## Installing the Project

###### Download the project from the repository

```
git clone https://github.com/jrolana/cmsc128_lab.git
```
###### Install dependencies

```dart
cd cmsc128_lab
flutter pub get     // install dependencies
flutter run         // runs the application
```

## Contributing to the Project

1. Clone the repository.
2. Pull latest changes.
   `git pull`
3. Create a new branch.
   `git checkout -b branch-name`
4. Create changes.
5. Test code by running the application.
6. Push changes to the repository.
   `git add .`
   `git commit -m "commit message"`
   `git push`

## Testing Changes
###### It is recommended to use virtual or physical devices to run the app, as browsers don't support the actual dimensions of a phone.
### Running App on Physical Device
#### Thru Wireless Debugging
1. Enable [wireless debugging](https://developer.android.com/studio/run/device#wireless). 
2. Open Android Studio to [connect your device](https://developer.android.com/studio/run/device#wireless).
4. Type `flutter devices` in Visual Studio Code to check if the device is already connected.
5. Type `flutter run` and select your device.

## Resources

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
