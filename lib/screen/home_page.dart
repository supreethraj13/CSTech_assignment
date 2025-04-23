import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List banners = [];
  List categories = [];
  List products = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    final res = await http.get(Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/home/withoutPrice'));
    final data = jsonDecode(res.body);

    if (data['status'] == 1) {
      setState(() {
         banners = data['data']['banner_one'] ?? [];
        categories = data['data']['category'] ?? [];
        products = data['data']['products'] ?? [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: "Deals"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.menu),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search here",
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 0),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.notifications_none),
                        ],
                      ),
                      SizedBox(height: 10),

                      // Banner
                      Container(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: banners.length,
                          itemBuilder: (context, index) {
                            final bannerUrl = banners[index]['banner'] ?? '';
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: bannerUrl.isNotEmpty
                                  ? Image.network(bannerUrl)
                                  : Container(width: 100, color: Colors.grey), // fallback
                            );
                          },
                        ),
                      ),

                      // KYC Card
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 12),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text("KYC Pending", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                            Text(
                              "You need to provide the required documents for your account activation.",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            TextButton(
                              onPressed: () {}, // handle click
                              child: Text("Click Here", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),

                      // Categories
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: categories.take(4).map((cat) {
                          final label = cat['label'] ?? 'No Label';
                          final iconUrl = cat['icon'] ?? '';
                          return Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey.shade200,
                                backgroundImage: iconUrl.isNotEmpty ? NetworkImage(iconUrl) : null,
                                child: iconUrl.isEmpty ? Icon(Icons.device_unknown) : null,
                              ),
                              SizedBox(height: 5),
                              Text(label),
                            ],
                          );
                        }).toList(),
                      ),

                      // Exclusive Products
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            final imageUrl = product['icon'] ?? '';
                            final label = product['label'] ?? 'No Name';
                            final sublabel = product['SubLabel'] ?? product['Sublabel'] ?? '';

                            return Container(
                              width: 140,
                              margin: EdgeInsets.only(right: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: imageUrl.isNotEmpty
                                        ? Image.network(imageUrl, fit: BoxFit.cover)
                                        : Container(color: Colors.grey),
                                  ),
                                  Text(label, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w600)),
                                  Text(sublabel, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Colors.grey)),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
