import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final List<Map<String, dynamic>> productinfo = [
  {"productId": 1, "name": "shirt", "size": "small", "color": "red", "type": "V"},
  {"productId": 2, "name": "T-shirt", "size": "medium", "color": "green", "type": "V"},
  {"productId": 3, "name": "shirt", "size": "Large", "color": "yellow", "type": "V"},
  {"productId": 4, "name": "T-shirt", "size": "medium", "color": "red", "type": "Round"},
  {"productId": 5, "name": "T-shirt", "size": "Large", "color": "green", "type": "Round"},
];

class _HomeState extends State<Home> {
  List<String> colors = productinfo.map((e) => e["color"] as String).toSet().toList();
  List<Map<String, dynamic>> sizes = [];
  Map<String, dynamic> selectedProduct = {};
  String? selectedColor;

  @override
  Widget build(BuildContext context) {
    if (selectedColor != null) {
      colors = colors.where((element) => element == selectedColor).toList();
      sizes = productinfo.where((element) => element['color'] == selectedColor).toList();
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Demo'),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                width: 200,
                child: ListView.separated(
                  itemCount: colors.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final color = colors[index];
                    return InkWell(
                      onTap: () => selectProduct(color),
                      child: Container(
                        height: 30,
                        width: 40,
                        decoration: BoxDecoration(border: Border.all(), color: getColor(color)),
                        child: Center(
                          child: Text(
                            color,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              if (selectedColor != null)
                ListView.builder(
                    itemCount: sizes.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Center(child: InkWell(onTap: () => selectProductSize(sizes[index]), child: Text(sizes[index]["size"])));
                    }),
              const SizedBox(
                height: 20,
              ),
              if (selectedProduct.isNotEmpty) Text(selectedProduct["type"])
            ],
          ),
        ));
  }

  Color getColor(String name) {
    switch (name) {
      case 'red':
        return Colors.red;
      case 'yellow':
        return Colors.yellow;
      case 'green':
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  void selectProduct(String color) {
    setState(() {
      selectedColor = color;
    });
  }

  void selectProductSize(Map<String, dynamic> product) {
    setState(() {
      selectedProduct = product;
    });
  }
}
