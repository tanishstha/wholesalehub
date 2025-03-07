import 'package:flutter/material.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> products = [
    {
      "image": "assets/images/shoe2.jpg",
      "name": "Men's Casual Sneaker Shoes",
      "details": "Bulk deals on formal and casual shoes."
    },
    {
      "image": "assets/images/shoe3.jpg",
      "name": "Women's Shoes",
      "details": "Trendy and comfortable designs."
    },
    {
      "image": "assets/images/kids.jpeg",
      "name": "Kids' Shoes",
      "details": "Stylish footwear for the little ones."
    },
    {
      "image": "assets/images/running shoe.jpg",
      "name": "Sports Shoes",
      "details": "Best-in-class shoes for athletes."
    },
    {
      "image": "assets/images/shoe1.png",
      "name": "Formal Shoes",
      "details": "Versatile designs."
    },
    {
      "image": "assets/images/boot.jpeg",
      "name": "Boots",
      "details": "Durable and stylish boots for all."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          product["image"]!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        product["name"]!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(
                        product["details"]!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
