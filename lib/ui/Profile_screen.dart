import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  List<dynamic> products = []; 
  bool showGrid = false; 

  
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
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              Container(
                height: 600,
                child: ListView.separated(
                  itemCount: UserModel.userModelList.length,
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 0,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 100,
                          height: 100,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            UserModel.userModelList[index].image ??
                                'assets/image/4.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                        title: Text(
                          '${UserModel.userModelList[index].name ?? 'Enter your name'}',
                        ),
                        subtitle: Text(
                          '${UserModel.userModelList[index].titlejop ?? "Enter your job"}',
                        ),
                        trailing: Text('${UserModel.userModelList[index].age}'),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              
              ElevatedButton(
                onPressed: () {
                  getProductData(); 
                  setState(() {
                    showGrid = true; 
                  });
                },
                child: const Text('Load the Products'),
              ),

              const SizedBox(height: 20),

              
              showGrid && products.isNotEmpty
                  ? Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showGrid = !showGrid;
                            });
                          },
                          child: const Text('close Products'),
                        ),
                        Container(
                          height: 550, 
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.7, 
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        child: Image.network(
                                          product['image'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        product['title'],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Text('\$${product['price']}'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : const Text(''),
            ],
          ),
        ),
      ),
    );
  }
}
