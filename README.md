# Local Services Marketplace

Ứng dụng kết nối người dùng với các dịch vụ địa phương như sửa chữa, vệ sinh, làm đẹp, chăm sóc nhà cửa.

## Tech Stack

### Frontend
- Flutter (Mobile App)
- GetX (State Management)
- Google Maps Flutter
- Flutter Local Notifications

### Backend
- Node.js + Express
- PostgreSQL (Main Database)
- Redis (Caching)
- Firebase (Authentication, Cloud Messaging)

### DevOps
- Docker
- GitHub Actions
- AWS (Hosting)

## Cấu trúc thư mục

```
lib/
├── core/                 # Core functionality
│   ├── config/          # App configuration
│   ├── network/         # API clients, interceptors
│   ├── storage/         # Local storage
│   └── utils/           # Helper functions
├── features/            # Feature modules
│   ├── auth/           # Authentication
│   ├── services/       # Service listing, search
│   ├── booking/        # Booking management
│   ├── payment/        # Payment processing
│   ├── profile/        # User profiles
│   └── admin/          # Admin dashboard
└── shared/             # Shared components
    ├── widgets/        # Reusable widgets
    ├── models/         # Data models
    └── services/       # Shared services
```

## Các Module Chính

### 1. Authentication Module
- Đăng ký/Đăng nhập (Email, Phone, Social)
- Phân quyền: User, Provider, Admin
- Quản lý profile

### 2. Services Module
- Danh sách dịch vụ
- Tìm kiếm theo loại, khoảng cách
- Lọc theo đánh giá, giá cả
- Chi tiết dịch vụ

### 3. Booking Module
- Đặt lịch dịch vụ
- Quản lý lịch hẹn
- Thông báo trạng thái
- Hủy/Đổi lịch

### 4. Payment Module
- Ví điện tử nội bộ
- Thanh toán online
- Quản lý giao dịch
- Hoa hồng (5%)

### 5. Rating & Review Module
- Đánh giá dịch vụ
- Phản hồi từ nhà cung cấp
- Báo cáo vi phạm

### 6. Admin Module
- Quản lý người dùng
- Quản lý dịch vụ
- Báo cáo doanh thu
- Xử lý khiếu nại

## API Endpoints

### Authentication
```
POST /api/auth/register
POST /api/auth/login
POST /api/auth/verify-phone
POST /api/auth/reset-password
```

### Services
```
GET /api/services
GET /api/services/nearby
GET /api/services/{id}
POST /api/services/search
GET /api/services/categories
```

### Booking
```
POST /api/bookings
GET /api/bookings/user
GET /api/bookings/provider
PUT /api/bookings/{id}/status
```

### Payment
```
POST /api/payments/create
POST /api/payments/verify
GET /api/payments/history
POST /api/wallet/topup
```

### Rating
```
POST /api/ratings
GET /api/ratings/service/{id}
PUT /api/ratings/{id}
```

## Logic Matching

1. Khi người dùng tìm kiếm dịch vụ:
   - Lấy vị trí hiện tại
   - Tìm các nhà cung cấp trong bán kính 10km
   - Lọc theo:
     + Loại dịch vụ
     + Đánh giá (>= 4.0)
     + Thời gian sẵn sàng
     + Giá cả

2. Xếp hạng nhà cung cấp:
   - Khoảng cách (40%)
   - Đánh giá (30%)
   - Số lượng đơn hàng (20%)
   - Thời gian phản hồi (10%)

3. Thông báo:
   - Push notification cho nhà cung cấp
   - SMS cho người dùng
   - Email xác nhận

## Tính năng mở rộng

1. Loyalty Program
   - Điểm thưởng
   - Voucher giảm giá
   - Chương trình giới thiệu

2. Marketing
   - Quảng cáo nhà cung cấp
   - Khuyến mãi theo mùa
   - Email marketing

3. Analytics
   - Báo cáo doanh thu
   - Phân tích hành vi
   - Dự đoán xu hướng
