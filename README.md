# Vista Test — Flutter Frontend

A simple Flutter app that consumes the **Node + Express + Prisma + MySQL** backend.

## Features
- **CompanyListScreen**: Lists companies (name + registration number) and shows their services.
- **CreateCompanyScreen**: Form to create a company (name, registration number) with validation.
- **CreateServiceScreen**: Form to create a service (name, description, price) with a **company dropdown** + validation.
- Proper loading & error states.

## Stack
- Flutter 3.x (Material 3)
- `provider` for state management
- `http` for API calls

## Run the app
> Make sure the backend is running first and reachable at `http://localhost:4000`.

```bash
flutter pub get
# Recommended first run
flutter run -d chrome

# or Windows desktop (after enabling Windows support)
# flutter config --enable-windows-desktop
# flutter run -d windows

# or Android emulator (Android Studio + AVD)
# flutter run -d <emulator_id>