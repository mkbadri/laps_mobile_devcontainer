class Products {
  int _productId;
  int _vehicleId;
  String _vehicleMake;
  String _vehicleModel;
  String _vehicleVariant;
  String _vehicleYear;
  int _partId;
  String _partName;
  int _merchantId;
  String _merchantName;
  int _productInstore;
  String _productNotes;
  int _productQuality;
  int _productPrice;
  String _productChassisnum;

  Products(Map<String, dynamic> json){
    _productId = json['product_id'];
    _vehicleId = json['vehicle_id'];
    _vehicleMake = json['vehicle_make'];
    _vehicleModel = json['vehicle_model'];
    _vehicleVariant = json['vehicle_variant'];
    _vehicleYear = json['vehicle_year'];
    _partId = json['part_id'];
    _partName = json['part_name'];
    _merchantId = json['merchant_id'];
    _merchantName = json['merchant_name'];
    _productInstore = json['product_instore'];
    _productNotes = json['product_notes'];
    _productQuality = json['product_quality'];
    _productPrice = json['product_price'];
    _productChassisnum = json['product_chassisnum'];
  }

  int get productId => _productId;
  set productId(int productId) => _productId = productId;
  int get vehicleId => _vehicleId;
  set vehicleId(int vehicleId) => _vehicleId = vehicleId;
  String get vehicleMake => _vehicleMake;
  set vehicleMake(String vehicleMake) => _vehicleMake = vehicleMake;
  String get vehicleModel => _vehicleModel;
  set vehicleModel(String vehicleModel) => _vehicleModel = vehicleModel;
  String get vehicleVariant => _vehicleVariant;
  set vehicleVariant(String vehicleVariant) => _vehicleVariant = vehicleVariant;
  String get vehicleYear => _vehicleYear;
  set vehicleYear(String vehicleYear) => _vehicleYear = vehicleYear;
  int get partId => _partId;
  set partId(int partId) => _partId = partId;
  String get partName => _partName;
  set partName(String partName) => _partName = partName;
  int get merchantId => _merchantId;
  set merchantId(int merchantId) => _merchantId = merchantId;
  String get merchantName => _merchantName;
  set merchantName(String merchantName) => _merchantName = merchantName;
  int get productInstore => _productInstore;
  set productInstore(int productInstore) => _productInstore = productInstore;
  String get productNotes => _productNotes;
  set productNotes(String productNotes) => _productNotes = productNotes;
  int get productQuality => _productQuality;
  set productQuality(int productQuality) => _productQuality = productQuality;
  int get productPrice => _productPrice;
  set productPrice(int productPrice) => _productPrice = productPrice;
  String get productChassisnum => _productChassisnum;
  set productChassisnum(String productChassisnum) =>
      _productChassisnum = productChassisnum;

}
