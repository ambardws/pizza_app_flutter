/// Script untuk menambahkan 6 data pizza ke Firebase Firestore
///
/// CARA PAKAI:
/// 1. Buka lib/screens/home/views/home_screen.dart
/// 2. Di initState(), tambahkan: SeedPizzaData().seed();
/// 3. Run app sekali, data akan masuk ke Firebase
/// 4. Hapus/komentari line setelah data masuk

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class SeedPizzaData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Seed 6 data pizza ke Firebase
  /// Hanya menambahkan pizza yang BELUM ada
  Future<void> seed() async {
    try {
      log('🍕 Starting pizza seed...');

      // Ambil semua pizza yang sudah ada
      final existingSnapshot = await _firestore.collection('pizzas').get();
      final existingIds = existingSnapshot.docs.map((doc) => doc.id).toSet();

      log('📦 Found ${existingIds.length} existing pizzas in database');

      // Data 6 Pizza
      final pizzaData = [
        {
          'pizzaId': 'pizza_001',
          'name': 'Margherita Classic',
          'description': 'Classic Italian pizza with fresh mozzarella, tomatoes, and basil',
          'picture': 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=500',
          'price': 12,
          'discount': 0,
          'isVeg': true,
          'spicy': 0,
          'macros': {
            'calories': 285,
            'proteins': 12,
            'fat': 10,
            'carbs': 34,
          },
        },
        {
          'pizzaId': 'pizza_002',
          'name': 'Pepperoni Feast',
          'description': 'Loaded with premium pepperoni and mozzarella cheese',
          'picture': 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=500',
          'price': 15,
          'discount': 5,
          'isVeg': false,
          'spicy': 1,
          'macros': {
            'calories': 320,
            'proteins': 14,
            'fat': 14,
            'carbs': 36,
          },
        },
        {
          'pizzaId': 'pizza_003',
          'name': 'Veggie Supreme',
          'description': 'Bell peppers, mushrooms, onions, olives, and tomatoes',
          'picture': 'https://images.unsplash.com/photo-1511689660979-10d2b1aada49?w=500',
          'price': 14,
          'discount': 0,
          'isVeg': true,
          'spicy': 0,
          'macros': {
            'calories': 260,
            'proteins': 10,
            'fat': 9,
            'carbs': 38,
          },
        },
        {
          'pizzaId': 'pizza_004',
          'name': 'Spicy BBQ Chicken',
          'description': 'Grilled chicken with BBQ sauce, jalapeños, and cilantro',
          'picture': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500',
          'price': 16,
          'discount': 10,
          'isVeg': false,
          'spicy': 2,
          'macros': {
            'calories': 350,
            'proteins': 18,
            'fat': 15,
            'carbs': 32,
          },
        },
        {
          'pizzaId': 'pizza_005',
          'name': 'Four Cheese Delight',
          'description': 'Mozzarella, cheddar, parmesan, and gorgonzola blend',
          'picture': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500',
          'price': 14,
          'discount': 0,
          'isVeg': true,
          'spicy': 0,
          'macros': {
            'calories': 310,
            'proteins': 15,
            'fat': 16,
            'carbs': 28,
          },
        },
        {
          'pizzaId': 'pizza_006',
          'name': 'Mediterranean Special',
          'description': 'Feta cheese, spinach, sun-dried tomatoes, and olives',
          'picture': 'https://images.unsplash.com/photo-1595708684082-a173bb3a06c5?w=500',
          'price': 17,
          'discount': 8,
          'isVeg': true,
          'spicy': 0,
          'macros': {
            'calories': 275,
            'proteins': 11,
            'fat': 12,
            'carbs': 32,
          },
        },
      ];

      // Hanya tambahkan pizza yang BELUM ada
      final batch = _firestore.batch();
      int addedCount = 0;
      int skippedCount = 0;
      final addedNames = <String>[];
      final skippedNames = <String>[];

      for (final pizza in pizzaData) {
        final pizzaId = pizza['pizzaId'].toString();
        final name = pizza['name'];

        if (existingIds.contains(pizzaId)) {
          log('⏭️ Skipping $pizzaId - $name (already exists)');
          skippedCount++;
          skippedNames.add(name as String);
        } else {
          final docRef = _firestore.collection('pizzas').doc(pizzaId);
          batch.set(docRef, pizza);
          addedCount++;
          addedNames.add(name as String);
          log('➕ Adding $pizzaId - $name');
        }
      }

      if (addedCount == 0) {
        log('');
        log('✅ All pizzas already exist! No new data added.');
        log('📊 Total pizzas: ${existingIds.length}');
        return;
      }

      await batch.commit();

      log('');
      log('✅ Seed completed!');
      log('   ➕ Added: $addedCount pizzas');
      if (addedNames.isNotEmpty) {
        for (final name in addedNames) {
          log('      - $name');
        }
      }
      log('   ⏭️ Skipped: $skippedCount pizzas (already exist)');
      if (skippedNames.isNotEmpty) {
        for (final name in skippedNames) {
          log('      - $name');
        }
      }
      log('   📊 Total pizzas in database: ${existingIds.length + addedCount}');
      log('');
      log('🎉 Check Firebase Console → Firestore → pizzas collection');
    } catch (e) {
      log('❌ Error seeding data: $e');
      rethrow;
    }
  }
}
