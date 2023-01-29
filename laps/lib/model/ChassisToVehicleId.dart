class ChassisToVehicleId {
  int _id;
  String _productNotes;
  double _productQuality;
  double _productPrice;
  String _productChassisnum;
  int _productInstore;
  String _productVariant;
  String _notesAddtl1;
  int _productQuantity;
  String _productStatus;
  double _productSoldprice;
  int _createdby;
  String _createdon;
  int _updatedby;
  String _updatedon;
  int _vehicleId;
  int _partId;
  int _merchantId;
  Vehicle _vehicle;

  ChassisToVehicleId(
      {int id,
      String productNotes,
      double productQuality,
      double productPrice,
      String productChassisnum,
      int productInstore,
      String productVariant,
      String notesAddtl1,
      int productQuantity,
      String productStatus,
      double productSoldprice,
      int createdby,
      String createdon,
      int updatedby,
      String updatedon,
      int vehicleId,
      int partId,
      int merchantId,
      Vehicle vehicle}) {
    this._id = id;
    this._productNotes = productNotes;
    this._productQuality = productQuality;
    this._productPrice = productPrice;
    this._productChassisnum = productChassisnum;
    this._productInstore = productInstore;
    this._productVariant = productVariant;
    this._notesAddtl1 = notesAddtl1;
    this._productQuantity = productQuantity;
    this._productStatus = productStatus;
    this._productSoldprice = productSoldprice;
    this._createdby = createdby;
    this._createdon = createdon;
    this._updatedby = updatedby;
    this._updatedon = updatedon;
    this._vehicleId = vehicleId;
    this._partId = partId;
    this._merchantId = merchantId;
    this._vehicle = vehicle;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get productNotes => _productNotes;
  set productNotes(String productNotes) => _productNotes = productNotes;
  double get productQuality => _productQuality;
  set productQuality(double productQuality) => _productQuality = productQuality;
  double get productPrice => _productPrice;
  set productPrice(double productPrice) => _productPrice = productPrice;
  String get productChassisnum => _productChassisnum;
  set productChassisnum(String productChassisnum) =>
      _productChassisnum = productChassisnum;
  int get productInstore => _productInstore;
  set productInstore(int productInstore) => _productInstore = productInstore;
  String get productVariant => _productVariant;
  set productVariant(String productVariant) => _productVariant = productVariant;
  String get notesAddtl1 => _notesAddtl1;
  set notesAddtl1(String notesAddtl1) => _notesAddtl1 = notesAddtl1;
  int get productQuantity => _productQuantity;
  set productQuantity(int productQuantity) =>
      _productQuantity = productQuantity;
  String get productStatus => _productStatus;
  set productStatus(String productStatus) => _productStatus = productStatus;
  double get productSoldprice => _productSoldprice;
  set productSoldprice(double productSoldprice) =>
      _productSoldprice = productSoldprice;
  int get createdby => _createdby;
  set createdby(int createdby) => _createdby = createdby;
  String get createdon => _createdon;
  set createdon(String createdon) => _createdon = createdon;
  int get updatedby => _updatedby;
  set updatedby(int updatedby) => _updatedby = updatedby;
  String get updatedon => _updatedon;
  set updatedon(String updatedon) => _updatedon = updatedon;
  int get vehicleId => _vehicleId;
  set vehicleId(int vehicleId) => _vehicleId = vehicleId;
  int get partId => _partId;
  set partId(int partId) => _partId = partId;
  int get merchantId => _merchantId;
  set merchantId(int merchantId) => _merchantId = merchantId;
  Vehicle get vehicle => _vehicle;
  set vehicle(Vehicle vehicle) => _vehicle = vehicle;

  ChassisToVehicleId.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _productNotes = json['productNotes'];
    _productQuality =
        json['productQuality'] != null ? json['productQuality'].toDouble() : 0;
    _productPrice =
        json['productPrice'] != null ? json['productPrice'].toDouble() : 0;
    _productChassisnum = json['productChassisnum'];
    _productInstore = json['productInstore'];
    _productVariant = json['productVariant'];
    _notesAddtl1 = json['notesAddtl1'];
    _productQuantity = json['productQuantity'];
    _productStatus = json['productStatus'];
    _productSoldprice = json['productSoldprice'] != null
        ? json['productSoldprice'].toDouble()
        : 0;
    _createdby = json['createdby'];
    _createdon = json['createdon'];
    _updatedby = json['updatedby'];
    _updatedon = json['updatedon'];
    _vehicleId = json['vehicle_id'];
    _partId = json['part_id'];
    _merchantId = json['merchant_id'];
    _vehicle =
        json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['productNotes'] = this._productNotes;
    data['productQuality'] = this._productQuality;
    data['productPrice'] = this._productPrice;
    data['productChassisnum'] = this._productChassisnum;
    data['productInstore'] = this._productInstore;
    data['productVariant'] = this._productVariant;
    data['notesAddtl1'] = this._notesAddtl1;
    data['productQuantity'] = this._productQuantity;
    data['productStatus'] = this._productStatus;
    data['productSoldprice'] = this._productSoldprice;
    data['createdby'] = this._createdby;
    data['createdon'] = this._createdon;
    data['updatedby'] = this._updatedby;
    data['updatedon'] = this._updatedon;
    data['vehicle_id'] = this._vehicleId;
    data['part_id'] = this._partId;
    data['merchant_id'] = this._merchantId;
    if (this._vehicle != null) {
      data['vehicle'] = this._vehicle.toJson();
    }
    return data;
  }
}

class Vehicle {
  int _id;
  String _vehicleMake;
  String _vehicleModel;
  String _vehicleVariant;
  String _vehicleYear;
  String _vehicleStatus;
  int _createdby;
  String _createdon;
  int _updatedby;
  String _updatedon;

  Vehicle(
      {int id,
      String vehicleMake,
      String vehicleModel,
      String vehicleVariant,
      String vehicleYear,
      String vehicleStatus,
      int createdby,
      String createdon,
      int updatedby,
      String updatedon}) {
    this._id = id;
    this._vehicleMake = vehicleMake;
    this._vehicleModel = vehicleModel;
    this._vehicleVariant = vehicleVariant;
    this._vehicleYear = vehicleYear;
    this._vehicleStatus = vehicleStatus;
    this._createdby = createdby;
    this._createdon = createdon;
    this._updatedby = updatedby;
    this._updatedon = updatedon;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get vehicleMake => _vehicleMake;
  set vehicleMake(String vehicleMake) => _vehicleMake = vehicleMake;
  String get vehicleModel => _vehicleModel;
  set vehicleModel(String vehicleModel) => _vehicleModel = vehicleModel;
  String get vehicleVariant => _vehicleVariant;
  set vehicleVariant(String vehicleVariant) => _vehicleVariant = vehicleVariant;
  String get vehicleYear => _vehicleYear;
  set vehicleYear(String vehicleYear) => _vehicleYear = vehicleYear;
  String get vehicleStatus => _vehicleStatus;
  set vehicleStatus(String vehicleStatus) => _vehicleStatus = vehicleStatus;
  int get createdby => _createdby;
  set createdby(int createdby) => _createdby = createdby;
  String get createdon => _createdon;
  set createdon(String createdon) => _createdon = createdon;
  int get updatedby => _updatedby;
  set updatedby(int updatedby) => _updatedby = updatedby;
  String get updatedon => _updatedon;
  set updatedon(String updatedon) => _updatedon = updatedon;

  Vehicle.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _vehicleMake = json['vehicle_make'];
    _vehicleModel = json['vehicle_model'];
    _vehicleVariant = json['vehicle_variant'];
    _vehicleYear = json['vehicle_year'];
    _vehicleStatus = json['vehicle_status'];
    _createdby = json['createdby'];
    _createdon = json['createdon'];
    _updatedby = json['updatedby'];
    _updatedon = json['updatedon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['vehicle_make'] = this._vehicleMake;
    data['vehicle_model'] = this._vehicleModel;
    data['vehicle_variant'] = this._vehicleVariant;
    data['vehicle_year'] = this._vehicleYear;
    data['vehicle_status'] = this._vehicleStatus;
    data['createdby'] = this._createdby;
    data['createdon'] = this._createdon;
    data['updatedby'] = this._updatedby;
    data['updatedon'] = this._updatedon;
    return data;
  }
}
