import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:landgo_seller/core/functions/style_function.dart';
import 'package:landgo_seller/core/styles/shared_style.dart';
import 'package:landgo_seller/core/widgets/bar_widgets.dart';
import 'package:landgo_seller/core/widgets/card_widgets.dart';
import 'package:landgo_seller/features/operations/controllers/product_form_controller.dart';
import 'package:landgo_seller/features/profile/controllers/profile_controller.dart';
import 'package:provider/provider.dart';

class ProductFormView extends StatefulWidget {
  static const String routeName = "product_form_view";

  @override
  _ProductFormViewState createState() => _ProductFormViewState();
}

class _ProductFormViewState extends State<ProductFormView> {
  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  late ProductFormController con;
  final formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

    final Map args = ModalRoute.of(context)!.settings.arguments as Map; // got an error when i placed it in initState()
    con = Provider.of<ProductFormController>(context, listen: false);
    if(con.refresh){
      con.setProduct(args['product']);
    }
    
    return SafeArea(
      child: Scaffold(
        appBar: BarWidgets.appBar(context),
        bottomNavigationBar: BarWidgets.bottomAppBar(context),
        backgroundColor: SharedStyle.red,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if(con.isNew)...[
              Text("NEW PRODUCT")
            ]else...[
              Text("EDIT PRODUCT")
            ],
            _buildForm()
          ],
        ),
      ),
    );
  }

  Widget _buildForm(){
    return Form(
      key: formKey,
      child: Column(
        children: [
          // name
          _buildFormName(),
          // description
          _buildFormDescription(),
          // product category
          _buildFormProductCategory(),
          // image
          _buildPickImage(),
          // sizes
          _buildFormSizes(),
          // add ons
        ],
      )
    );
  }

  Widget _buildFormName(){
    return Consumer<ProductFormController>(
      builder: (_, pfc, __) {
        return TextFormField(
          decoration: SharedStyle.textFormFieldDecoration('Name'),
          validator: (value) => pfc.validateFormName(value),
          onSaved: (value) => pfc.saveFormName(value),
        );
      }
    );
  }

  Widget _buildFormDescription(){
    return Consumer<ProductFormController>(
      builder: (_, pfc, __) {
        return TextFormField(
          decoration: SharedStyle.textFormFieldDecoration('Description'),
          validator: (value) => pfc.validateFormName(value),
          onSaved: (value) => pfc.saveFormName(value),
        );
      }
    );
  }

  Widget _buildFormProductCategory(){
    return Consumer<ProductFormController>(
      builder: (_, pfc, __) {
        return DropdownButton<Map>(
          value: pfc.selectedProductCategory,
          items: pfc.productCategories.map((_pc) {
            return DropdownMenuItem<Map>(
              value: _pc,
              child: Text(_pc['name']),
            );
          }).toList(),
          onChanged: (value) => pfc.onChangeProductCategory(value as Map),
        );
      }
    );
  }

  Widget _buildPickImage(){
    return Consumer<ProductFormController>(
      builder: (_, pfc, __) {
        return ElevatedButton(
          onPressed: () async => pfc.onPickImage(), 
          child: Text("Upload Image")
        );
      }
    );
  }

  Widget _buildFormSizes(){
    return CardWidgets.card(
      cardWidth: 320, 
      referenceWidth: width, 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Add Size
          ElevatedButton(
            onPressed: ()=> con.addSize(), 
            child: Text("Add Size")
          ),
          Divider(thickness: 2),
          // list of sizes
          _buildListOfSizes()
        ],
      )
    );
  }

  Widget _buildListOfSizes(){
    return Container(
      width: StyleFunction.scaleWidth(320, width),
      height: StyleFunction.scaleHeight(170, height),
      child: Consumer<ProductFormController>(
        builder: (_, pfc, __) {
          return ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (var i = 0; i < pfc.selectedProductSizes.length; i++) ...[
                _buildListItem(pfc, i)
              ],
            ],
          );
        }
      ),
    );
  }

  Widget _buildListItem(ProductFormController _pfc, int _index){
    return CardWidgets.cardRed(
      cardWidth: 120, 
      referenceWidth: width, 
      child: Column(
        children: [
          // remove item
          if(_index != 0)...[
            Center(
              child: IconButton(
                onPressed: ()=> _pfc.removeSize(_index), 
                icon: Icon(Icons.close)
              ),
            )
          ],
          // Sizes
          DropdownButton<Map>(
            value: _pfc.selectedProductSizes[_index]['size'],
            items: _pfc.productSizes.map((_productSize) {
              return DropdownMenuItem<Map>(
                value: _productSize,
                child: Text(_productSize['name']),
              );
            }).toList(),
            onChanged: (value) => _pfc.sizeOnChange(value, _index),
          ),
          // Price Field
          TextFormField(
            decoration: SharedStyle.textFormFieldDecoration('Price'),
            keyboardType: TextInputType.number,
            validator: (value) => _pfc.validatePrice(value),
            onSaved: (value) => _pfc.saveSizePrice(value, _index),
          )
        ],
      )
    );
  }
}