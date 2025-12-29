# Success Crew (Mobile)

An internal mobile application for **Success Comp** computer store employees to:
- Count and record customer visits (visitor counter)
- Track follow-ups / visit progress (visit pipeline)
- Submit leave and overtime requests
- Manage employee attendance

> Target platforms: **Android & iOS**  
> Backend: **REST API (JWT Authentication)**

---

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [User Roles](#user-roles)
- [Tech Stack](#tech-stack)
- [Architecture & Data Flow](#architecture--data-flow)

---

## Overview
**Success Crew** is an internal mobile app for **Success Comp** employees, focused on daily operations: recording customer visits, tracking visit follow-up stages, and basic HR processes such as attendance, leave requests, and overtime requests.

The app is built using **Clean Architecture** to keep the codebase maintainable and scalable as business requirements and API endpoints grow over time.

---

## Features

### 1) Visit
- Visitor counter
- Create visit records
- Track follow-up / visit stages (from arrival to closing)
- Visit history and status tracking

### 2) Attendance
- Check-in / check-out
- Attendance history
- (Optional) validation based on role/shift policies

### 3) Leave
- Leave request submission
- Leave history and approval status

### 4) Overtime
- Overtime request submission
- Overtime history and approval status

### 5) Notifications
- Operational notifications (approvals, visit updates, etc.)

---

## User Roles
Users are assigned roles based on their job functions, such as:
- Service Admin
- Sales
- Technician
- Manager
- (and other roles as needed)

Feature access and certain actions are controlled by roles provided by the backend system.

---

## Tech Stack
- **Flutter** (Android & iOS)
- **State Management:** Provider (ChangeNotifier)
- **HTTP Client:** Dio
- **Routing:** go_router
- **Local Storage:** SharedPreferences
- **Authentication:** JWT Token
- **Environment Config:** `.env` (e.g., via `flutter_dotenv`)

---

## Architecture & Data Flow
This project follows **Clean Architecture**, organized into layers:

- **Presentation:** UI + Provider (state management)
- **Domain:** Entities + Usecases + Repository contracts
- **Data:** Models + Repository implementations + Datasources (remote/local)
- **Core:** network client, error handling, constants, DI, environment utilities

### Data Flow (GET from API to UI)
1. The **UI page** calls a method in the **Provider**
2. The Provider calls a **Usecase** (Domain)
3. The Usecase calls a **Repository (interface)**
4. The repository implementation calls a **Remote DataSource**
5. The Remote DataSource performs a request via **Dio ApiClient**
6. The JSON response is parsed into a **Model**
7. The Model is mapped into an **Entity**
8. The Provider updates the state and calls `notifyListeners()`
9. The UI rebuilds and renders the data

**In short:**
`UI -> Provider -> Usecase -> Repository -> RemoteDataSource -> Dio(ApiClient) -> API`

### Local Storage (Token)
- JWT tokens are stored in **SharedPreferences**
- Any authenticated request must include:
  `Authorization: Bearer <token>`
