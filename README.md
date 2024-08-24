# Naqla (نقلة)

Naqla is a platform designed to simplify the process of moving house furniture and goods. Inspired by the convenience of ride-sharing apps, Naqla connects users with reliable truck drivers for a seamless, stress-free moving experience.

Key Features:

- On-Demand Booking: Easily start an order to move your items whenever you need, whether it's a full house relocation or just a few pieces of furniture.
- Order Splitting: If your items exceed a single truck's capacity, our admins will seamlessly split your order into multiple deliveries, ensuring everything is transported safely and efficiently.
- Real-Time Chatting: Communicate directly with your driver through in-app messaging to coordinate pickup, delivery, and any special instructions.
- Transparent Pricing: Get upfront pricing with no hidden fees, allowing you to budget your move effectively.
- Driver Ratings: Ensure a high-quality experience with a rating system for drivers.

## Applications

- API Server (Nest.js) by [@bahaa-alden](https://github.com/bahaa-alden) and [@MahamdSirafi](https://github.com/MahamdSirafi)
- User App (Flutter) by [@Majed-alaswad9](https://github.com/Majed-alaswad9)
- Driver App (Flutter) by [@Majed-alaswad9](https://github.com/Majed-alaswad9)
- Admin Dashboard (Next.js) by [@I-3B](https://github.com/I-3B)

## Enviroment Variables

`api/.env`

```env
ENV=development
APP_NAME=Naqleh
PORT=5500
DATABASE_URL="postgresql://postgres:123@localhost:5434/naqleh"
JWT_SECRET=
JWT_EXPIRES_IN="15"

GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=


POSTGRES_USER=postgres
POSTGRES_PASS=123
POSTGRES_NAME=naqleh
POSTGRES_HOST=localhost
POSTGRES_PORT=5435
POSTGRES_SYNCHRONIZE=false,
POSTGRES_MAX_CONNECTIONS=100
POSTGRES_SSL_ENABLED=false
POSTGRES_REJECT_UNAUTHORIZED=false
POSTGRES_CA=
POSTGRES_KEY=
POSTGRES_CERT=
POSTGRES_URL=

CLOUDINARY_NAME=
CLOUDINARY_API_KEY=
CLOUDINARY_API_SECRET=
SUPER_ADMIN_FIRST_NAME=
SUPER_ADMIN_LAST_NAME=
SUPER_ADMIN_PHONE=
SUPER_ADMIN_PASSWORD=
EMPLOYEE_PASSWORD=


MAIL_USER=
MAIL_PASS=
MAIL_PORT=
MAIL_HOST=
MAIL_SECURE=false
MAIL_USER_R=
MAIL_PASS_R=
MAIL_FROM=
MAIL_FROM_NAME=
MAIL_QUEUE_HOST=
MAIL_QUEUE_PORT=
USER_VERIFIED_EXPIRES=1
```

`admin/.env`

```env
NEXT_PUBLIC_SERVER_URL=http://localhost:5500
```
