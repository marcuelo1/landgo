import 'package:flutter/material.dart';
import 'package:landgo_seller/core/styles/shared_style.dart';
import 'package:landgo_seller/core/widgets/bar_widgets.dart';
import 'package:landgo_seller/features/operations/controllers/product_form_controller.dart';
import 'package:provider/provider.dart';

class ProductFormView extends StatefulWidget {
  static const String routeName = "product_form_view";

  @override
  _ProductFormViewState createState() => _ProductFormViewState();
}

class _ProductFormViewState extends State<ProductFormView> {
  late ProductFormController con;
  final formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
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
        body: SingleChildScrollView(
          child: Column(
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
          _buildPickImage()
          // sizes
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
}