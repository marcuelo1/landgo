import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryve_mobile/core/models/product_model.dart';
import 'package:ryve_mobile/features/sellers/controllers/product_controller.dart';
import 'package:ryve_mobile/features/sellers/styles/product_style.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/core/styles/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/core/widgets/shared_widgets.dart';
import 'package:provider/provider.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);
  static const String routeName = "product";

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  // url
  String _dataUrl =
      "${SharedUrl.root}/${SharedUrl.version}/buyer/product_details";
  // variables for scale functions
  late double width;
  late double height;
  late double scale;
  late ProductController con;
  // dimensions
  final double productImageWidth = 325;
  final double productImageHeight = 200;
  final double quantityBarWidth = 100;
  final double quantityBarHeight = 35;
  final double addToBasketBtnWidth = 300;
  final double addToBasketBtnHeight = 60;

  Map seller = {};
  late ProductModel product;

  @override
  void initState() {
    super.initState();
    con = Provider.of<ProductController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

    return content(context);
  }

  Widget content(context) {
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    product = args['product'];
    print(product);
    con.getProductDetails(product);

    return SafeArea(
        child: Scaffold(
      appBar: SharedWidgets.appBar(context, title: seller['name']),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
              width: SharedFunction.scaleWidth(327, width),
              child: Consumer<ProductController>(
                builder: (_, _product, __) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // space
                      SizedBox(
                        height: SharedFunction.scaleHeight(20, height),
                      ),
                      // product image
                      productImage(product.image),
                      // space
                      SizedBox(
                        height: SharedFunction.scaleHeight(10, height),
                      ),
                      // product name
                      productName(product.name),
                      // space
                      SizedBox(
                        height: SharedFunction.scaleHeight(5, height),
                      ),
                      // product description
                      productDescription(product.description),
                      // space
                      SizedBox(
                        height: SharedFunction.scaleHeight(7, height),
                      ),
                      // product price
                      if (_product.sizes.length == 1) ...[
                        productPrice(_product.displayPrice),
                        // space
                        SizedBox(
                          height: SharedFunction.scaleHeight(30, height),
                        ),
                      ],
                      // product size
                      if (_product.sizes.length > 1) ...[
                        productSizes(_product),
                        // space
                        SizedBox(
                          height: SharedFunction.scaleHeight(30, height),
                        ),
                      ],
                      // product add ons
                      if (_product.add_on_groups.length > 0) ...[
                        productAddOns(_product),
                        // space
                        SizedBox(
                          height: SharedFunction.scaleHeight(30, height),
                        ),
                      ],
                      // Quantity
                      quantity(_product),
                      // space
                      SizedBox(
                        height: SharedFunction.scaleHeight(30, height),
                      ),
                      // Total
                      total(_product),
                      // space
                      SizedBox(
                        height: SharedFunction.scaleHeight(45, height),
                      ),
                      // Add to cart
                      addToBasketBtn(_product),
                      // space
                      SizedBox(
                        height: SharedFunction.scaleHeight(80, height),
                      ),
                    ],
                  );
                },
              )),
        ),
      ),
    ));
  }

  Widget productImage(String url) {
    return Container(
      width: SharedFunction.scaleWidth(productImageWidth, width),
      height: SharedFunction.scaleHeight(productImageHeight, height),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: SharedStyle.borderRadius(20, 20, 20, 20),
            side: BorderSide(width: 1, color: SharedStyle.tertiaryFill)),
        child: ClipRRect(
          borderRadius: SharedStyle.borderRadius(20, 20, 20, 20),
          child: Image.network(
            url,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget productName(String name) {
    return Text(
      "Test",
      textAlign: TextAlign.center,
      style: ProductStyle.productName,
    );
  }

  Widget productDescription(String _description) {
    return Text(
      "_description",
      textAlign: TextAlign.center,
      style: ProductStyle.productDescription,
    );
  }

  Widget productPrice(String price) {
    return Text("₱",
        textAlign: TextAlign.center, style: ProductStyle.productPrice);
  }

  Widget productSizes(ProductController product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // name
        title("Sizes"),
        // space
        SizedBox(
          height: SharedFunction.scaleHeight(10, height),
        ),
        // sizes
        for (var size in product.sizes) ...[
          productSizeDetail(size, product),
          // space
          SizedBox(
            height: SharedFunction.scaleHeight(10, height),
          )
        ]
      ],
    );
  }

  Widget productSizeDetail(Map size, ProductController product) {
    String _name = size['size'];
    bool selected = product.selected(size);

    return ElevatedButton(
        onPressed: () => product.setSize(size),
        style: selected ? ProductStyle.selectedBtn : ProductStyle.unselectedBtn,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // name
            subTitle(_name, selected),
            // price
            priceDisplay(size['price'], size['base_price'], selected),
          ],
        ));
  }

  Widget productAddOns(ProductController product) {
    return Column(
      children: [
        for (var aog in product.add_on_groups) ...[addOnGroup(aog, product)]
      ],
    );
  }

  Widget addOnGroup(Map aog, ProductController product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // title
        title(aog['name'], aog['require'].toString()),
        // space
        SizedBox(
          height: SharedFunction.scaleHeight(10, height),
        ),
        // add ons
        for (var add_on in aog['add_ons']) ...[
          // add on
          addOn(add_on, product),
          // space
          SizedBox(
            height: SharedFunction.scaleHeight(10, height),
          )
        ]
      ],
    );
  }

  Widget addOn(Map ao, ProductController product) {
    String _name = ao['name'];
    String _price = ao['price'].toStringAsFixed(2);
    bool selected = product.selectedAddOns[ao['add_on_group_id']]['addOns']
        .contains(ao['id']);

    return ElevatedButton(
        onPressed: () => product.checkAddOns(ao, selected),
        style: selected ? ProductStyle.selectedBtn : ProductStyle.unselectedBtn,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // name
            subTitle(_name, selected),
            // price
            subTitle("₱$_price", selected),
          ],
        ));
  }

  Widget quantity(ProductController product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // title
        plainTitle("Quantity"),
        //
        quantityBar(product)
      ],
    );
  }

  Widget quantityBar(ProductController product) {
    return Container(
      width: SharedFunction.scaleWidth(quantityBarWidth, width),
      height: SharedFunction.scaleHeight(quantityBarHeight, height),
      decoration: ProductStyle.quantityBar,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          quantityMinus(product),
          quantityNum(product),
          quantityAdd(product)
        ],
      ),
    );
  }

  Widget quantityMinus(ProductController product) {
    return Center(
      child: IconButton(
        onPressed: () => product.quantityMinus(),
        icon: Icon(
          Icons.remove,
        ),
        color: SharedStyle.red,
      ),
    );
  }

  Widget quantityAdd(ProductController product) {
    return Center(
      child: IconButton(
        onPressed: () => product.quantityAdd(),
        icon: Icon(Icons.add),
        color: SharedStyle.red,
      ),
    );
  }

  Widget quantityNum(ProductController product) {
    return Text(
      "QuantityNum",
      style: ProductStyle.quantityBarNum,
    );
  }

  Widget total(ProductController product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // title
        plainTitle("Total"),
        // total amount
        totalAmount(product.getTotalAmount().toStringAsFixed(2))
      ],
    );
  }

  Widget title(String name, [String require = "0"]) {
    String requireName = "";
    if (name == "Sizes") {
      requireName = "1 Required";
    } else if (require == "0") {
      requireName = "Optional";
    } else {
      requireName = "$require Required";
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        plainTitle(name),
        Text(
          "title",
        ),
      ],
    );
  }

  Widget plainTitle(String name) {
    return Text(
      "plainTitle",
      style: ProductStyle.title,
    );
  }

  Widget subTitle(String name, bool selected) {
    return Text(
      "subTitle",
      style: selected
          ? ProductStyle.selectedSubTitle
          : ProductStyle.unselectedSubTitle,
    );
  }

  Widget priceDisplay(double _price, double _basePrice, bool selected) {
    String _stringPrice = _price.toStringAsFixed(2);
    String _stringBasePrice = _basePrice.toStringAsFixed(2);
    bool _isSame = _price == _basePrice;

    return Row(
      children: [
        if (!_isSame) ...[
          Text(
            "₱priceDisplay",
            style: selected
                ? ProductStyle.selectedSubTitle
                : ProductStyle.unselectedSubTitle,
          ),
          SizedBox(
            width: SharedFunction.scaleWidth(10, width),
          )
        ],
        Text(
          "₱_stringBasePrice",
          style: selected
              ? (_isSame
                  ? ProductStyle.selectedSubTitle
                  : ProductStyle.selectedSubTitleLineThrough)
              : (_isSame
                  ? ProductStyle.unselectedSubTitle
                  : ProductStyle.unselectedSubTitleLineThrough),
        )
      ],
    );
  }

  Widget totalAmount(String _total) {
    return Text("₱totalAmount", style: ProductStyle.totalAmount);
  }

  Widget addToBasketBtn(ProductController product) {
    return SharedWidgets.redBtn(
        onPressed: () => product.addToCart(context),
        name: "Add To Basket",
        width: width,
        height: height);
  }
}
