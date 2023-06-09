import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery/constants/dimension.dart';
import 'package:grocery/provider/product_provider.dart';
import 'package:grocery/screens/details/components/content.dart';
import 'package:provider/provider.dart';

class BodyDetailsScreen extends StatelessWidget {
  const BodyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppDimensions dimensions = AppDimensions(context);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final productProvider = Provider.of<ProductProvider>(context);
    final currentProduct = productProvider.findById(productId);
    return Column(
      children: [
        Flexible(
          flex: 3,
          child: SizedBox(
            height: dimensions.getScreenH(300),
            width: double.infinity,
            child: FancyShimmerImage(
              imageUrl: currentProduct.productImageUrl,
              height: dimensions.getScreenH(250),
              width: dimensions.getScreenH(250),
              boxFit: BoxFit.cover,
            ),
          ),
        ),
        const Flexible(
          flex: 5,
          child: Content(),
        ),
      ],
    );
  }
}
