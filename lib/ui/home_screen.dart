import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int imageIndex = 2;
  List<dynamic> products = [];

  
  Future<void> getProductData() async {
    try {
      final uri = Uri.parse('https://fakestoreapi.com/products');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        
        final data = json.decode(response.body);
        setState(() {
          products = data;
        });
      } else {
        print('Failed to fetch products');
      }
    } catch (e) {
      print(e);
      print('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/$imageIndex.jpg'),
                      fit: BoxFit.fill),
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Container(
                    height: 50,
                    color: Colors.black.withOpacity(0.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Number $imageIndex',
                          style:
                              const TextStyle(fontSize: 17, color: Colors.white),
                        ),
                        const Icon(Icons.favorite, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (imageIndex > 1) {
                        imageIndex--;
                      } else {
                        imageIndex = 4;
                      }
                      setState(() {});
                    },
                    child: const Icon(Icons.arrow_back_ios),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (imageIndex < 4) {
                        imageIndex++;
                      } else {
                        imageIndex = 1;
                      }
                      setState(() {});
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  getProductData(); 
                },
                child: const Text('Load Products'),
              ),
              const SizedBox(height: 20),
              
              products.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ListTile(
                            leading: Image.network(
                              product['image'],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(product['title']),
                            subtitle: Text('\$${product['price']}'),
                          );
                        },
                      ),
                    )
                  : const Text('No products loaded'),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
