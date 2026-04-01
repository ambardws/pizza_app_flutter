# Dokumentasi Pizza App - Flutter

> Dokumentasi lengkap untuk memahami flow code dan arsitektur project Pizza App

---

## Table of Contents

1. [Overview Project](#overview-project)
2. [Struktur Folder](#struktur-folder)
3. [Flow Aplikasi](#flow-aplikasi)
4. [State Management (BLoC Pattern)](#state-management-bloc-pattern)
5. [Menampilkan List Pizza](#menampilkan-list-pizza)
6. [Shopping Cart & Transaksi](#shopping-cart--transaksi)
7. [Penjelasan Widget](#penjelasan-widget)
8. [Navigation Flow](#navigation-flow)

---

## Overview Project

Pizza App adalah aplikasi Flutter yang menggunakan:
- **State Management**: BLoC Pattern
- **Backend**: Firebase (Authentication & Firestore)
- **Arsitektur**: Clean Architecture dengan Repository Pattern
- **Modular**: Menggunakan packages untuk setiap repository

### Teknologi Utama

| Teknologi | Penggunaan |
|-----------|-----------|
| Flutter | UI Framework |
| flutter_bloc | State Management |
| firebase_core | Firebase Initialization |
| firebase_auth | Authentication |
| cloud_firestore | Database |
| equatable | State Comparison |

---

## Struktur Folder

```
pizza_app/
├── lib/
│   ├── main.dart                 # Entry point aplikasi
│   ├── app.dart                  # Konfigurasi Repository & BLoC
│   ├── app_view.dart             # Routing & Theme management
│   │
│   ├── blocs/                    # Global BLoC
│   │   ├── authentication_bloc/  # Auth state management
│   │   └── theme_bloc/           # Dark/Light theme
│   │
│   ├── screens/                  # Feature screens
│   │   ├── auth/                 # Authentication screens
│   │   │   ├── views/
│   │   │   │   ├── welcome_screen.dart
│   │   │   │   ├── sign_in_screen.dart
│   │   │   │   └── sign_up_screen.dart
│   │   │   └── blocs/
│   │   │       ├── sign_in_bloc/
│   │   │       └── sign_up_bloc/
│   │   │
│   │   ├── home/                 # Home & Pizza List
│   │   │   ├── views/
│   │   │   │   ├── home_screen.dart
│   │   │   │   └── details_screen.dart
│   │   │   ├── components/
│   │   │   │   ├── pizza_grid_item.dart
│   │   │   │   ├── pizza_price_row.dart
│   │   │   │   ├── pizza_tags_row.dart
│   │   │   │   ├── cart_badge.dart
│   │   │   │   └── details/
│   │   │   │       ├── pizza_image.dart
│   │   │   │       ├── pizza_info.dart
│   │   │   │       └── add_to_cart_button.dart
│   │   │   └── blocs/
│   │   │       └── get_pizza_bloc/
│   │   │
│   │   └── cart/                 # Shopping Cart
│   │       ├── views/
│   │       │   └── cart_screen.dart
│   │       ├── components/
│   │       │   ├── cart_item.dart
│   │       │   ├── quantity_button.dart
│   │       │   ├── order_row.dart
│   │       │   └── order_info.dart
│   │       └── blocs/
│   │           ├── get_cart_bloc/
│   │           ├── add_cart_bloc/
│   │           └── update_cart_bloc/
│   │
│   └── components/               # Reusable widgets
│       ├── my_text_field.dart
│       ├── separator.dart
│       ├── cart_indicator.dart
│       └── macro.dart
│
├── packages/                     # Modular repositories
│   ├── user_repository/          # User authentication & profile
│   ├── pizza_repository/         # Pizza data operations
│   └── cart_repository/          # Cart operations
│
└── pubspec.yaml                  # Dependencies configuration
```

---

## Flow Aplikasi

### 1. Application Startup

```
main.dart
    ↓
Firebase.initializeApp()
    ↓
Bloc.observer = SimpleBlocObserver()
    ↓
MyApp(userRepository)
    ↓
MultiRepositoryProvider (User, Pizza, Cart)
    ↓
BlocProvider (AuthenticationBloc)
    ↓
MyAppView
```

**File**: `lib/main.dart`

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();        // Inisialisasi Firebase
  Bloc.observer = SimpleBlocObserver();  // Observer untuk debugging BLoC
  runApp(MyApp(FirebaseUserRepo()));     // Jalankan aplikasi
}
```

**File**: `lib/app.dart`

```dart
// Setup semua repositories dan BLoC global
MultiRepositoryProvider(
  providers: [
    RepositoryProvider<UserRepository>(...),
    RepositoryProvider<PizzaRepository>(...),
    RepositoryProvider<CartRepository>(...),
  ],
  child: BlocProvider<AuthenticationBloc>(...),
)
```

### 2. Authentication Flow

```
App Launch
    ↓
Cek Authentication State
    ↓
┌────────────────┬────────────────┐
│ Not Authenticated   │   Authenticated    │
│                    │                    │
│ ↓                  │ ↓                  │
│ Welcome Screen     │ Home Screen        │
│ (Sign In/Sign Up)  │ (Pizza List)       │
└────────────────────┴────────────────────┘
```

---

## State Management (BLoC Pattern)

BLoC (Business Logic Component) adalah pattern untuk memisahkan business logic dari UI.

### Struktur Dasar BLoC

```
bloc_name/
├── bloc_name_bloc.dart   # Logic utama
├── bloc_name_event.dart  # Events/triggers
└── bloc_name_state.dart  # States output
```

### Contoh: GetPizzaBloc

**File**: `lib/screens/home/blocs/get_pizza_bloc/get_pizza_bloc.dart`

```dart
class GetPizzaBloc extends Bloc<GetPizzaEvent, GetPizzaState> {
  final PizzaRepository _pizzaRepo;

  GetPizzaBloc(this._pizzaRepo) : super(GetPizzaInitial()) {
    on<GetPizzaEvent>((event, emit) async {
      emit(GetPizzaLoading());                    // 1. Emit loading state
      try {
        List<Pizza> pizzas = await _pizzaRepo.getPizzas(); // 2. Fetch data
        emit(GetPizzaSuccess(pizzas));             // 3. Emit success state
      } catch (_) {
        emit(GetPizzaFailure());                   // 4. Emit error state
      }
    });
  }
}
```

### Event → State Flow

```
User Action / Trigger
    ↓
Add Event to BLoC
    ↓
BLoC Process Event
    ↓
Emit New State
    ↓
UI Rebuild based on State
```

---

## Menampilkan List Pizza

### Flow Lengkap Menampilkan Pizza

```
1. HomeScreen diload
    ↓
2. initState() memanggil GetPizzaBloc
    ↓
3. GetPizzaBloc fetch data dari PizzaRepository
    ↓
4. Repository mengambil data dari Firestore
    ↓
5. Data di-convert dari Entity → Model
    ↓
6. GetPizzaBloc emit GetPizzaSuccess(pizzas)
    ↓
7. BlocBuilder rebuild UI dengan data pizzas
    ↓
8. GridView.builder menampilkan list pizza
```

### Code Breakdown

#### 1. Trigger Fetch Data

**File**: `lib/screens/home/blocs/get_pizza_bloc/get_pizza_bloc.dart`

```dart
// BLoC otomatis trigger event saat pertama kali di-create
on<GetPizzaEvent>((event, emit) async {
  emit(GetPizzaLoading());
  List<Pizza> pizzas = await _pizzaRepo.getPizzas();
  emit(GetPizzaSuccess(pizzas));
});
```

#### 2. Display di UI

**File**: `lib/screens/home/views/home_screen.dart`

```dart
BlocBuilder<GetPizzaBloc, GetPizzaState>(
  builder: (context, state) {
    if (state is GetPizzaSuccess) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,              // 2 kolom
          crossAxisSpacing: screenWidth * 0.04,
          mainAxisSpacing: screenWidth * 0.04,
          childAspectRatio: 0.85,
        ),
        itemCount: state.pizzas.length,   // Jumlah item
        itemBuilder: (context, index) {
          final pizza = state.pizzas[index];
          return PizzaGridItem(
            pizza: pizza,
            onAddToCart: () => _addToCart(pizza),
            onTap: () => _navigateToDetails(pizza),
          );
        },
      );
    } else if (state is GetPizzaLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    // ...
  },
)
```

### PizzaGridItem Widget

**File**: `lib/screens/home/components/pizza_grid_item.dart`

Widget ini menampilkan satu kartu pizza:

```dart
class PizzaGridItem extends StatelessWidget {
  final Pizza pizza;
  final VoidCallback onAddToCart;  // Callback untuk add to cart
  final VoidCallback? onTap;       // Callback untuk navigate ke detail

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      child: InkWell(
        onTap: onTap,  // Navigasi ke detail saat diklik
        child: Column(
          children: [
            // 1. Gambar Pizza
            Image.network(pizza.picture),
            // 2. Tags (Vegetarian, Spicy, dll)
            PizzaTagsRow(pizza: pizza),
            // 3. Nama Pizza
            Text(pizza.name),
            // 4. Deskripsi
            Text(pizza.description),
            // 5. Harga + Tombol Add to Cart
            PizzaPriceRow(pizza: pizza, onAddToCart: onAddToCart),
          ],
        ),
      ),
    );
  }
}
```

---

## Shopping Cart & Transaksi

### Architecture Cart System

Terdapat 3 BLoC untuk cart:

| BLoC | Fungsi |
|------|--------|
| **GetCartBloc** | Mengambil data cart user |
| **AddCartBloc** | Menambah pizza ke cart |
| **UpdateCartBloc** | Update qty & remove item |

### Flow Menambah ke Cart

```
User klik "Add to Cart"
    ↓
HomeScreen._addToCart(pizza)
    ↓
Buat object Cart dengan quantity = 1
    ↓
AddCartBloc.add(AddCart(cart, userId))
    ↓
CartRepository.addCart(userId, cart)
    ↓
Simpan ke Firestore
    ↓
Emit AddCartSuccess
    ↓
BlocListener di HomeScreen detect success
    ↓
Refresh cart (GetCartBloc)
    ↓
Show SnackBar success message
```

### Code Breakdown

#### 1. Add to Cart Handler

**File**: `lib/screens/home/views/home_screen.dart`

```dart
void _addToCart(Pizza pizza) {
  // 1. Buat object Cart
  final cart = Cart(
    id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
    pizza: pizza,
    price: pizza.price,
    quantity: 1,  // Default quantity
  );

  // 2. Trigger AddCartBloc
  context.read<AddCartBloc>().add(AddCart(cart, _userId));
}
```

#### 2. AddCartBloc

**File**: `lib/screens/cart/blocs/add_cart_bloc/add_cart_bloc.dart`

```dart
on<AddCart>((event, emit) async {
  emit(AddCartProcess(event.cart.pizza.pizzaId));  // Loading
  try {
    // Simpan ke Firestore
    await _cartRepository.addCart(event.userId, event.cart);
    emit(AddCartSuccess(event.cart.pizza.pizzaId)); // Success
  } catch (e) {
    emit(AddCartFailure(pizzaId: event.cart.pizza.pizzaId)); // Error
  }
});
```

#### 3. Listen Result & Refresh

**File**: `lib/screens/home/views/home_screen.dart`

```dart
BlocListener<AddCartBloc, AddCartState>(
  listener: (context, state) {
    if (state is AddCartSuccess) {
      _refreshCart();  // Fetch cart terbaru

      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pizza added to cart!')),
      );
    }
  },
  child: Scaffold(...), // UI utama
)
```

### Flow Menampilkan Cart

```
CartScreen diload
    ↓
initState() trigger GetCartBloc
    ↓
GetCartBloc fetch cart dari Firestore
    ↓
Emit GetCartSuccess(carts)
    ↓
BlocBuilder rebuild UI
    ↓
ListView.builder menampilkan cart items
    ↓
OrderInfo menampilkan total harga
```

**File**: `lib/screens/cart/views/cart_screen.dart`

```dart
BlocBuilder<GetCartBloc, GetCartState>(
  builder: (context, state) {
    if (state is GetCartSuccess) {
      return _buildCartContent(state.carts);
    }
    // Handle loading, error, empty states
  },
)

Widget _buildCartContent(List<Cart> carts) {
  // Hitung totals
  double subTotal = carts.fold(0, (sum, cart) => sum + cart.price * cart.quantity);
  double delivery = 2.00;
  double total = subTotal + delivery;

  return Column(
    children: [
      // List cart items
      Expanded(
        child: ListView.builder(
          itemCount: carts.length,
          itemBuilder: (context, index) {
            return CartItem(
              cart: carts[index],
              onIncrement: () => _incrementQty(carts[index]),
              onDecrement: () => _decrementQty(carts[index]),
            );
          },
        ),
      ),
      // Order summary
      OrderInfo(subTotal: subTotal, delivery: delivery, total: total),
    ],
  );
}
```

### Flow Update Quantity

```
User klik tombol + atau -
    ↓
CartItem callback (onIncrement/onDecrement)
    ↓
UpdateCartBloc event (IncrementCartQuantity/DecrementCartQuantity)
    ↓
Repository update di Firestore
    ↓
Emit UpdateCartSuccess
    ↓
BlocListener detect success
    ↓
Refresh cart (GetCartBloc)
```

**File**: `lib/screens/cart/blocs/update_cart_bloc/update_cart_bloc.dart`

```dart
on<IncrementCartQuantity>((event, emit) async {
  emit(UpdateCartProcessing());
  try {
    await _cartRepository.updateCart(
      event.userId,
      event.cartId,
      event.quantity + 1,  // Increment
    );
    emit(UpdateCartSuccess());
  } catch (e) {
    emit(UpdateCartFailure());
  }
});
```

---

## Penjelasan Widget

### 1. Reusable Components

#### MyTextField

**File**: `lib/components/my_text_field.dart`

Widget text field yang reusable untuk form input:

```dart
class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
        // ...
      ),
    );
  }
}
```

**Penggunaan**:

```dart
MyTextField(
  hintText: 'Email',
  controller: _emailController,
)
```

#### Macro Widget

**File**: `lib/components/macro.dart`

Widget untuk menampilkan informasi nutrisi (calories, protein, carbs, fat):

```dart
class MyMacroWidget extends StatelessWidget {
  final String title;  // "Protein", "Carbs", dll
  final int value;     // Nilai numerik
  final IconData icon; // Icon untuk ditampilkan

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [/* shadow */],
        ),
        child: Column(
          children: [
            FaIcon(icon, color: Colors.redAccent),
            Text('$value $title'),  // "25g Protein"
          ],
        ),
      ),
    );
  }
}
```

**Penggunaan**:

```dart
Row(
  children: [
    MyMacroWidget(title: 'Calories', value: 285, icon: Icons.fire),
    MyMacroWidget(title: 'Protein', value: 12, icon: Icons.fitness_center),
    MyMacroWidget(title: 'Carbs', value: 34, icon: Icons.grain),
    MyMacroWidget(title: 'Fat', value: 10, icon: Icons.water_drop),
  ],
)
```

### 2. Cart Badge

**File**: `lib/screens/home/components/cart_badge.dart`

Menampilkan icon cart dengan badge jumlah item:

```dart
class CartBadgeWidget extends StatelessWidget {
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCartBloc, GetCartState>(
      builder: (context, state) {
        int itemCount = 0;
        if (state is GetCartSuccess) {
          // Hitung total quantity
          itemCount = state.carts.fold(0, (sum, cart) => sum + cart.quantity);
        }

        return Stack(
          children: [
            IconButton(onPressed: onTap, icon: Icon(Icons.shopping_cart)),
            if (itemCount > 0)
              Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: Text('$itemCount', style: TextStyle(fontSize: 10)),
                ),
              ),
          ],
        );
      },
    );
  }
}
```

### 3. Pizza Tags Row

**File**: `lib/screens/home/components/pizza_tags_row.dart`

Menampilkan tags seperti "Vegetarian", "Spicy":

```dart
class PizzaTagsRow extends StatelessWidget {
  final Pizza pizza;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (pizza.isVegetarian)
          _buildTag('Vegetarian', Colors.green),
        if (pizza.isSpicy)
          _buildTag('Spicy', Colors.red),
      ],
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(color: color, fontSize: 10)),
    );
  }
}
```

### 4. Quantity Button

**File**: `lib/screens/cart/components/quantity_button.dart`

Tombol + dan - untuk mengubah quantity di cart:

```dart
class QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
```

### 5. Details Screen Widgets

#### PizzaImage

**File**: `lib/screens/home/components/details/pizza_image.dart`

```dart
class PizzaImage extends StatelessWidget {
  final String picture;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      child: Image.network(picture, fit: BoxFit.cover),
    );
  }
}
```

#### PizzaInfo

**File**: `lib/screens/home/components/details/pizza_info.dart`

Menampilkan detail pizza:

```dart
class PizzaInfo extends StatelessWidget {
  final Pizza pizza;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nama & kategori
        Text(pizza.name, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        Text(pizza.category, style: TextStyle(color: Colors.grey)),

        SizedBox(height: 20),

        // Macros
        Row(
          children: [
            MyMacroWidget(title: 'Calories', value: pizza.macros.calories, icon: ...),
            MyMacroWidget(title: 'Protein', value: pizza.macros.protein, icon: ...),
            // ...
          ],
        ),

        SizedBox(height: 20),

        // Description
        Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
        Text(pizza.description),
      ],
    );
  }
}
```

---

## Navigation Flow

### Screen Navigation Diagram

```
                    ┌─────────────────┐
                    │  Welcome Screen │
                    │ (Not Auth)      │
                    └────────┬────────┘
                             │ Sign In/Sign Up Success
                             ↓
                    ┌─────────────────┐
                    │   Home Screen   │◄───────┐
                    │ (Pizza List)    │        │
                    └────────┬────────┘        │
                             │                 │
         ┌───────────────────┼─────────────────┤
         │                   │                 │
         ↓                   ↓                 │
  ┌──────────────┐   ┌──────────────┐          │
  │Details Screen│   │  Cart Screen │          │
  │(Pizza Detail)│   │(Shopping Cart)│          │
  └──────┬───────┘   └──────┬───────┘          │
         │                   │                  │
         └───────────────────┴──────────────────┘
                             │
                    (Back button / Sign Out)
                             ↓
                    ┌─────────────────┐
                    │  Welcome Screen │
                    └─────────────────┘
```

### Navigation Code Examples

#### Navigate to Details

**File**: `lib/screens/home/views/home_screen.dart`

```dart
void _navigateToDetails(Pizza pizza) {
  // Baca BLoC sebelum navigate
  final addCartBloc = context.read<AddCartBloc>();

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          // Provide BLoC yang sama ke screen tujuan
          BlocProvider.value(value: addCartBloc),
        ],
        child: DetailsScreen(pizza, _userId),
      ),
    ),
  );
}
```

#### Navigate to Cart

**File**: `lib/screens/home/views/home_screen.dart`

```dart
void _navigateToCart() {
  // Baca semua BLoC yang dibutuhkan
  final authBloc = context.read<AuthenticationBloc>();
  final cartBloc = context.read<GetCartBloc>();
  final updateCartBloc = context.read<UpdateCartBloc>();

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: authBloc),
          BlocProvider.value(value: cartBloc),
          BlocProvider.value(value: updateCartBloc),
        ],
        child: const CartScreen(),
      ),
    ),
  );
}
```

#### Sign Out & Navigate Back

```dart
TextButton(
  onPressed: () {
    Navigator.pop(context);  // Tutup dialog
    bloc.add(SignOutRequired());  // Trigger sign out
  },
  child: const Text('Sign Out'),
)
```

### MultiBlocProvider untuk Navigation

Ketika navigate ke screen baru, seringkali perlu memberikan BLoC yang sama:

```dart
MultiBlocProvider(
  providers: [
    BlocProvider.value(value: existingBloc1),  // Gunakan BLoC yang sudah ada
    BlocProvider.value(value: existingBloc2),
    BlocProvider(create: (context) => NewBloc()),  // Atau buat baru
  ],
  child: TargetScreen(),
)
```

---

## Tips Belajar Flutter

### Konsep Penting

1. **Widget Tree**
   - Semua di Flutter adalah widget
   - Widget bersarang membentuk tree
   - `build()` method dipanggil saat state berubah

2. **StatefulWidget vs StatelessWidget**
   - `StatelessWidget`: Tidak ada internal state yang berubah
   - `StatefulWidget`: Memiliki `State` object yang bisa berubah

3. **BLoC Pattern**
   - Event → BLoC → State → UI
   - Pisahkan business logic dari UI
   - Gunakan `BlocBuilder` untuk rebuild UI
   - Gunakan `BlocListener` untuk side effects (navigation, snackbar)

4. **Repository Pattern**
   - Abstraksi akses data
   - Mudah untuk testing
   - Bisa ganti implementation tanpa mengubah UI

### Best Practices

1. **Separation of Concerns**
   ```
   screens/
   ├── views/        # UI saja
   ├── components/   # Reusable widgets
   └── blocs/        # Business logic
   ```

2. **Dependency Injection**
   ```dart
   // Gunakan RepositoryProvider dan BlocProvider
   RepositoryProvider(create: (_) => MyRepository())
   BlocProvider(create: (_) => MyBloc(repository))
   ```

3. **Responsive Design**
   ```dart
   // Gunakan MediaQuery untuk responsive
   final screenWidth = MediaQuery.of(context).size.width;
   SizedBox(width: screenWidth * 0.04)
   ```

4. **Error Handling**
   ```dart
   try {
     // operation
   } catch (e) {
     emit(ErrorState());
   }
   ```

---

## Summary

### Pizza List Flow
1. `GetPizzaBloc` fetch data dari `PizzaRepository`
2. Repository ambil data dari Firestore
3. BLoC emit `GetPizzaSuccess(pizzas)`
4. `BlocBuilder` rebuild dengan `GridView.builder`
5. Setiap item menggunakan `PizzaGridItem` widget

### Cart Transaction Flow
1. User klik "Add to Cart"
2. `AddCartBloc` simpan ke Firestore via `CartRepository`
3. Setelah success, `GetCartBloc` refresh cart data
4. Cart badge update jumlah item
5. User bisa navigate ke `CartScreen` untuk lihat semua item

### Key Takeaways
- **BLoC** untuk state management (Event → State)
- **Repository** untuk data access abstraction
- **BlocProvider** untuk inject BLoC ke widget tree
- **BlocBuilder** untuk rebuild UI based on state
- **BlocListener** untuk side effects
- **MultiBlocProvider** untuk multiple BLoC dalam satu screen

---

**Selamat belajar Flutter!** 🚀

Jika ada pertanyaan tentang flow atau bagian tertentu, jangan ragu untuk bertanya.
