import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatefulWidget {
  final String shoesName;
  final String brand;
  final int price;
  final String shoesImg;

  const ProductCard({
    super.key,
    required this.shoesName,
    required this.brand,
    required this.price,
    required this.shoesImg,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final formatCurrency = NumberFormat.simpleCurrency(locale: "ko_KR");
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Image.network(
              widget.shoesImg,
              fit: BoxFit.cover,
              width: 160,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 160,
                ),
                child: Text(
                  widget.shoesName,
                  maxLines: 2,
                ),
              ),
              Text(
                widget.brand,
                style: const TextStyle(fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                formatCurrency.format(widget.price),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    );
  }
}
