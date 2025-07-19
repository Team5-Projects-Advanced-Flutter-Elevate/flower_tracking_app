# 📍 Flower Tracking App

A modern delivery tracking app built for our Flower E-commerce platform. This app empowers delivery drivers to manage and track orders in real-time with a clean, scalable, and testable architecture — perfect for production-scale environments.

---

## ✨ Features

- 🧾 View orders with real-time delivery status
- 📦 Live GPS tracking of delivery locations
- 🔐 Secure login for drivers
- 📍 Step-by-step delivery flow (check-in, start, complete)
- 🔄 Order status updates: Placed → Out for Delivery → Delivered

---

## 🧱 Architecture

Built with a strong focus on scalability, modularity, and testability:

- **Clean Architecture** – Separation of concerns across data, domain, and presentation layers
- **Cubit + Equatable** – Lightweight and reactive state management
- **Geolocator** – Device GPS access for real-time location tracking
- **Retrofit** – Easy and structured API integration
- **Injectable** – Scalable and maintainable dependency injection setup

---

## 🧪 Testing

The app is thoroughly tested to ensure reliability and maintainability:

- `bloc_test` – For Cubit state unit testing
- `mockito` – For mocking APIs and services
- Widget tests – UI behavior verification across states

---

## 📦 Tech Stack

| Layer             | Tools / Libraries                     |
|------------------|----------------------------------------|
| UI/UX             | Flutter, Custom Widgets               |
| State Management  | Cubit, Equatable                      |
| API Communication | Retrofit, REST APIs                   |
| Dependency Injection | Injectable                        |
| GPS/Location      | Geolocator                            |
| Testing           | Mockito, bloc_test                    |

---

## 🧰 Getting Started

Clone the repository:

```bash
git clone https://github.com/Team5-Projects-Advanced-Flutter-Elevate/flower_tracking_app.git
cd tracking-app
```
## 🎥 Demo & Presentation
📂 [View App Demo on Google Drive](https://drive.google.com/drive/folders/1wrnAgrGfn9bBLu4Y4gJCbt2mA-JbKAu8?usp=sharing)
📊 [View Presentaion Slides](https://gamma.app/docs/Copy-of-FlowerEcommerce-App-fazaljw0my9mhzn)
