import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';

class Cartcard extends StatelessWidget {
  Cartcard({super.key, required this.model, required this.ontab,required this.ontab1,required this.ontab2});

  dynamic model;

  void Function() ontab;
  void Function() ontab1;
  void Function() ontab2;


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Image
              Container(
                width: width * 0.25,
                height: width * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image:  DecorationImage(
                    image: NetworkImage("${model.product.image!}"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      "${model.product.name}",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children:  [
                        Text(
                          model.product.price.toString(),
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                       if(model.product.discount!=0) Text(
                         model.product.oldPrice.toString(),
                         style: TextStyle(
                           fontSize: 14,
                           decoration: TextDecoration.lineThrough,
                           color: Colors.grey,
                         ),
                       ),
                        if(model.product.discount!=0) SizedBox(width: 8),
                        if(model.product.discount!=0)  Text(
                          "${model.product.discount}% OFF",
                          style: TextStyle(color: maincolor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text("Size", style: TextStyle(fontSize: 14)),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: ontab,
                          icon: const Icon(Icons.remove),
                        ),
                         Text(model.quantity.toString()),
                        IconButton(
                          onPressed:ontab1,
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 30),
          // Remove Button
          GestureDetector(
            onTap: ontab2,
            child: Row(
              children:  [
                Icon(Icons.delete, color: maincolor),
                SizedBox(width: 8),
                Text("Remove", style: TextStyle(color: maincolor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
