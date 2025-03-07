import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wholesalehub_app/feature/auth/presentation/view_model/profile/bloc/profile_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  File? _img;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().loadClient();
  }

  Future _browseImage(ImageSource imagesource) async {
    try {
      final image = await ImagePicker().pickImage(source: imagesource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                InfoCard(
                    image: 'assets/images/shoe2.jpg',
                    name: "Men's Casual Sneaker Shoes",
                    details: "Bulk deals on formal and casual shoes."),
                InfoCard(
                    image: 'assets/images/shoe3.jpg',
                    name: "Women's Shoes",
                    details: "Trendy and comfortable designs."),
                InfoCard(
                    image: 'assets/images/kids.jpeg',
                    name: "Kids' Shoes",
                    details: "Stylish footwear for the little ones."),
                InfoCard(
                    image: 'assets/images/running shoe.jpg',
                    name: "Sports Shoes",
                    details: "Best-in-class shoes for athletes."),
                InfoCard(
                    image: 'assets/images/shoe1.png',
                    name: "Formal Shoes",
                    details: "Versatile designs."),
                InfoCard(
                    image: 'assets/images/boot.jpeg',
                    name: "Boots",
                    details: "Durable and stylish boots for all."),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  ListTile(
                    leading: Icon(Icons.shopping_bag, color: Colors.green),
                    title: Text('Order #5678 confirmed'),
                    subtitle: Text('2 hours ago'),
                  ),
                  ListTile(
                    leading: Icon(Icons.store, color: Colors.blue),
                    title: Text('New stock added: 50 pairs of Nike Air Max'),
                    subtitle: Text('1 day ago'),
                  ),
                  ListTile(
                    leading: Icon(Icons.group, color: Colors.purple),
                    title: Text('New client registered: John Doe'),
                    subtitle: Text('3 days ago'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String image;
  final String name;
  final String details;

  const InfoCard({
    super.key,
    required this.image,
    required this.name,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(image, height: 60),
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              details,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
