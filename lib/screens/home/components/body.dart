import 'package:flutter/material.dart';
import 'package:grocery/constants/common_functions.dart';
import 'package:grocery/constants/dimension.dart';
import 'package:grocery/models/product_model.dart';
import 'package:grocery/provider/product_provider.dart';
import 'package:grocery/screens/home/components/heaading_bar.dart';
import 'package:grocery/screens/home/components/swiper_images.dart';
import 'package:grocery/screens/on%20sale/on_sale_screen.dart';
import 'package:grocery/widgets/feed_items_widget.dart';
import 'package:grocery/widgets/on_sale_widget.dart';
import 'package:grocery/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class BodyHomeScreen extends StatelessWidget {
  const BodyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppDimensions dimensions = AppDimensions(context);
    final productProvider = Provider.of<ProductProvider>(context);
    List<ProductModel> allProducts = productProvider.getProducts;
    List<ProductModel> onSaleProducts = productProvider.onSale;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SwiperImages(),
          TextButton(
            onPressed: () {
              CommonFunction.navigateToPage(
                  context: context, routeName: OnSaleScreen.routeName);
            },
            child: TextWidget(
              text: 'View All',
              color: Colors.blue,
              textSize: dimensions.getScreenW(18),
              maxLines: 1,
            ),
          ),
          SizedBox(
            height: dimensions.getScreenH(200),
            child: ListView.builder(
              itemCount: onSaleProducts.length < 4 ? onSaleProducts.length : 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: onSaleProducts[index],
                  child: const OnSaleWidget(),
                );
              },
            ),
          ),
          SizedBox(
            height: dimensions.getScreenH(5),
          ),
          const HeadingsBar(),
          GridView.count(
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            children: List.generate(
              allProducts.length < 4 ? allProducts.length : 4,
              (index) {
                return ChangeNotifierProvider.value(
                  value: allProducts[index],
                  child: const FeedsWidgets(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
