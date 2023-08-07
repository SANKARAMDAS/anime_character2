import 'package:anime_character/consts.dart';
import 'package:anime_character/models/action_figure_model.dart';
import 'package:anime_character/pages/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_bar_button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.figure});
  final ActionFigureModel figure;
  
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TapDownDetails? tapDownDetails;
  TransformationController? transformationController;
  bool zoomed = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    transformationController = TransformationController();
    transformationController!.value = Matrix4.identity()..scale(0.8);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    transformationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ActionFigureModel figure = widget.figure;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leadingWidth: 75,
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Row(
          children: [
            SizedBox(
              width: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: AppBarButton(
                icon: Icons.arrow_back,
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Stack(
                children: [
                  const AppBarButton(icon: Icons.shopping_cart_outlined),
                  Positioned(
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: Text(
                        '3',
                        style: poppins.copyWith(color: white, fontSize: 10),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 30,
              ),
            ],
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.7,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      double scale = 0.8;
                      final value = Matrix4.identity()..scale(scale);
                      transformationController!.value = value;
                      setState(() {
                        zoomed = false;
                      });
                    },
                      onDoubleTap: () {
                      double scale = 2;
                      final x = -tapDownDetails!.localPosition.dx * (scale -1);
                      final y = -tapDownDetails!.localPosition.dy * (scale -1);
                      final value = Matrix4.identity()..translate(x, y)..scale(scale);
                      transformationController!.value = value;
                      setState(() {
                        zoomed = true;
                      });
                      },
                    onDoubleTapDown: (details) => tapDownDetails = details,
                      child: InteractiveViewer(
                        transformationController: transformationController,
                          alignment: Alignment.topCenter,
                          child: Image.asset('assets/${widget.figure.image}',
                          width: size.width,
                          height: size.height * 0.7,),),),
                  Positioned(
                    bottom: 80,
                      child: SizedBox(
                        width: size.width,
                        height: 45,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              bottom: 15,
                              child: Opacity(
                                opacity: zoomed ? 0 : 1,
                                child: ClipPath(
                                  clipper: CustomCip(),
                                  child: Container(
                                    width: size.width, height: 45, color: green,),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                                child: Opacity(
                                  opacity: zoomed ? 0.6 : 1,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      color: green, shape: BoxShape.circle
                                    ),
                                    child: const Icon(Icons.code_sharp, color: white,),
                                  ),
                                ),),
                          ],
                        ),
                      ),),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
                child: Container(
                  width: size.width,
                  height: size.height * 0.3,
                  padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 30,
                  ),
                  decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 210,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Text('${figure.rate} | ${figure.reviews} Reviews',
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
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Specifications', style: poppins.copyWith(fontWeight: FontWeight.bold),),
                          Icon(Icons.keyboard_arrow_up_outlined, color: black.withOpacity(0.6),),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText( text: TextSpan( style: poppins,
                                children: [
                                TextSpan(text: 'Size: '),
                                TextSpan(text: '${figure.spesification.size}'),
                              ],),),
                              RichText( text: TextSpan( style: poppins,
                                children: [
                                  TextSpan(text: 'Material: '),
                                  TextSpan(text: '${figure.spesification.material}'),
                                ],),),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText( text: TextSpan( style: poppins,
                                children: [
                                  TextSpan(text: 'Type: '),
                                  TextSpan(text: '${figure.spesification.type}'),
                                ],),),
                              RichText( text: TextSpan( style: poppins,
                                children: [
                                  TextSpan(text: 'Condition: '),
                                  TextSpan(text: '${figure.spesification.condition}'),
                                ],),),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Price', style: poppins.copyWith(fontSize: 16),),
                              Text('Us \$${figure.price}', style: poppins.copyWith(fontSize: 28, fontWeight: FontWeight.bold),)
                            ],
                          ),
                          Container(
                            height: 70,
                            width: size.width * 0.5,
                            decoration: BoxDecoration(
                                color: green, borderRadius: BorderRadius.circular(15)
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.shopping_cart_outlined, color: white,
                                ),
                                SizedBox(width: 10.0,),
                                Text(
                                  'Add to Cart',
                                  style: poppins.copyWith(color: white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
            ),),
          ],
        ),
      ),
    );
  }
}

class CustomCip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.quadraticBezierTo(size.width /2, size.height *2, size.width, 0);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(size.width / 2, size.height *2 -7, 0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
