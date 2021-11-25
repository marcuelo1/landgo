import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ryve_mobile/features/sellers/controllers/seller_controller.dart';
import 'package:ryve_mobile/features/sellers/views/show_seller.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/core/styles/shared_style.dart';
import 'package:ryve_mobile/core/widgets/shared_widgets.dart';
import 'package:provider/provider.dart';
import 'package:ryve_mobile/core/models/seller_model.dart';

class Sellers extends StatefulWidget {
  static const String routeName = "sellers";

  @override
  _SellersState createState() => _SellersState();
}

class _SellersState extends State<Sellers> {
  // url
  // variables for scale functions
  late double width;
  late double height;
  late double scale;
  late SellerController con;
  // dimensions
  final double categoryImage = 50;

  Map category = {};
  Map selected_location = {};

  @override
  void initState() {
    super.initState();
    con = Provider.of<SellerController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

    return content(context);
  }

//Still not working
  Widget content(BuildContext context) {
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    category = args['category'];
    selected_location = args['selected_location'];
    con.getSellersData(category);

    return SafeArea(
        child: Scaffold(
      body: Scaffold(
        appBar: SharedWidgets.appBar(context,
            title: category['name'], showCart: true),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Padding(
                padding: EdgeInsets.fromLTRB(
                    SharedFunction.scaleWidth(10, width),
                    SharedFunction.scaleHeight(19, height),
                    SharedFunction.scaleWidth(10, width),
                    SharedFunction.scaleHeight(0, height)),
                child: Consumer<SellerController>(
                  builder: (_, _sellers, __) {
                    return Column(
                      children: [
                        // search bar
                        // category deals
                        // top stores
                        topSellers(_sellers.topSellers),
                        // recent stores
                        recentSellers(_sellers.recentSellers),
                        // all stores
                        allStores(_sellers.allSellers),
                      ],
                    );
                  },
                )),
          ),
        ),
      ),
    ));
  }

  // Widget categoryDeals() {
  //   // 4 deals per row
  //   return Column(
  //     children: [
  //       for (var i = 0; i < category_deals.length; i += 4) ...[
  //         categoryDealsRow(i),
  //         SizedBox(
  //           height: SharedFunction.scaleHeight(15, height),
  //         )
  //       ]
  //     ],
  //   );
  // }

  // Widget categoryDealsRow(int i) {
  //   List<Widget> row = [];
  //   // to put size boxes on empty slots in row
  //   for (var j = i; j < (i + 4); j++) {
  //     if (j < category_deals.length) {
  //       row.add(categoryDeal(category_deals[j]));
  //       row.add(SizedBox(
  //         width: SharedFunction.scaleWidth(15, width),
  //       ));
  //     } else {
  //       row.add(SizedBox());
  //     }
  //   }

  //   return Row(
  //     mainAxisSize: MainAxisSize.min,
  //     children: row,
  //   );
  // }

  // Widget categoryDeal(Map categoryDeal) {
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       // image
  //       categoryDealImage(categoryDeal['image']),
  //       // space
  //       SizedBox(
  //         height: SharedFunction.scaleHeight(5, height),
  //       ),
  //       // name
  //       categoryDealName(categoryDeal['name'])
  //     ],
  //   );
  // }

  // Widget categoryDealImage(String url) {
  //   return Container(
  //     width: SharedFunction.scaleWidth(categoryImage, width),
  //     height: SharedFunction.scaleWidth(categoryImage, width),
  //     child: Image.network(
  //       url,
  //       fit: BoxFit.contain,
  //     ),
  //   );
  // }

  // Widget categoryDealName(String name) {
  //   return Text(name);
  // }

  Widget topSellers(top_sellers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // title
        title("Top Sellers"),
        // stores sliders
        sellerSliders(context, top_sellers)
      ],
    );
  }

  Widget recentSellers(recent_sellers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // title
        title("Recent"),
        // stores sliders
        sellerSliders(context, recent_sellers)
      ],
    );
  }

  Widget allStores(all_sellers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // title
        title("All Stores"),
        // stores
        for (var seller in all_sellers) ...[
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ShowSeller.routeName,
                    arguments: seller);
              },
              child: SharedWidgets.seller(seller, width, height))
        ]
      ],
    );
  }

  Widget title(String name) {
    return Text(
      name,
      style: SharedStyle.title,
    );
  }

  Widget sellerSliders(BuildContext context, List _sellers) {
    return Container(
      constraints: BoxConstraints.tightFor(width: double.infinity),
      child: CarouselSlider(
        options: CarouselOptions(
            enableInfiniteScroll: false,
            height: SharedFunction.scaleHeight(
                SharedWidgets.sellerFinalHeight, height),
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {}),
        items: [
          for (SellerModel seller in _sellers) ...[
            Padding(
              padding:
                  EdgeInsets.only(right: SharedFunction.scaleWidth(15, width)),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ShowSeller.routeName,
                        arguments: seller);
                  },
                  child: SharedWidgets.seller(seller, width, height)),
            )
          ]
        ],
      ),
    );
  }
}
