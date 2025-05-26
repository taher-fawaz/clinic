# Admin Features Documentation

This document describes the admin functionality implemented in the Clinic Flutter app.

## Overview

The admin system allows designated users to manage articles, offers, and appointments through a dedicated admin panel. Admin users have additional privileges compared to regular patient users.

## Features Implemented

### 1. User Role Management
- Added `isAdmin` field to `UserEntity` and `UserModel`
- Users can be designated as admin or patient
- Admin status is stored in Firestore database

### 2. Admin Panel Access
- Admin tab appears in bottom navigation only for admin users
- Real-time role checking using Firestore
- Conditional UI rendering based on user role

### 3. Admin Panel Features

#### Articles Management
- **Add Articles**: Create new health articles with title, description, and image URL
- **Edit Articles**: Modify existing article content
- **Delete Articles**: Remove articles with confirmation dialog
- **View Articles**: List all articles with preview images

#### Offers Management
- **Add Offers**: Create special offers with title, image, and validity date
- **Edit Offers**: Update offer details including expiration date
- **Delete Offers**: Remove offers with confirmation
- **Expiry Tracking**: Visual indicators for expired offers
- **Date Picker**: Easy date selection for offer validity

#### Appointment Management
- **Pending Appointments**: View appointments awaiting approval
- **Approve/Reject**: Accept or decline appointment requests
- **Status Tracking**: Separate tabs for pending and processed appointments
- **Appointment Details**: View patient info, doctor, date, and notes
- **History**: Track all processed appointments with their status

### 4. Admin Setup (Development)
- **Admin Setup Screen**: Development tool to grant admin privileges
- **Role Checking**: Verify current user's admin status
- **One-Click Admin**: Make current user admin for testing purposes
- **User Information**: Display current user details and role

## File Structure

```
lib/features/admin/
├── presentation/
│   ├── views/
│   │   ├── admin_view.dart              # Main admin panel with tabs
│   │   └── admin_setup_view.dart        # Development admin setup
│   └── widgets/
│       ├── admin_articles_tab.dart      # Articles management
│       ├── admin_offers_tab.dart        # Offers management
│       └── admin_appointments_tab.dart  # Appointments management

lib/core/utils/
└── admin_utils.dart                     # Admin utility functions
```

## Usage Instructions

### For Development/Testing

1. **Grant Admin Access**:
   - Navigate to Profile → Admin Setup (Dev)
   - Click "Make Me Admin (Dev Only)" button
   - This will grant admin privileges to the current user

2. **Access Admin Panel**:
   - After becoming admin, restart the app or navigate away and back
   - Admin tab will appear in the bottom navigation
   - Tap the Admin tab to access the admin panel

### Admin Panel Usage

1. **Managing Articles**:
   - Go to Admin Panel → Articles tab
   - Use "Add Article" button to create new articles
   - Tap edit icon to modify existing articles
   - Tap delete icon to remove articles

2. **Managing Offers**:
   - Go to Admin Panel → Offers tab
   - Use "Add Offer" button to create new offers
   - Set validity dates using the date picker
   - Edit or delete offers as needed

3. **Managing Appointments**:
   - Go to Admin Panel → Appointments tab
   - View pending appointments in the first tab
   - Approve or reject appointments using the action buttons
   - Check processed appointments in the second tab

## Security Considerations

### Production Deployment
- Remove the "Admin Setup (Dev)" option from profile settings
- Implement proper admin role assignment through backend
- Add server-side validation for admin operations
- Implement proper authentication and authorization

### Current Implementation
- Admin status is stored in Firestore
- Client-side role checking (should be supplemented with server-side validation)
- Development tools included for testing purposes

## Database Schema

### Users Collection
```json
{
  "name": "string",
  "email": "string",
  "uId": "string",
  "isAdmin": "boolean"
}
```

### Appointments Collection
```json
{
  "id": "string",
  "patientId": "string",
  "doctorId": "string",
  "appointmentDate": "timestamp",
  "status": "string", // 'pending', 'approved', 'rejected', 'scheduled', 'completed', 'cancelled'
  "notes": "string"
}
```

## Future Enhancements

1. **Backend Integration**:
   - Connect to actual backend APIs
   - Implement proper data persistence
   - Add real-time updates

2. **Enhanced Security**:
   - Server-side role validation
   - Audit logging for admin actions
   - Permission-based access control

3. **Additional Features**:
   - Bulk operations for articles/offers
   - Advanced filtering and search
   - Analytics and reporting
   - Push notifications for appointment updates

4. **UI/UX Improvements**:
   - Rich text editor for articles
   - Image upload functionality
   - Drag-and-drop reordering
   - Better responsive design

## Notes

- The current implementation uses local state management for demonstration
- In production, integrate with proper backend services
- Remove development tools before production deployment
- Ensure proper error handling and validation
- Test thoroughly with different user roles