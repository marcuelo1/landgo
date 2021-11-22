import 'package:flutter/material.dart';
import 'package:landgo_seller/core/functions/style_function.dart';
import 'package:landgo_seller/core/models/add_on_group_model.dart';
import 'package:landgo_seller/core/models/product_add_on_groups_model.dart';
import 'package:landgo_seller/core/models/product_model.dart';
import 'package:landgo_seller/core/models/product_size_model.dart';
import 'package:landgo_seller/core/styles/shared_style.dart';
import 'package:landgo_seller/core/widgets/bar_widgets.dart';
import 'package:landgo_seller/core/widgets/card_widgets.dart';
import 'package:landgo_seller/features/operations/controllers/list_of_products_controller.dart';
import 'package:provider/provider.dart';

class ListOfProductsView extends StatefulWidget {
  static const String routeName = "list_of_products_view";

  @override
  _ListOfProductsViewState createState() => _ListOfProductsViewState();
}

class _ListOfProductsViewState extends State<ListOfProductsView> {
  // variables for scale functions
  late double width;
  late double height;
  late double scale;
  late ListOfProductsController con;

  @override
  void initState(){
    super.initState();
    con = Provider.of<ListOfProductsController>(context, listen: false);
    con.getProductsData();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

    return SafeArea(
      child: Scaffold(
        appBar: BarWidgets.appBar(context),
        bottomNavigationBar: BarWidgets.bottomAppBar(context),
        backgroundColor: SharedStyle.red,
        body: Consumer<ListOfProductsController>(
          builder: (_, lofc, __) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Product"),
                  // Add Product Button
                  ElevatedButton(
                    onPressed: (){}, 
                    child: Text("Add Product")
                  ),
                  Divider(thickness: 2),
                  // List of Products
                  for (ProductModel product in lofc.products) ... [
                    CardWidgets.card(
                      cardWidth: 250, 
                      referenceWidth: width, 
                      child: Column(
                        children: [
                          // head
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Image
                              _buildProductThumb(product),
                              // Info
                              _buildProductInfo(product),
                              // Edit Button
                              // ElevatedButton(
                              //   onPressed: (){}, 
                              //   child: Text("Edit")
                              // ),
                              // View Details
                              ElevatedButton(
                                onPressed: () => con.viewDetails(product.id), 
                                child: Text("View")
                              ),
                            ],
                          ),
                          // body
                          if(con.isShow[product.id] == true)...[
                            _buildProductBody(product)
                          ]
                        ],
                      )
                    ),
                    SizedBox(height: 10,)
                  ]
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _buildProductThumb(ProductModel _product){
    return Container(
      width: StyleFunction.scaleWidth(40, width),
      height: StyleFunction.scaleHeight(40, height),
      child: ClipRRect(
        borderRadius: SharedStyle.borderRadius(10, 10, 10, 10),
        child: Image.network(
          _product.image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildProductInfo(ProductModel _product){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Id: ${_product.id.toString()}"),
        Text("Name: ${_product.name}"),
        Text("Description: ${_product.description}"),
        Text("Category Name: ${_product.categoryName}")
      ],
    );
  }
  
  Widget _buildProductBody(ProductModel _product){
    return Column(
      children: [
        Divider(thickness: 2),
        // sizes
        Text("SIZES"),
        _buildProductSizes(_product.sizes),
        // add ons
        Text("ADD ON GROUPS"),
        _buildProductAddOnGroups(_product.addOnGroups)
      ],
    );
  }

  Widget _buildProductSizes(List<ProductSizeModel> _productSizes){
    return Table(
      border: TableBorder.all(color: Colors.black, style: BorderStyle.solid, width: 1),
      children: [
        TableRow(
          children: [
            Text("Size"),
            Text("Base Price"),
            Text("Price")
          ]
        ),
        // iterate all sizes
        for (ProductSizeModel _size in _productSizes) ...[
          TableRow(
            children: [
              Text(_size.name),
              Text(_size.basePrice.toStringAsFixed(2)),
              Text(_size.price.toStringAsFixed(2))
            ]
          )
        ]
      ],
    );
  }

  Widget _buildProductAddOnGroups(List<ProductAddOnGroupModel> _productAddOnGroups){
    return Table(
      border: TableBorder.all(color: Colors.black, style: BorderStyle.solid, width: 1),
      children: [
        TableRow(
          children: [
            Text("Name"),
            Text("Info"),
            Text("Add Ons")
          ]
        ),
        for (ProductAddOnGroupModel _paog in _productAddOnGroups) ...[
          TableRow(
            children: [
              Text(_paog.name),
              Column(
                children: [
                  Text("Require: ${_paog.require.toString()}"),
                  Text("Num of Selected Choices: ${_paog.numOfSelect.toString()}"),
                ],
              ),
              Table(
                border: TableBorder.all(color: Colors.black, style: BorderStyle.solid, width: 1),
                children: [
                  TableRow(
                    children: [
                      Text("Name"),
                      Text("Price"),
                    ]
                  ),
                  for (AddOnModel _ao in _paog.addOns) ...[
                    TableRow(
                      children: [
                        Text(_ao.name),
                        Text(_ao.price.toStringAsFixed(2)),
                      ]
                    ),
                  ]
                ],
              )
            ]
          ),
        ]
      ],
    );
  }
}