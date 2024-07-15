import 'package:flutter/material.dart';
import 'package:shop_app/global_variables.dart';
import 'package:shop_app/widgets/product_card.dart';
import 'package:shop_app/pages/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProducLlistState();
}

class _ProducLlistState extends State<ProductList> {
  final List<String> filters = const ["All", "Addidas", "Nike", "Bata"];
  late String activeFilter;

  @override
  void initState() {
    super.initState();
    activeFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(30),
      ),
    );
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Shoes \nCollection",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Flexible(
                fit: FlexFit.tight,
                child: TextField(
                  //TODO: change search style
                  style: TextStyle(color: Colors.red),
                  decoration: InputDecoration(
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search",
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        activeFilter = filter;
                      });
                    },
                    child: Chip(
                      backgroundColor: activeFilter == filter
                          ? Theme.of(context).primaryColor
                          : const Color.fromRGBO(245, 247, 249, 1),
                      labelStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      side: const BorderSide(
                        color: Color.fromRGBO(245, 247, 249, 1),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      label: Text(filter),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: size.width > 1050
                ? GridView.builder(
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.50, crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      final title = products[index]['title'];
                      final imageUrl = products[index]['imageUrl'];
                      final price = products[index]['price'];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return ProductDetailsPage(product: products[index]);
                          }));
                        },
                        child: ProductCard(
                          title: title.toString(),
                          imageUrl: imageUrl.toString(),
                          price: price.toString(),
                          index: index,
                        ),
                      );
                    })
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final title = products[index]['title'];
                      final imageUrl = products[index]['imageUrl'];
                      final price = products[index]['price'];

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return ProductDetailsPage(product: products[index]);
                          }));
                        },
                        child: ProductCard(
                          title: title.toString(),
                          imageUrl: imageUrl.toString(),
                          price: price.toString(),
                          index: index,
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
