import 'package:flutter/material.dart';

import '../consts.dart';
import '../models/category_model.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
    required this.selected,
  });
  final Category category;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      decoration: BoxDecoration(
          color: selected ? green : white,
          borderRadius: BorderRadius.circular(30.0)),
      child: Row(
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? white : black.withOpacity(0.5)),
            child: Image.asset('assets/${category.image}'),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            category.category,
            style: poppins.copyWith(
                color: selected ? white : black.withOpacity(0.7),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}