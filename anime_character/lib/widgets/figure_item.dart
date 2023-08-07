import 'package:flutter/material.dart';

import '../consts.dart';
import '../models/action_figure_model.dart';

class FigureItem extends StatelessWidget {
  const FigureItem({
    super.key,
    required this.figure,
  });
  final ActionFigureModel figure;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 300,
          height: 440,
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    color: black.withOpacity(0.25)),
                const BoxShadow(offset: Offset(5, 0), color: white),
                const BoxShadow(offset: Offset(-5, 0), color: white),
              ]),
        ),
        Container(
          width: 300,
          padding: const EdgeInsets.only(left: 20.0, right: 25.0, bottom: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/${figure.image}',
                width: 300 - 45,
                height: 330.0,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 210,
                    child: Column(
                      children: [
                        Text(
                          '${figure.caracter} | ${figure.title}',
                          maxLines: 1,
                          style: poppins.copyWith(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: black),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rate_rounded,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text('${figure.rate}',
                                    style: poppins.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: black.withOpacity(0.6),
                                    )),
                              ],
                            ),
                            // Text('${figure.caracter} | ${figure.title}', maxLines: 1, style: poppins.copyWith(
                            //   fontWeight: FontWeight.bold,
                            //   color: black.withOpacity(0.6),
                            // ),),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.shopping_cart_outlined,
                                  color: black.withOpacity(0.6),
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${figure.sold}',
                                  style: poppins.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: black.withOpacity(0.6),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.5),
                      color: bgColor,
                    ),
                    child: Icon(Icons.favorite_rounded, color: Colors.red,),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'USD ${figure.price}',
                style: poppins.copyWith(
                    color: green, fontSize: 24.0, fontWeight: FontWeight.bold),
              )
            ],
          ),
        )
      ],
    );
  }
}