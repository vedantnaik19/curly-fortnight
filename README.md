# Notes

Basic notes app.

## Installation

Go to project root and execute the following command in console to get the required dependencies:

```bash
flutter pub get
```

## Structure

- Every app screen has its own directory, which contains view(page/widget) file associated controller file and binding(used for putting dependencies) file.
- The core directory consists of all the app level stuff which includes services, route guards, theme, etc.
- Data directory consits of all the models and services for firestore db and cloud storage (read, write, update, delete) operations
- Shared directory consists of the widgets and services(other than data services) which are shared across different screens
- Utils folder consists of helper and validator classes

## Library used

- [GetX](https://pub.dev/packages/get) (For state, route and dependancy management)
