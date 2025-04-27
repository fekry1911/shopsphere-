import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class CardCustom extends StatelessWidget {
   CardCustom({super.key,required this.model,required this.ontab,required this.FacCheck});

   dynamic model;
   bool FacCheck;
   void Function() ontab;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.start,
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Container(
                height: 200,
                child: Image.network(
                 model.image!,
                )),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "${model.name}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(

                    children: [
                      Text(
                        model.price
                            .toString()+"EGP",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                            FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model
                          .discount !=
                          0)
                        Text(
                          model.oldPrice
                              .toString()+"EGP",
                          style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration
                                .lineThrough,
                            decorationThickness: 2,
                            // Optional: Makes the line thicker
                            decorationColor: Colors.red,
                            // 🔥 Adds a middle line
                          ),
                        ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: ontab,
                      icon: FacCheck?Icon(Icons.favorite,color: maincolor,):Icon(
                          Icons.favorite_border))
                ],
              ),
            )
          ],
        ));
  }
}
