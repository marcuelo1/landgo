import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ryve_mobile/features/cart/review_payment_location.dart';
import 'package:ryve_mobile/sellers/product_style.dart';
import 'package:ryve_mobile/core/entities/headers.dart';
import 'package:ryve_mobile/core/widgets/loading.dart';
import 'package:ryve_mobile/core/widgets/pop_up.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/core/styles/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/core/widgets/shared_widgets.dart';

class Cart extends StatefulWidget {
  static const String routeName = "cart";
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  // url
  String _dataUrl =
      "${SharedUrl.root}/${SharedUrl.version}/buyer/carts/list_of_sellers";
  String _dataUrlCartProduct =
      "${SharedUrl.root}/${SharedUrl.version}/buyer/carts";

  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // dimensions
  static final double productHeight = 70;
  static final double productWidth = 327;
  static final double productImageWidth = 70;
  static final double productImageHeight = 70;
  final double quantityBarWidth = 100;
  final double quantityBarHeight = 35;
  final double checkoutBtnWidth = 300;
  final double checkoutBtnHeight = 60;

  // response
  Map response = {};
  Map responseBody = {};

  List sellers = [];
  Map sellerSubTotals = {};
  Map sellerTotals = {};
  List selectedSellersId = [];

  Map sellerCartProducts = {};

  List selectedVouchers = [];
  List vouchers = [];
  int selectVoucherSellerId = 0;

  Map deliveryFees = {};

  // headers
  Map<String, String> _headers = {};
  @override
  void initState() {
    super.initState();
    _headers = Headers.getHeaders();
    print(_headers);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

    return responseBody.isNotEmpty
        ? content()
        : FutureBuilder(
            future: SharedFunction.getData(_dataUrl, _headers),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // Connection state of getting the data
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text("check internet");
                case ConnectionState.waiting: // Retrieving
                  return Loading();
                default: // Success of connecting to back end
                  // check if snapshot has an error
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }

                  // get response
                  response = snapshot.data;
                  responseBody = response['body'];
                  print(responseBody);
                  print(
                      "==============================================================");

                  sellers = responseBody["sellers"];
                  print(sellers);
                  print(
                      "============================================================== Sellers");

                  vouchers = responseBody["vouchers"];
                  print(vouchers);
                  print(
                      "============================================================== Vouchers");

                  deliveryFees = responseBody["delivery_fees"];
                  print(deliveryFees);
                  print(
                      "============================================================== deliveryFees");

                  for (var seller in sellers) {
                    sellerCartProducts[seller['id']] = [];
                  }

                  return content();
              }
            });
  }

  Widget content() {
    return SafeArea(
        child: Scaffold(
      appBar: SharedWidgets.appBar(context, title: "Basket"),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            SharedFunction.scaleWidth(24, width),
            SharedFunction.scaleHeight(20, height),
            SharedFunction.scaleWidth(24, width),
            SharedFunction.scaleHeight(0, height)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var seller in sellers) ...[
                _sellerContent(seller),
                if (selectedSellersId.contains(seller['id'])) ...[
                  checkoutDetails(seller)
                ]
              ],
              if (selectedSellersId.length > 0) ...[checkoutBtn()]
            ],
          ),
        ),
      ),
    ));
  }

  Widget _sellerContent(Map seller) {
    return GestureDetector(
      onTap: () async {
        if (sellerCartProducts[seller['id']].isEmpty) {
          String _rawUrl = _dataUrlCartProduct + "?seller_id=${seller['id']}";
          Map _response = await SharedFunction.getData(_rawUrl, _headers);

          if (_response['status'] == 200) {
            sellerCartProducts[seller['id']] = _response['body']['carts'];
          }
        }

        setState(() {
          if (selectedSellersId.contains(seller['id'])) {
            selectedSellersId.remove(seller['id']);
          } else {
            selectedSellersId.add(seller['id']);
          }
        });
      },
      child: SharedWidgets.seller(seller, width, height),
    );
  }

  Widget checkoutDetails(Map _seller) {
    int seller_id = _seller['id'];
    List _carts = sellerCartProducts[seller_id];

    // GET SUB TOTAL
    double _subTotalPrice =
        _carts.map((_cart) => _cart['total']).toList().reduce((a, b) => a + b);
    sellerSubTotals[seller_id] = _subTotalPrice;

    // GET DELIVERY FEE
    double _deliveryFee = deliveryFees[_seller['id'].toString()];

    // GET VAT
    double _vat = _subTotalPrice * .2 * .12;

    // GET TOTAL
    double _total = _subTotalPrice + _deliveryFee + _vat;

    // GET VOUCHER DISCOUNT
    double discountAmount = 0;

    for (var _voucherRaw in selectedVouchers) {
      if (_voucherRaw['seller_id'] == seller_id) {
        Map _voucher = _voucherRaw['voucher'];
        if (_voucher['discount_type'] == 'Percent') {
          // check if the discount amount is greater than the max discount
          discountAmount = _total * (_voucher['discount'] / 100);
          discountAmount = discountAmount < _voucher['max_discount']
              ? discountAmount
              : _voucher['max_discount'];
        } else {
          discountAmount = _voucher['discount'];
        }

        _voucherRaw['discount_amount'] = discountAmount;
        break;
      }
    }

    sellerTotals[seller_id] = _total - discountAmount;

    return Column(
      children: [
        // products
        for (var _cart in _carts) ...[cartProduct(_cart)],
        // sub total
        rowWithValue("Sub Total", _subTotalPrice),
        SizedBox(height: SharedFunction.scaleHeight(5, height)),
        // delivery fee
        rowWithValue('Delivery Fee', _deliveryFee),
        SizedBox(height: SharedFunction.scaleHeight(5, height)),
        // vat
        rowWithValue('VAT', _vat),
        SizedBox(height: SharedFunction.scaleHeight(5, height)),
        // voucher
        voucherRow(seller_id, discountAmount),
        SizedBox(height: SharedFunction.scaleHeight(2, height)),
        // voucher list
        if (selectVoucherSellerId == seller_id) ...[
          voucherList(seller_id),
          SizedBox(height: SharedFunction.scaleHeight(5, height)),
        ],
        // total
        rowWithValue('Total', sellerTotals[seller_id]),
      ],
    );
  }

  Widget cartProduct(Map _cart) {
    Map product = _cart['product'];

    return Column(
      children: [
        // Space
        SizedBox(
          height: SharedFunction.scaleHeight(15, height),
        ),
        // product
        _productContent(_cart, product),
        // Space
        SizedBox(
          height: SharedFunction.scaleHeight(15, height),
        ),
        // Divider
        Divider(
          color: SharedStyle.black,
          height: 1,
        ),
      ],
    );
  }

  Widget _productContent(Map _cart, Map product) {
    String imageUrl = product['image'];
    String name = product['name'];
    String price = product['price'].toStringAsFixed(2);
    String cartProductDescription = _cart['product_description'];
    String total = _cart['total'].toStringAsFixed(2);

    return Container(
      height: SharedFunction.scaleHeight(productHeight, height),
      width: SharedFunction.scaleWidth(productWidth, width),
      child: Row(
        children: [
          // quantity
          quantityBar(_cart),
          // space
          SizedBox(
            width: SharedFunction.scaleWidth(10, width),
          ),
          // product details
          _productDetails(name, price, cartProductDescription),
          // add button
          _productPrice(total)
        ],
      ),
    );
  }

  Widget productImage(String url) {
    return Container(
      width: SharedFunction.scaleWidth(productImageWidth, width),
      height: SharedFunction.scaleHeight(productImageHeight, height),
      child: Image.network(
        url,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _productDetails(
      String name, String price, String cartProuctDescription) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // product name
        _productName(name),
        // product price
        _productDescription(cartProuctDescription)
      ],
    );
  }

  Widget _productName(String name) {
    return Text(
      name,
      style: SharedStyle.productName,
    );
  }

  Widget _productPrice(String price) {
    return Text(
      "₱$price",
      style: SharedStyle.productPrice,
    );
  }

  Widget _productDescription(String descrip) {
    return Container(
      width: SharedFunction.scaleWidth(150, width),
      child: Text(
        descrip,
        overflow: TextOverflow.ellipsis,
        style: SharedStyle.productPrice,
      ),
    );
  }

  Widget quantityBar(Map _cart) {
    return Container(
      width: SharedFunction.scaleWidth(quantityBarWidth, width),
      height: SharedFunction.scaleHeight(quantityBarHeight, height),
      decoration: ProductStyle.quantityBar,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          quantityMinus(_cart),
          quantityNum(_cart),
          quantityAdd(_cart)
        ],
      ),
    );
  }

  Widget quantityMinus(Map _cart) {
    return Center(
      child: IconButton(
        onPressed: () async {
          if (_cart['quantity'] > 1) {
            _cart['quantity']--;

            String _rawUrl = _dataUrlCartProduct + "/${_cart['id']}";
            Map _data = {
              "type": "quantity",
              "quantity": _cart['quantity'],
            };

            Map response =
                await SharedFunction.sendData(_rawUrl, _headers, _data, "put");

            if (response['status'] == 200) {
              _cart['total'] = response['body']['total'];
            }

            setState(() {});
          }
        },
        icon: Icon(
          Icons.remove,
        ),
        color: SharedStyle.yellow,
      ),
    );
  }

  Widget quantityAdd(Map _cart) {
    return Center(
      child: IconButton(
        onPressed: () {
          setState(() async {
            _cart['quantity']++;

            String _rawUrl = _dataUrlCartProduct + "/${_cart['id']}";
            Map _data = {
              "type": "quantity",
              "quantity": _cart['quantity'],
            };

            Map response =
                await SharedFunction.sendData(_rawUrl, _headers, _data, "put");

            if (response['status'] == 200) {
              _cart['total'] = response['body']['total'];
            }
          });
        },
        icon: Icon(Icons.add),
        color: SharedStyle.yellow,
      ),
    );
  }

  Widget quantityNum(Map _cart) {
    return Text(
      "${_cart['quantity']}",
      style: ProductStyle.quantityBarNum,
    );
  }

  Widget rowWithValue(String _name, double _amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _name,
          style: SharedStyle.subTitle,
        ),
        Text(
          "₱${_amount.toStringAsFixed(2)}",
          style: SharedStyle.subTitleYellow,
        )
      ],
    );
  }

  Widget checkoutBtn() {
    double _totalPrice = 0;
    sellerTotals.forEach((key, value) {
      if (selectedSellersId.contains(key)) {
        _totalPrice += value;
      }
    });

    List selectedSellers = [];

    for (var _seller in sellers) {
      if (selectedSellersId.contains(_seller['id'])) {
        selectedSellers.add(_seller);
      }
    }

    return ElevatedButton(
        onPressed: () async {
          // send data for checkout
          Map rawBody = {
            "sellers": selectedSellers,
            "selectedVouchers": selectedVouchers,
            "sellerSubTotals": sellerSubTotals,
            "deliveryFees": deliveryFees,
            "sellerTotals": sellerTotals,
            "sellerCartProducts": sellerCartProducts
          };

          Navigator.pushNamed(context, ReviewPaymentLocation.routeName,
              arguments: rawBody);
        },
        style: SharedStyle.yellowBtn,
        child: Container(
          width: SharedFunction.scaleWidth(checkoutBtnWidth, width),
          height: SharedFunction.scaleHeight(checkoutBtnHeight, height),
          child: Center(
            child: Text(
              "Checkout ${_totalPrice.toStringAsFixed(2)}",
              style: SharedStyle.yellowBtnText,
            ),
          ),
        ));
  }

  Widget voucherRow(int _sellerId, double discountAmount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              "Voucher",
              style: SharedStyle.subTitle,
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    selectVoucherSellerId = _sellerId;
                  });
                },
                child: Text("Select Voucher"))
          ],
        ),
        Text(
          "₱${discountAmount.toStringAsFixed(2)}",
          style: SharedStyle.subTitleYellow,
        )
      ],
    );
  }

  Widget voucherList(int _sellerId) {
    return Container(
      height: SharedFunction.scaleHeight(SharedWidgets.voucherHeight, height),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (var _voucher in vouchers) ...[
            GestureDetector(
              onTap: () {
                setState(() {
                  selectVoucherSellerId = 0;

                  for (var i = 0; i < selectedVouchers.length; i++) {
                    if (selectedVouchers[i]['seller_id'] == _sellerId) {
                      selectedVouchers.removeAt(i);
                      break;
                    }
                  }

                  selectedVouchers
                      .add({'seller_id': _sellerId, 'voucher': _voucher});
                });
              },
              child: SharedWidgets.voucher(_voucher, width, height),
            ),
            SizedBox(
              width: SharedFunction.scaleWidth(10, width),
            )
          ]
        ],
      ),
    );
  }
}
