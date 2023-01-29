import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:laps/commonFunction/ImageProcessor.dart';
import 'package:laps/model/ChassisToVehicleId.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../commonFunction/ApiRequest.dart';
import '../model/LoadingImage.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  List<bool> _selection;
  int inStore = 1;
  double rating = 0.0;
  final productChassisnum = TextEditingController();
  final productNotes = TextEditingController();
  final productPrice = TextEditingController();
  final variantNotes = TextEditingController();
  final textMake = TextEditingController();
  final textModel = TextEditingController();
  final textYear = TextEditingController();
  String selectedValueMake;
  String selectedValueModel;
  String selectedValueVariant = 'Standard';
  String selectedValueYear;
  int vehicleID;
  int partID;
  String imageTitleOne = "Full View";
  String imageTitleTwo = "Zoom View";
  String imageTitleThree = "Fitment View";
  bool enableChassisnum = false;
  bool addMoreFieldDisable = false;
  bool addMoreBtnVisibility = false;
  bool makeModelyearList = true;
  bool viewFields = true;

  bool errMsgMake = false;
  bool errMsgModel = false;
  bool errMsgVariant = false;
  bool errMsgYear = false;
  bool errMsgPartName = false;
  bool errMsgImages = false;
  bool isLoading = false;
  bool errMsgChassisnum = false;

  File _image1, _image2, _image3;

  FocusNode chassisNumFocusNode;

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    chassisNumFocusNode.dispose();
    // Clean up the text change controller node when the Form is disposed.
    productChassisnum.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _selection = [true, false];
    buildDropdownMake();
    buildDropdownPartName();

    super.initState();
    chassisNumFocusNode = FocusNode();
    chassisNumFocusNode.addListener(() {
      if (!chassisNumFocusNode.hasFocus) {
        var listener;
        listener = () {
          print("Has focus: ${productChassisnum.text}");
          if (productChassisnum.text != '') {
            _getVariant();
          } else {
            setState(() {
              makeModelyearList = true;
            });
          }
          productChassisnum.removeListener(listener);
        };
        productChassisnum.addListener(listener);
      } else {
        setState(() {
          viewFields = false;
        });
      }
    });
  }

  Future getImage1() async {
    File image1 = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image1 = image1;
    });
  }

  Future getImage2() async {
    var image2 = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image2 = image2;
    });
  }

  Future getImage3() async {
    var image3 = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image3 = image3;
    });
  }

  void getImageClear(int value) {
    setState(() {
      if (value == 1) _image1 = null;
      if (value == 2) _image2 = null;
      if (value == 3) _image3 = null;
    });
  }

  void onClearFieldsAdd(int frmBtn) {
    // 1 is from Add button and 2 is from Add More button
    if (frmBtn == 1)
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => AddProduct()),
          (Route<dynamic> route) => false);
    else {
      productNotes.clear();
      productPrice.clear();
      variantNotes.clear();
      setState(() {
        rating = 0;
        enableChassisnum = false;
        addMoreFieldDisable = true;
        _image3 = null;
        partID = null;
      });
    }
  }

  List<DropdownMenuItem> itemsMake = [
    DropdownMenuItem(
      value: "",
      child: Text(""),
    )
  ];
  List<DropdownMenuItem> itemsModel = [
    DropdownMenuItem(
      value: "",
      child: Text(""),
    )
  ];
  List<DropdownMenuItem> itemsVariant = [
    DropdownMenuItem(
      value: "",
      child: Text(""),
    )
  ];
  List<DropdownMenuItem> itemsYear = [
    DropdownMenuItem(
      value: "",
      child: Text(""),
    )
  ];
  List<DropdownMenuItem> itemsPartName = [
    DropdownMenuItem(
      value: "",
      child: Text(""),
    )
  ];

  String getProductImageJson(
      String imgName, String s3Url, int productId, int profileImage) {
    //String imageName1 = img + "." + _image1.path.split('.').last;
    String imagePath = s3Url + imgName;
    String imgJson = jsonEncode({
      "id": 0,
      "imageName": imgName,
      "imageUrl": imagePath,
      "imageCaption": "",
      "thumbnailUrl": "",
      "profileImage": profileImage,
      "addInfo1": "",
      "addInfo2": "",
      "addInfo3": "",
      "addInfo4": "",
      "product_id": productId
    });

    return imgJson;
  }

  void onPostSave(int frmBtn) async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final s3Url = DotEnv().env['aws_s3_url'] +
        '/' +
        DotEnv().env['aws_s3_api_stage'] +
        '/' +
        DotEnv().env['aws_s3_bucket_name'] +
        '/';
    int merchantId = prefs.getInt("merchantid") ?? 0;
    int userId = prefs.getInt("id") ?? 0;
    String imageName1, imageName2, imageName3;
    String formData = jsonEncode({
      "id": 0,
      "productNotes": "${productNotes.text}",
      "productVariant": "${variantNotes.text}",
      "productQuality": rating,
      "productPrice": double.tryParse(productPrice.text),
      "productChassisnum": "${productChassisnum.text}",
      "productInstore": inStore,
      "productQuantity": 1,
      "productStatus": "A",
      "createdby": userId,
      "vehicle_id": vehicleID,
      "part_id": partID,
      "merchant_id": merchantId,
    });
    var data = await new ApiRequest().postDataInAPI("products", formData);
    if (data.statusCode == 200) {
      Map responseBody = jsonDecode(data.body);
      int productId = responseBody['id'];
      bool addImage2S3Bucket = true;
      bool add2ProductImage = true;
      print("onPostSave : Success : $productId");
      if (_image1 != null) {
        //First image
        imageName1 = "$merchantId" +
            "_" +
            "$productId" +
            "_001" +
            "." +
            _image1.path.split('.').last;
        var response = await new ImageProcessor()
            .putImage(_image1, ("$merchantId" + "_" + "$productId" + "_001"));
        if (response != 200) {
          addImage2S3Bucket = false;
        }
      }
      if (_image2 != null) {
        //Second image
        imageName2 = "$merchantId" +
            "_" +
            "$productId" +
            "_002" +
            "." +
            _image2.path.split('.').last;
        var response = await new ImageProcessor()
            .putImage(_image2, "$merchantId" + "_" + "$productId" + "_002");
        if (response != 200) {
          addImage2S3Bucket = false;
        }
      }
      if (_image3 != null) {
        //Third image
        imageName3 = "$merchantId" +
            "_" +
            "$productId" +
            "_003" +
            "." +
            _image3.path.split('.').last;
        var response = await new ImageProcessor()
            .putImage(_image3, "$merchantId" + "_" + "$productId" + "_003");
        if (response != 200) {
          addImage2S3Bucket = false;
        }
      }

      if (addImage2S3Bucket) {
        if (_image1 != null) {
          var data = await new ApiRequest().postDataInAPI("productimages",
              getProductImageJson(imageName1, s3Url, productId, 1));
          if (data.statusCode != 200) {
            add2ProductImage = false;
          }
        }
        if (_image2 != null) {
          var data = await new ApiRequest().postDataInAPI("productimages",
              getProductImageJson(imageName2, s3Url, productId, 2));
          if (data.statusCode != 200) {
            add2ProductImage = false;
          }
        }
        if (_image3 != null) {
          var data = await new ApiRequest().postDataInAPI("productimages",
              getProductImageJson(imageName3, s3Url, productId, 3));
          if (data.statusCode != 200) {
            add2ProductImage = false;
          }
        }
      }

      if (!(addImage2S3Bucket && add2ProductImage)) {
        new ApiRequest().deleteDataInAPI("products/$productId");
        new ApiRequest().deleteDataInAPI("productimages/product/$productId");
        setState(() {
          isLoading = false;
        });
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Sorry, failed to Add Product..! try again"),
        ));
      } else {
        setState(() {
          isLoading = false;
        });
        onClearFieldsAdd(frmBtn);
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Product has been Added Successfully..!"),
        ));
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print("Failed " + "${data.body}");
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Sorry, failed to Add Product..!"),
      ));
    }
  }

  Future<void> buildDropdownMake() async {
    var jsonData = await new ApiRequest().getDataFromAPI("vehiclemake", "");
    //print(jsonData);
    List<DropdownMenuItem> items = List();
    for (var data in jsonData) {
      items.add(
        DropdownMenuItem(
          value: data["vehicleMake"],
          child: Text(data["vehicleMake"]),
        ),
      );
    }
    setState(() {
      itemsMake = items;
    });
  }

  Future<void> buildDropdownModel() async {
    print(selectedValueMake);
    var jsonData = await new ApiRequest().getDataFromAPI(
        "vehiclemodel", "[where][vehicleMake]=" + selectedValueMake);
    //print(jsonData);
    List<DropdownMenuItem> items = List();
    for (var data in jsonData) {
      items.add(
        DropdownMenuItem(
          value: data["vehicleModel"],
          child: Text(data["vehicleModel"]),
        ),
      );
    }
    setState(() {
      itemsModel = items;
    });
  }

  Future<void> buildDropdownVariant() async {
    var jsonData = await new ApiRequest().getDataFromAPI(
        "vehiclevariant",
        "[where][vehicleMake]=" +
            selectedValueMake +
            "&filter[where][vehicleModel]=" +
            selectedValueModel);
    //print(jsonData);
    List<DropdownMenuItem> items = List();
    for (var data in jsonData) {
      items.add(
        DropdownMenuItem(
          value: data["vehicleVariant"],
          child: Text(data["vehicleVariant"]),
        ),
      );
    }
    setState(() {
      itemsVariant = items;
    });
  }

  Future<void> buildDropdownYear() async {
    var jsonData = await new ApiRequest().getDataFromAPI(
        "vehicles",
        "[where][vehicle_make]=" +
            selectedValueMake +
            "&filter[where][vehicle_model]=" +
            selectedValueModel +
            "&filter[where][vehicle_variant]=" +
            selectedValueVariant);

    //Standard
    List<DropdownMenuItem> items = List();
    for (var data in jsonData) {
      items.add(
        DropdownMenuItem(
          value: data["id"],
          child: Text(data["vehicle_year"]),
        ),
      );
    }
    setState(() {
      itemsYear = items;
    });
  }

  Future<void> buildDropdownPartName() async {
    var jsonData = await new ApiRequest()
        .getDataFromAPI("parts", "[where][part_status]=A");
    //print(jsonData);
    List<DropdownMenuItem> items = List();
    for (var data in jsonData) {
      items.add(
        DropdownMenuItem(
          value: data["id"],
          child: Text(data["partName"]),
        ),
      );
    }
    setState(() {
      itemsPartName = items;
    });
  }

  bool _validateDropdown() {
    setState(() {
      if (selectedValueMake == null)
        errMsgMake = true;
      else
        errMsgMake = false;
      if (selectedValueModel == null)
        errMsgModel = true;
      else
        errMsgModel = false;
      if (selectedValueVariant == null)
        errMsgVariant = true;
      else
        errMsgVariant = false;
      if (vehicleID == null)
        errMsgYear = true;
      else
        errMsgYear = false;
      if (partID == null)
        errMsgPartName = true;
      else
        errMsgPartName = false;
      if (_image1 == null || _image2 == null)
        errMsgImages = true;
      else
        errMsgImages = false;
      if (enableChassisnum) {
        if (productChassisnum.text.length == 0)
          errMsgChassisnum = true;
        // Disabled validation for Chassis number
        //  errMsgChassisnum = false;
        else
          errMsgChassisnum = false;
      }
    });
    print(
        "$errMsgMake $errMsgModel $errMsgVariant $errMsgYear $errMsgPartName");
    if (errMsgMake &&
        errMsgModel &&
        errMsgVariant &&
        errMsgYear &&
        errMsgPartName &&
        errMsgImages &&
        errMsgChassisnum)
      return false;
    else
      return true;
  }

  void _validateInputs(int frmBtn) {
    _validateDropdown();
    if (_formKey.currentState.validate()) {
      //  If all data are correct then save data to out variables
      //  _formKey.currentState.save();
      print("outside");
      if (_validateDropdown()) {
        print("inside");
        onPostSave(frmBtn);
      }
    } else {
      //    If all data are not valid then start auto validation.
      print("else");
      setState(() {
        _autoValidate = true;
      });
    }
  }

  String validateChassisNum(String value) {
    if (value.length < 0)
      return 'Please enter valid Chassis Number';
    else
      return null;
  }

  String validateNotes(String value) {
    if (value.length <= 0)
      return 'Notes cannot be empty';
    else
      return null;
  }

  String validatePrice(String value) {
    double price = double.tryParse(value);
    if (value.isEmpty) {
      return 'Please enter the Price';
    }
    if (price <= 0)
      return 'Notes cannot be empty';
    else
      return null;
  }

  String validateModel(String value) {
    print("value = " + value);
    if (value == null)
      return 'Please choose the model';
    else
      return null;
  }

  Future<void> _getVariant() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int merchantId = prefs.getInt("merchantid") ?? 0;
    var jsonData = await new ApiRequest().getDataFromAPI("products",
        "[include][0][relation]=vehicle&filter[where][productStatus]=A&filter[where][merchant_id]=$merchantId&filter[where][productChassisnum]=${productChassisnum.text}&filter[limit]=1");

    List<ChassisToVehicleId> products = new List<ChassisToVehicleId>();
    try {
      for (var prod in jsonData) {
        ChassisToVehicleId product = ChassisToVehicleId.fromJson(prod);
        products.add(product);
      }
      if (products.isNotEmpty) {
        setState(() {
          textMake.text = products[0].vehicle.vehicleMake;
          textModel.text = products[0].vehicle.vehicleModel;
          textYear.text = products[0].vehicle.vehicleYear;
          vehicleID = products[0].vehicle.id;
          makeModelyearList = false; //Change list to Text Box
          //selectedValueMake = products[0].vehicle.vehicleMake;
          //selectedValueModel = products[0].vehicle.vehicleModel;
          viewFields = true;
        });
      } else {
        setState(() {
          makeModelyearList = true;
          viewFields = true;
        });
      }
    } catch (e) {
      setState(() {
        makeModelyearList = true;
        viewFields = true;
      });
      print(e);
    }
  }

  void clearOnChangeOfTab() {
    productNotes.clear();
    productPrice.clear();
    variantNotes.clear();
    setState(() {
      addMoreFieldDisable = false;
      partID = null;
      rating = 0;
      _image1 = null;
      _image2 = null;
      _image3 = null;
      errMsgMake = false;
      errMsgModel = false;
      errMsgVariant = false;
      errMsgYear = false;
      errMsgPartName = false;
      errMsgImages = false;
      errMsgChassisnum = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return isLoading
        ? Center(
            child: new LoadingImage().loadingImage,
          )
        : SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ToggleButtons(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Row(
                                children: <Widget>[
                                  Text("Parts in Store"),
                                  Icon(Icons.store),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Row(
                                children: <Widget>[
                                  Text("Parts in Car"),
                                  Icon(Icons.directions_car),
                                ],
                              ),
                            )
                          ],
                          onPressed: (int index) {
                            setState(() {
                              if (index == 0) {
                                _selection[0] = true;
                                _selection[1] = false;
                                productChassisnum.text = "";
                                enableChassisnum = false;
                                inStore = 1;
                                addMoreBtnVisibility = false;
                                viewFields = true;
                                makeModelyearList = true;
                              } else {
                                _selection[0] = false;
                                _selection[1] = true;
                                enableChassisnum = true;
                                addMoreFieldDisable = false;
                                inStore = 0;
                                addMoreBtnVisibility = true;
                                viewFields = false;
                              }
                            });
                            clearOnChangeOfTab();
                          },
                          isSelected: _selection,
                          color: Colors.grey,
                          selectedColor: Colors.green,
                          borderRadius: BorderRadius.circular(5),
                          borderColor: Colors.grey,
                          borderWidth: 1,
                          selectedBorderColor: Colors.green,
                        )
                      ],
                    ),
                  ),
                  enableChassisnum
                      ? Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: [
                                  Container(
                                    width: deviceWidth * 0.83,
                                    child: TextFormField(
                                      //validator: validateChassisNum,
                                      controller: productChassisnum,
                                      enabled: enableChassisnum,
                                      onChanged: (key) {
                                        setState(() {
                                          //viewFields = true;
                                        });
                                      },
                                      // onEditingComplete: () {
                                      //   print("object");
                                      //   FocusScope.of(context).unfocus();
                                      //   if (productChassisnum.text != '') {
                                      //     _getVariant();
                                      //   } else {
                                      //     setState(() {
                                      //       makeModelyearList = true;
                                      //     });
                                      //   }
                                      // },
                                      focusNode: chassisNumFocusNode,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Chassis Number"),
                                    ),
                                  ),
                                  Container(
                                    width: deviceWidth * 0.12,
                                    margin: EdgeInsets.only(left: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      shape: BoxShape.rectangle,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      // Button to Check Chassis number and populate the list
                                      child: IconButton(
                                        icon: Icon(Icons.done),
                                        tooltip: 'Check Chassis number',
                                        onPressed: () {
                                          setState(() {
                                            print("object");
                                            //FocusScope.of(context).unfocus();
                                            if (productChassisnum.text != '') {
                                              _getVariant();
                                            } else {
                                              setState(() {
                                                makeModelyearList = true;
                                              });
                                            }
                                          });
                                          chassisNumFocusNode.unfocus();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: errMsgChassisnum,
                                maintainSize: false,
                                maintainAnimation: true,
                                maintainState: true,
                                child: Text(
                                  "Please enter valid Chassis Number",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        )
                      : new Container(),
                  viewFields
                      ? Column(children: <Widget>[
                          makeModelyearList
                              ? Container(
                                  margin: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      SearchableDropdown.single(
                                        items: itemsMake,
                                        readOnly: addMoreFieldDisable,
                                        label: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10.0, 10.0, 0, 0),
                                          child: Text("Make"),
                                        ),
                                        value: selectedValueMake,
                                        hint: "Select one",
                                        searchHint: "Select one",
                                        displayClearIcon: false,
                                        displayItem: (item, selected) {
                                          return (Row(children: [
                                            selected
                                                ? Icon(
                                                    Icons.radio_button_checked,
                                                    color: Colors.grey,
                                                  )
                                                : Icon(
                                                    Icons
                                                        .radio_button_unchecked,
                                                    color: Colors.grey,
                                                  ),
                                            SizedBox(width: 7),
                                            Expanded(
                                              child: item,
                                            ),
                                          ]));
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            selectedValueMake = value;
                                            if (selectedValueMake != null) {
                                              errMsgMake = false;
                                              buildDropdownModel();
                                            }
                                          });
                                        },
                                        isExpanded: true,
                                      ),
                                      Visibility(
                                        visible: errMsgMake,
                                        maintainSize: false,
                                        maintainAnimation: true,
                                        maintainState: true,
                                        child: Text(
                                          "Please choose Make",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    controller: textMake,
                                    enabled: false,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Make"),
                                  ),
                                ),
                          makeModelyearList
                              ? Container(
                                  margin: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      SearchableDropdown.single(
                                        items: itemsModel,
                                        displayClearIcon: false,
                                        readOnly: addMoreFieldDisable,
                                        label: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10.0, 10.0, 0, 0),
                                          child: Text("Model"),
                                        ),
                                        value: selectedValueModel,
                                        hint: "Select one",
                                        searchHint: "Select one",
                                        displayItem: (item, selected) {
                                          return (Row(children: [
                                            selected
                                                ? Icon(
                                                    Icons.radio_button_checked,
                                                    color: Colors.grey,
                                                  )
                                                : Icon(
                                                    Icons
                                                        .radio_button_unchecked,
                                                    color: Colors.grey,
                                                  ),
                                            SizedBox(width: 7),
                                            Expanded(
                                              child: item,
                                            ),
                                          ]));
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            selectedValueModel = value;
                                            if (selectedValueModel != null) {
                                              errMsgModel = false;
                                              //buildDropdownVariant();
                                              // Hiding variant UI
                                              buildDropdownYear();
                                            }
                                          });
                                        },
                                        isExpanded: true,
                                      ),
                                      Visibility(
                                        maintainState: true,
                                        maintainAnimation: true,
                                        maintainSize: false,
                                        visible: errMsgModel,
                                        child: Text(
                                          "Please choose Model",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    controller: textModel,
                                    enabled: false,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Model"),
                                  ),
                                ),
                          /*             Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Column(
                      children: <Widget>[
                        SearchableDropdown.single(
                          items: itemsVariant,
                          readOnly: addMoreFieldDisable,
                          displayClearIcon: false,
                          label: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                            child: Text("Variant"),
                          ),
                          value: selectedValueVariant,
                          hint: "Select one",
                          searchHint: "Select one",
                          displayItem: (item, selected) {
                            return (Row(children: [
                              selected
                                  ? Icon(
                                      Icons.radio_button_checked,
                                      color: Colors.grey,
                                    )
                                  : Icon(
                                      Icons.radio_button_unchecked,
                                      color: Colors.grey,
                                    ),
                              SizedBox(width: 7),
                              Expanded(
                                child: item,
                              ),
                            ]));
                          },
                          onChanged: (value) {
                            setState(() {
                              selectedValueVariant = value;
                              if (selectedValueVariant != null) {
                                errMsgVariant = false;
                                buildDropdownYear();
                              }
                            });
                          },
                          isExpanded: true,
                        ),
                        Visibility(
                          visible: errMsgVariant,
                          maintainSize: false,
                          maintainAnimation: true,
                          maintainState: true,
                          child: Text(
                            "Please choose Variant",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
    */
                          makeModelyearList
                              ? Container(
                                  margin: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      SearchableDropdown.single(
                                        items: itemsYear,
                                        readOnly: addMoreFieldDisable,
                                        displayClearIcon: false,
                                        label: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10.0, 10.0, 0, 0),
                                          child: Text("Year"),
                                        ),
                                        value: vehicleID,
                                        hint: "Select one",
                                        searchHint: "Select one",
                                        displayItem: (item, selected) {
                                          return (Row(children: [
                                            selected
                                                ? Icon(
                                                    Icons.radio_button_checked,
                                                    color: Colors.grey,
                                                  )
                                                : Icon(
                                                    Icons
                                                        .radio_button_unchecked,
                                                    color: Colors.grey,
                                                  ),
                                            SizedBox(width: 7),
                                            Expanded(
                                              child: item,
                                            ),
                                          ]));
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            vehicleID = value;
                                            if (vehicleID != null)
                                              errMsgYear = false;
                                          });
                                        },
                                        isExpanded: true,
                                      ),
                                      Visibility(
                                        maintainState: true,
                                        maintainAnimation: true,
                                        maintainSize: false,
                                        visible: errMsgYear,
                                        child: Text(
                                          "Please choose Year",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    controller: textYear,
                                    enabled: false,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Year"),
                                  ),
                                ),
                          Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Column(
                              children: <Widget>[
                                SearchableDropdown.single(
                                  items: itemsPartName,
                                  displayClearIcon: false,
                                  label: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10.0, 10.0, 0, 0),
                                    child: Text("Part Name"),
                                  ),
                                  value: partID,
                                  hint: "Select one",
                                  searchHint: "Select one",
                                  displayItem: (item, selected) {
                                    return (Row(children: [
                                      selected
                                          ? Icon(
                                              Icons.radio_button_checked,
                                              color: Colors.grey,
                                            )
                                          : Icon(
                                              Icons.radio_button_unchecked,
                                              color: Colors.grey,
                                            ),
                                      SizedBox(width: 7),
                                      Expanded(
                                        child: item,
                                      ),
                                    ]));
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      partID = value;
                                      if (partID != null)
                                        errMsgPartName = false;
                                    });
                                  },
                                  isExpanded: true,
                                ),
                                Visibility(
                                  visible: errMsgPartName,
                                  maintainSize: false,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  child: Text(
                                    "Please choose Part Name",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              controller: variantNotes,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Variant"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              // Disabled Validation for part notes
                              //validator: validateNotes,
                              controller: productNotes,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Notes (Optional)"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              validator: validatePrice,
                              controller: productPrice,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Price (without VAT)",
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text("Quality "),
                                  RatingBar(
                                    initialRating: rating,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (updatedRating) {
                                      print(updatedRating);
                                      setState(() {
                                        rating = updatedRating;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(child: Text("Photos")),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(5.0),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      child: _image1 == null
                                          ? IconButton(
                                              onPressed: getImage1,
                                              icon: Icon(Icons.add_a_photo),
                                            )
                                          : Stack(
                                              children: <Widget>[
                                                Image.file(
                                                  _image1,
                                                  height: 60,
                                                  width: 60,
                                                ),
                                                closeButton(1),
                                              ],
                                            ),
                                    ),
                                    Text(imageTitleOne),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(5.0),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      child: _image2 == null
                                          ? IconButton(
                                              onPressed: getImage2,
                                              icon: Icon(Icons.add_a_photo),
                                            )
                                          : Stack(
                                              children: <Widget>[
                                                Image.file(
                                                  _image2,
                                                  height: 60,
                                                  width: 60,
                                                ),
                                                closeButton(2),
                                              ],
                                            ),
                                    ),
                                    Text(imageTitleTwo),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(5.0),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      child: _image3 == null
                                          ? IconButton(
                                              onPressed: getImage3,
                                              icon: Icon(Icons.add_a_photo),
                                            )
                                          : Stack(
                                              children: <Widget>[
                                                Image.file(
                                                  _image3,
                                                  height: 60,
                                                  width: 60,
                                                ),
                                                closeButton(3),
                                              ],
                                            ),
                                    ),
                                    Text(imageTitleThree),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: errMsgImages,
                            maintainSize: false,
                            maintainAnimation: true,
                            maintainState: true,
                            child: Text(
                              "First two images are Mandatory",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: RaisedButton(
                                  elevation: 10,
                                  onPressed: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => AddProduct()),
                                        (Route<dynamic> route) => false);
                                  },
                                  child: Text(
                                    "Clear",
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: addMoreBtnVisibility,
                                maintainSize: false,
                                maintainAnimation: true,
                                maintainState: true,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: RaisedButton(
                                    elevation: 10,
                                    onPressed: () {
                                      _validateInputs(2);
                                    },
                                    child: Text(
                                      "Add More",
                                      style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: RaisedButton(
                                  elevation: 10,
                                  onPressed: () {
                                    _validateInputs(1);
                                  },
                                  child: Text(
                                    "Done",
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ])
                      : new Container(),
                ],
              ),
            ),
          );
  }

  Widget closeButton(int value) {
    return Positioned(
      right: -2.0,
      top: -2.0,
      child: GestureDetector(
        onTap: () {
          getImageClear(value);
        },
        child: Align(
          alignment: Alignment.topRight,
          child: CircleAvatar(
            radius: 12.0,
            backgroundColor: Colors.white,
            child: Icon(Icons.remove_circle_outline, color: Colors.redAccent),
          ),
        ),
      ),
    );
  }
}
