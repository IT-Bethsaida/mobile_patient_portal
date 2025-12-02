# Panduan Refactoring: Transisi ke Feature-First Architecture

Dokumen ini berisi panduan langkah demi langkah untuk merapikan struktur project `patient_portal` dari **Layer-First** (saat ini) menjadi **Feature-First**.

## 🎯 Tujuan

1.  **Organisasi yang Lebih Baik**: Mengelompokkan file berdasarkan fitur agar mudah dicari.
2.  **Persiapan Backend**: Memisahkan UI dari Data (Mock Data) untuk memudahkan integrasi API di masa depan.
3.  **Scalability**: Memudahkan penambahan fitur baru tanpa mengganggu fitur lama.
4.  **Clean Code**: Memecah file besar ("God Classes") menjadi widget yang lebih kecil dan reusable.

---

## 📂 Struktur Folder Baru (Proposed)

Kita akan memindahkan file dari `lib/screens` dan `lib/widgets` ke dalam folder `lib/features`.

```text
lib/
├── core/                   # (Tetap) Konfigurasi global (Theme, Colors, Utils)
├── shared/                 # Widget umum yang dipakai lintas fitur
│   └── widgets/            # Contoh: CustomButton, CustomTextField
├── features/               # FOLDER BARU UTAMA
│   ├── auth/               # Fitur Otentikasi
│   │   ├── screens/
│   │   └── widgets/
│   ├── home/               # Halaman Utama & Dashboard
│   │   ├── screens/
│   │   └── widgets/
│   ├── appointment/        # Fitur Janji Temu Dokter
│   │   ├── data/           # Dummy Data Dokter & Jadwal
│   │   ├── screens/
│   │   └── widgets/
│   ├── medical_record/     # Fitur Rekam Medis
│   │   ├── data/
│   │   ├── screens/
│   │   └── widgets/
│   ├── hospital_info/      # Informasi Rumah Sakit (lokasi, kontak)
│   │   ├── screens/
│   │   └── widgets/
│   ├── services/           # Layanan RS (emergency, premium, dll)
│   │   ├── screens/
│   │   └── widgets/
│   ├── promos/             # Promosi & Penawaran
│   │   ├── screens/
│   │   └── widgets/
│   └── profile/            # Profil User & Settings
│       ├── screens/
│       └── widgets/
└── main.dart
```

---

## 🗺️ Pemetaan File (File Mapping)

Berikut adalah rencana pemindahan file yang ada saat ini ke struktur baru:

### 1. Features: Auth (`features/auth`)

- `lib/screens/login_page.dart` -> `features/auth/screens/login_page.dart`
- `lib/screens/register_page.dart` -> `features/auth/screens/register_page.dart`
- `lib/screens/otp_verification_page.dart` -> `features/auth/screens/otp_verification_page.dart`
- `lib/components/social_login_button.dart` -> `features/auth/widgets/social_login_button.dart`

### 2. Features: Home (`features/home`)

- `lib/screens/splash_page.dart` -> `features/home/screens/splash_page.dart`
- `lib/widgets/main_wrapper.dart` -> `features/home/screens/main_wrapper.dart`
- `lib/widgets/home_page_content.dart` -> `features/home/screens/home_page.dart` (Rename)
- `lib/screens/notifications_page.dart` -> `features/home/screens/notifications_page.dart`

### 3. Features: Appointment (`features/appointment`)

- `lib/screens/all_doctors_page.dart` -> `features/appointment/screens/all_doctors_page.dart`
- `lib/screens/doctor_detail_page.dart` -> `features/appointment/screens/doctor_detail_page.dart`
- `lib/screens/search_doctor_page.dart` -> `features/appointment/screens/search_doctor_page.dart`
- `lib/screens/select_doctor_page.dart` -> `features/appointment/screens/select_doctor_page.dart`
- `lib/screens/specialists_page.dart` -> `features/appointment/screens/specialists_page.dart`
- `lib/screens/book_appointment_page.dart` -> `features/appointment/screens/book_appointment_page.dart`

### 4. Features: Medical Record (`features/medical_record`)

- `lib/widgets/medical_record_page_content.dart` -> `features/medical_record/screens/medical_record_page.dart` (Rename)
- `lib/screens/visit_history_page.dart` -> `features/medical_record/screens/visit_history_page.dart`
- `lib/screens/lab_results_page.dart` -> `features/medical_record/screens/lab_results_page.dart`
- `lib/screens/radiology_results_page.dart` -> `features/medical_record/screens/radiology_results_page.dart`
- `lib/screens/medications_page.dart` -> `features/medical_record/screens/medications_page.dart`
- `lib/models/outpatient_history_model.dart` -> `features/medical_record/models/outpatient_history_model.dart`

### 5. Features: Hospital Info (`features/hospital_info`)

**Screens:**

- `lib/screens/hospital_information_page.dart` -> `features/hospital_info/screens/hospital_information_page.dart`
- `lib/screens/hospital_detail_page.dart` -> `features/hospital_info/screens/hospital_detail_page.dart`

**Widgets:**

- **NEW:** `features/hospital_info/widgets/hospital_card.dart` - Reusable hospital card for list
- **NEW:** `features/hospital_info/widgets/hospital_hero_image.dart` - Hero image with gradient
- **NEW:** `features/hospital_info/widgets/hospital_info_card.dart` - Info card with contact details
- **NEW:** `features/hospital_info/widgets/operational_hours_card.dart` - Operating hours display
- **NEW:** `features/hospital_info/widgets/facilities_card.dart` - Facilities grid display
- **NEW:** `features/hospital_info/widgets/gallery_card.dart` - Photo gallery grid

**Utils:**

- **NEW:** `features/hospital_info/utils/url_launcher_utils.dart` - Utility for phone calls & maps

**Models & Services:**

- **NEW:** `features/hospital_info/models/hospital_model.dart` - Hospital data model
- **NEW:** `features/hospital_info/services/hospital_service.dart` - API service for hospitals

### 6. Features: Services (`features/services`)

- `lib/screens/emergency_page.dart` -> `features/services/screens/emergency_page.dart`
- `lib/screens/all_services_page.dart` -> `features/services/screens/all_services_page.dart`
- `lib/screens/premium_services_page.dart` -> `features/services/screens/premium_services_page.dart`

### 7. Features: Promos (`features/promos`)

- `lib/screens/all_promos_page.dart` -> `features/promos/screens/all_promos_page.dart`
- `lib/screens/promo_detail_page.dart` -> `features/promos/screens/promo_detail_page.dart`

### 8. Features: Profile (`features/profile`)

- `lib/widgets/profile_page_content.dart` -> `features/profile/screens/profile_page.dart` (Rename)
- `lib/screens/settings_page.dart` -> `features/profile/screens/settings_page.dart`

---

## 🛠️ Langkah-Langkah Refactoring

### Tahap 1: Persiapan Folder

1.  Buat folder `lib/features`.
2.  Buat sub-folder untuk setiap fitur seperti struktur di atas.

### Tahap 2: Pemindahan File (Move)

1.  Pindahkan file satu per satu sesuai **Pemetaan File**.
2.  **PENTING:** Setiap kali memindahkan file, VS Code biasanya akan menawarkan untuk _update imports_. Pilih **Yes**.
3.  Jika import tidak otomatis terupdate, Anda harus memperbaikinya manual (biasanya error merah akan muncul).

### Tahap 3: Extract Widgets (Pembersihan File Besar)

Fokus pada file besar seperti `doctor_detail_page.dart`.

1.  Identifikasi bagian UI yang panjang, misalnya kartu pasien.
2.  **CEK DUPLIKASI:** Sebelum membuat file baru, cek folder `shared/widgets` atau `features/.../widgets` lain. Pastikan widget serupa belum pernah dibuat sebelumnya.
3.  Cut kode widget tersebut.
4.  Buat file baru: `features/appointment/widgets/patient_info_card.dart`.
5.  Paste kode tersebut ke dalam class `StatelessWidget` baru.
6.  Import widget baru ini di `doctor_detail_page.dart`.

### Tahap 4: Extract Data (Persiapan Backend)

Pisahkan data hardcoded dari UI.

1.  Lihat `doctor_detail_page.dart`, cari list dummy dokter atau jadwal.
2.  Buat file baru: `features/appointment/data/doctor_dummy_data.dart`.
3.  Pindahkan variabel List/Map ke file ini.
4.  Panggil data dari file ini di UI.

---

## ✅ Checklist Refactoring

- [x] Folder structure created (`lib/features/...`)
- [x] **Auth** files moved (login, register, otp_verification, social_login_button)
- [x] **Home** files moved (splash_page)
- [ ] **Appointment** files moved
- [ ] **Medical Record** files moved
- [x] **Hospital Info** files moved & refactored ✅ COMPLETE
  - [x] Screens moved (hospital_information, hospital_detail)
  - [x] Created HospitalCard widget (extracted from list page)
  - [x] Created UrlLauncherUtils (phone & maps utilities)
  - [x] Integrated with API service (getHospitals, getHospitalById)
  - [x] hospital_detail_page now hits API instead of receiving data from parent
  - [x] Extracted 5 widgets from hospital_detail_page:
    - HospitalHeroImage (hero image with gradient)
    - HospitalInfoCard (name, address, phone, action buttons)
    - OperationalHoursCard (operating hours list)
    - FacilitiesCard (facilities grid)
    - GalleryCard (photo gallery grid)
  - [x] Reduced hospital_detail_page from 518 lines to 167 lines (68% reduction)
- [x] **Services** files moved (emergency, all_services, premium_services)
- [x] **Promos** files moved (all_promos, promo_detail)
- [ ] **Profile** files moved
- [x] `main.dart` imports updated (untuk Auth, Splash, Hospital Info, Services & Promos)
- [ ] `pubspec.yaml` checked (jika ada asset yang path-nya berubah, meski jarang terjadi untuk file .dart)
- [ ] `flutter clean` & `flutter pub get` dijalankan
- [ ] Aplikasi berjalan normal tanpa error

---

## 📝 Catatan Perubahan Struktur

**Perubahan dari rencana awal:**

- Fitur **Hospital Info** dipecah menjadi 3 fitur terpisah untuk organisasi yang lebih baik:
  - `features/hospital_info/` - Informasi rumah sakit (lokasi, kontak, detail)
  - `features/services/` - Layanan rumah sakit (emergency, all services, premium services)
  - `features/promos/` - Promosi dan penawaran khusus

Pemisahan ini membuat struktur lebih modular dan mudah di-maintain.

---

> **Catatan:** Lakukan refactoring ini secara bertahap (per fitur). Jangan pindahkan semua sekaligus untuk meminimalisir error yang menumpuk. Pastikan aplikasi bisa di-run setelah menyelesaikan satu fitur.

---

## 🎓 Best Practices yang Sudah Diimplementasikan

### Hospital Info Feature (Completed ✅)

#### 1. **API Integration Pattern**

- ✅ Detail page hits API endpoint (`getHospitalById`) instead of receiving data from parent
- ✅ Uses `FutureBuilder` with proper loading/error/success states
- ✅ Implements retry functionality on error
- ✅ Uses `ApiResponse` wrapper for consistent error handling

#### 2. **Widget Extraction**

- ✅ Extracted `HospitalCard` widget from `hospital_information_page.dart`
- ✅ Made widget reusable with callback pattern (`onTap`, `onCall`, `onDirections`)
- ✅ Reduced page complexity from 400+ lines to ~150 lines

#### 3. **Utility Classes**

- ✅ Created `UrlLauncherUtils` for phone calls and maps
- ✅ Eliminated code duplication across multiple pages
- ✅ Added proper error handling with user feedback
- ✅ Implemented `mounted` check to prevent BuildContext errors

#### 4. **Type Safety**

- ✅ Changed from `Map<String, dynamic>` to `HospitalModel`
- ✅ Compile-time type checking instead of runtime errors
- ✅ Better IDE autocomplete and refactoring support

#### 5. **State Management**

- ✅ Uses shared state widgets (`LoadingState`, `ErrorState`, `ApiErrorState`, `EmptyState`)
- ✅ Consistent UI/UX across all states
- ✅ Proper loading indicators and error messages

#### 6. **Code Organization**

```
features/hospital_info/
├── models/
│   └── hospital_model.dart          # Data model with fromJson/toJson
├── screens/
│   ├── hospital_information_page.dart  # List page (~150 lines)
│   └── hospital_detail_page.dart       # Detail page (~300 lines)
├── services/
│   └── hospital_service.dart        # API calls (getHospitals, getHospitalById)
├── utils/
│   └── url_launcher_utils.dart      # Reusable utilities
└── widgets/
    └── hospital_card.dart           # Reusable card widget
```

#### 7. **Benefits Achieved**

- 🚀 **Performance**: Only loads necessary data per page
- 🔄 **Real-time**: Data always up-to-date from API
- 🧩 **Modularity**: Each component has single responsibility
- 🔧 **Maintainability**: Easy to update and test
- ♻️ **Reusability**: Widgets and utils can be used elsewhere
- 🐛 **Debugging**: Clear separation makes bugs easier to find

---

## 📋 Refactoring Checklist untuk Fitur Lain

Gunakan checklist ini saat refactoring fitur lain:

### Pre-Refactoring

- [ ] Identify all files related to the feature
- [ ] Check for code duplication across files
- [ ] List all hardcoded data that should come from API
- [ ] Identify large widgets that can be extracted

### During Refactoring

- [ ] Create feature folder structure (screens, widgets, models, services, utils)
- [ ] Move files to appropriate folders
- [ ] Extract reusable widgets (aim for <200 lines per widget)
- [ ] Create utility classes for shared functionality
- [ ] Implement API integration with proper error handling
- [ ] Use proper models instead of Map<String, dynamic>
- [ ] Add `mounted` checks for async operations with BuildContext

### Post-Refactoring

- [ ] Run `flutter analyze` - no errors
- [ ] Run `getDiagnostics` - no warnings
- [ ] Test all user flows
- [ ] Update imports in other files
- [ ] Update documentation
- [ ] Run `flutter clean && flutter pub get`

---

## 🔄 Next Features to Refactor

Priority order based on complexity and impact:

1. **Appointment** (High Priority)

   - Large files with complex UI
   - Multiple API endpoints needed
   - Lots of reusable widgets to extract

2. **Medical Record** (High Priority)

   - Similar to Hospital Info pattern
   - Multiple list/detail pages
   - Good candidate for API integration

3. **Profile** (Medium Priority)

   - Simpler structure
   - Less API integration needed

4. **Home** (Low Priority)
   - Already relatively clean
   - Mostly navigation hub

---

> **Remember**: Refactor incrementally, test frequently, and commit often! 🚀
