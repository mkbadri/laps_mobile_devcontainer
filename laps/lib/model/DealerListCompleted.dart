class DealerListCompleted {
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
  Part _part;
  Merchant _merchant;
  List<Productimages> _productimages;
  List<Productreqact> _productreqact;

  DealerListCompleted(
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
      Vehicle vehicle,
      Part part,
      Merchant merchant,
      List<Productimages> productimages,
      List<Productreqact> productreqact}) {
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
    this._part = part;
    this._merchant = merchant;
    this._productimages = productimages;
    this._productreqact = productreqact;
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
  Part get part => _part;
  set part(Part part) => _part = part;
  Merchant get merchant => _merchant;
  set merchant(Merchant merchant) => _merchant = merchant;
  List<Productimages> get productimages => _productimages;
  set productimages(List<Productimages> productimages) =>
      _productimages = productimages;
  List<Productreqact> get productreqact => _productreqact;
  set productreqact(List<Productreqact> productreqact) =>
      _productreqact = productreqact;

  DealerListCompleted.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _productNotes = json['productNotes'] != null ? json['productNotes'] : '';
    _productQuality =
        json['productQuality'] != null ? json['productQuality'].toDouble() : 0;
    _productPrice =
        json['productPrice'] != null ? json['productPrice'].toDouble() : 0;
    _productChassisnum = json['productChassisnum'];
    _productInstore = json['productInstore'];
    _productVariant =
        json['productVariant'] != null ? json['productVariant'] : '';
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
    _part = json['part'] != null ? new Part.fromJson(json['part']) : null;
    _merchant = json['merchant'] != null
        ? new Merchant.fromJson(json['merchant'])
        : null;
    if (json['productimages'] != null) {
      _productimages = new List<Productimages>();
      json['productimages'].forEach((v) {
        _productimages.add(new Productimages.fromJson(v));
      });
    }
    if (json['productreqact'] != null) {
      _productreqact = new List<Productreqact>();
      json['productreqact'].forEach((v) {
        _productreqact.add(new Productreqact.fromJson(v));
      });
    }
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
    if (this._part != null) {
      data['part'] = this._part.toJson();
    }
    if (this._merchant != null) {
      data['merchant'] = this._merchant.toJson();
    }
    if (this._productimages != null) {
      data['productimages'] =
          this._productimages.map((v) => v.toJson()).toList();
    }
    if (this._productreqact != null) {
      data['productreqact'] =
          this._productreqact.map((v) => v.toJson()).toList();
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

class Part {
  int _id;
  String _partName;
  String _partStatus;
  int _createdby;
  String _createdon;
  int _updatedby;
  String _updatedon;

  Part(
      {int id,
      String partName,
      String partStatus,
      int createdby,
      String createdon,
      int updatedby,
      String updatedon}) {
    this._id = id;
    this._partName = partName;
    this._partStatus = partStatus;
    this._createdby = createdby;
    this._createdon = createdon;
    this._updatedby = updatedby;
    this._updatedon = updatedon;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get partName => _partName;
  set partName(String partName) => _partName = partName;
  String get partStatus => _partStatus;
  set partStatus(String partStatus) => _partStatus = partStatus;
  int get createdby => _createdby;
  set createdby(int createdby) => _createdby = createdby;
  String get createdon => _createdon;
  set createdon(String createdon) => _createdon = createdon;
  int get updatedby => _updatedby;
  set updatedby(int updatedby) => _updatedby = updatedby;
  String get updatedon => _updatedon;
  set updatedon(String updatedon) => _updatedon = updatedon;

  Part.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _partName = json['partName'];
    _partStatus = json['part_status'];
    _createdby = json['createdby'];
    _createdon = json['createdon'];
    _updatedby = json['updatedby'];
    _updatedon = json['updatedon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['partName'] = this._partName;
    data['part_status'] = this._partStatus;
    data['createdby'] = this._createdby;
    data['createdon'] = this._createdon;
    data['updatedby'] = this._updatedby;
    data['updatedon'] = this._updatedon;
    return data;
  }
}

class Merchant {
  int _id;
  String _merchantName;
  String _merchantAddress;
  String _merchantContactno;
  int _roleType;
  String _merchantStatus;
  int _createdby;
  String _createdon;
  int _updatedby;
  String _updatedon;

  Merchant(
      {int id,
      String merchantName,
      String merchantAddress,
      String merchantContactno,
      int roleType,
      String merchantStatus,
      int createdby,
      String createdon,
      int updatedby,
      String updatedon}) {
    this._id = id;
    this._merchantName = merchantName;
    this._merchantAddress = merchantAddress;
    this._merchantContactno = merchantContactno;
    this._roleType = roleType;
    this._merchantStatus = merchantStatus;
    this._createdby = createdby;
    this._createdon = createdon;
    this._updatedby = updatedby;
    this._updatedon = updatedon;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get merchantName => _merchantName;
  set merchantName(String merchantName) => _merchantName = merchantName;
  String get merchantAddress => _merchantAddress;
  set merchantAddress(String merchantAddress) =>
      _merchantAddress = merchantAddress;
  String get merchantContactno => _merchantContactno;
  set merchantContactno(String merchantContactno) =>
      _merchantContactno = merchantContactno;
  int get roleType => _roleType;
  set roleType(int roleType) => _roleType = roleType;
  String get merchantStatus => _merchantStatus;
  set merchantStatus(String merchantStatus) => _merchantStatus = merchantStatus;
  int get createdby => _createdby;
  set createdby(int createdby) => _createdby = createdby;
  String get createdon => _createdon;
  set createdon(String createdon) => _createdon = createdon;
  int get updatedby => _updatedby;
  set updatedby(int updatedby) => _updatedby = updatedby;
  String get updatedon => _updatedon;
  set updatedon(String updatedon) => _updatedon = updatedon;

  Merchant.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _merchantName = json['merchant_name'];
    _merchantAddress = json['merchant_address'];
    _merchantContactno = json['merchant_contactno'];
    _roleType = json['role_type'];
    _merchantStatus = json['merchant_status'];
    _createdby = json['createdby'];
    _createdon = json['createdon'];
    _updatedby = json['updatedby'];
    _updatedon = json['updatedon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['merchant_name'] = this._merchantName;
    data['merchant_address'] = this._merchantAddress;
    data['merchant_contactno'] = this._merchantContactno;
    data['role_type'] = this._roleType;
    data['merchant_status'] = this._merchantStatus;
    data['createdby'] = this._createdby;
    data['createdon'] = this._createdon;
    data['updatedby'] = this._updatedby;
    data['updatedon'] = this._updatedon;
    return data;
  }
}

class Productimages {
  int _id;
  String _imageName;
  String _imageUrl;
  String _imageCaption;
  String _thumbnailUrl;
  int _profileImage;
  String _addInfo1;
  String _addInfo2;
  String _addInfo3;
  String _addInfo4;
  int _productId;

  Productimages(
      {int id,
      String imageName,
      String imageUrl,
      String imageCaption,
      String thumbnailUrl,
      int profileImage,
      String addInfo1,
      String addInfo2,
      String addInfo3,
      String addInfo4,
      int productId}) {
    this._id = id;
    this._imageName = imageName;
    this._imageUrl = imageUrl;
    this._imageCaption = imageCaption;
    this._thumbnailUrl = thumbnailUrl;
    this._profileImage = profileImage;
    this._addInfo1 = addInfo1;
    this._addInfo2 = addInfo2;
    this._addInfo3 = addInfo3;
    this._addInfo4 = addInfo4;
    this._productId = productId;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get imageName => _imageName;
  set imageName(String imageName) => _imageName = imageName;
  String get imageUrl => _imageUrl;
  set imageUrl(String imageUrl) => _imageUrl = imageUrl;
  String get imageCaption => _imageCaption;
  set imageCaption(String imageCaption) => _imageCaption = imageCaption;
  String get thumbnailUrl => _thumbnailUrl;
  set thumbnailUrl(String thumbnailUrl) => _thumbnailUrl = thumbnailUrl;
  int get profileImage => _profileImage;
  set profileImage(int profileImage) => _profileImage = profileImage;
  String get addInfo1 => _addInfo1;
  set addInfo1(String addInfo1) => _addInfo1 = addInfo1;
  String get addInfo2 => _addInfo2;
  set addInfo2(String addInfo2) => _addInfo2 = addInfo2;
  String get addInfo3 => _addInfo3;
  set addInfo3(String addInfo3) => _addInfo3 = addInfo3;
  String get addInfo4 => _addInfo4;
  set addInfo4(String addInfo4) => _addInfo4 = addInfo4;
  int get productId => _productId;
  set productId(int productId) => _productId = productId;

  Productimages.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _imageName = json['imageName'];
    _imageUrl = json['imageUrl'];
    _imageCaption = json['imageCaption'];
    _thumbnailUrl = json['thumbnailUrl'];
    _profileImage = json['profileImage'];
    _addInfo1 = json['addInfo1'];
    _addInfo2 = json['addInfo2'];
    _addInfo3 = json['addInfo3'];
    _addInfo4 = json['addInfo4'];
    _productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['imageName'] = this._imageName;
    data['imageUrl'] = this._imageUrl;
    data['imageCaption'] = this._imageCaption;
    data['thumbnailUrl'] = this._thumbnailUrl;
    data['profileImage'] = this._profileImage;
    data['addInfo1'] = this._addInfo1;
    data['addInfo2'] = this._addInfo2;
    data['addInfo3'] = this._addInfo3;
    data['addInfo4'] = this._addInfo4;
    data['product_id'] = this._productId;
    return data;
  }
}

class Productreqact {
  int _id;
  int _reqId;
  int _reqagnId;
  String _requestId;
  int _workshopId;
  int _vehicleId;
  int _partId;
  int _agentId;
  int _dealerId;
  int _productId;
  int _status;
  String _reqStatus;
  int _agntreqUserid;
  String _agntreqDatetime;
  int _dlerresUserid;
  String _dlerresDatetime;
  double _dealerPrice;
  int _agntrlsUserid;
  String _agntrlsDatetime;
  double _agentPrice;
  int _quantity;

  Productreqact(
      {int id,
      int reqId,
      int reqagnId,
      String requestId,
      int workshopId,
      int vehicleId,
      int partId,
      int agentId,
      int dealerId,
      int productId,
      int status,
      String reqStatus,
      int agntreqUserid,
      String agntreqDatetime,
      int dlerresUserid,
      String dlerresDatetime,
      double dealerPrice,
      int agntrlsUserid,
      String agntrlsDatetime,
      double agentPrice,
      int quantity}) {
    this._id = id;
    this._reqId = reqId;
    this._reqagnId = reqagnId;
    this._requestId = requestId;
    this._workshopId = workshopId;
    this._vehicleId = vehicleId;
    this._partId = partId;
    this._agentId = agentId;
    this._dealerId = dealerId;
    this._productId = productId;
    this._status = status;
    this._reqStatus = reqStatus;
    this._agntreqUserid = agntreqUserid;
    this._agntreqDatetime = agntreqDatetime;
    this._dlerresUserid = dlerresUserid;
    this._dlerresDatetime = dlerresDatetime;
    this._dealerPrice = dealerPrice;
    this._agntrlsUserid = agntrlsUserid;
    this._agntrlsDatetime = agntrlsDatetime;
    this._agentPrice = agentPrice;
    this._quantity = quantity;
  }

  int get id => _id;
  set id(int id) => _id = id;
  int get reqId => _reqId;
  set reqId(int reqId) => _reqId = reqId;
  int get reqagnId => _reqagnId;
  set reqagnId(int reqagnId) => _reqagnId = reqagnId;
  String get requestId => _requestId;
  set requestId(String requestId) => _requestId = requestId;
  int get workshopId => _workshopId;
  set workshopId(int workshopId) => _workshopId = workshopId;
  int get vehicleId => _vehicleId;
  set vehicleId(int vehicleId) => _vehicleId = vehicleId;
  int get partId => _partId;
  set partId(int partId) => _partId = partId;
  int get agentId => _agentId;
  set agentId(int agentId) => _agentId = agentId;
  int get dealerId => _dealerId;
  set dealerId(int dealerId) => _dealerId = dealerId;
  int get productId => _productId;
  set productId(int productId) => _productId = productId;
  int get status => _status;
  set status(int status) => _status = status;
  String get reqStatus => _reqStatus;
  set reqStatus(String reqStatus) => _reqStatus = reqStatus;
  int get agntreqUserid => _agntreqUserid;
  set agntreqUserid(int agntreqUserid) => _agntreqUserid = agntreqUserid;
  String get agntreqDatetime => _agntreqDatetime;
  set agntreqDatetime(String agntreqDatetime) =>
      _agntreqDatetime = agntreqDatetime;
  int get dlerresUserid => _dlerresUserid;
  set dlerresUserid(int dlerresUserid) => _dlerresUserid = dlerresUserid;
  String get dlerresDatetime => _dlerresDatetime;
  set dlerresDatetime(String dlerresDatetime) =>
      _dlerresDatetime = dlerresDatetime;
  double get dealerPrice => _dealerPrice;
  set dealerPrice(double dealerPrice) => _dealerPrice = dealerPrice;
  int get agntrlsUserid => _agntrlsUserid;
  set agntrlsUserid(int agntrlsUserid) => _agntrlsUserid = agntrlsUserid;
  String get agntrlsDatetime => _agntrlsDatetime;
  set agntrlsDatetime(String agntrlsDatetime) =>
      _agntrlsDatetime = agntrlsDatetime;
  double get agentPrice => _agentPrice;
  set agentPrice(double agentPrice) => _agentPrice = agentPrice;
  int get quantity => _quantity;
  set quantity(int quantity) => _quantity = quantity;

  Productreqact.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _reqId = json['req_id'];
    _reqagnId = json['reqagn_id'];
    _requestId = json['requestId'];
    _workshopId = json['workshop_id'];
    _vehicleId = json['vehicle_id'];
    _partId = json['part_id'];
    _agentId = json['agent_id'];
    _dealerId = json['dealer_id'];
    _productId = json['product_id'];
    _status = json['status'];
    _reqStatus = json['reqStatus'];
    _agntreqUserid = json['agntreqUserid'];
    _agntreqDatetime = json['agntreqDatetime'];
    _dlerresUserid = json['dlerresUserid'];
    _dlerresDatetime = json['dlerresDatetime'];
    _dealerPrice =
        json['dealerPrice'] != null ? json['dealerPrice'].toDouble() : 0;
    _agntrlsUserid = json['agntrlsUserid'];
    _agntrlsDatetime = json['agntrlsDatetime'];
    _agentPrice =
        json['agentPrice'] != null ? json['agentPrice'].toDouble() : 0;
    _quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['req_id'] = this._reqId;
    data['reqagn_id'] = this._reqagnId;
    data['requestId'] = this._requestId;
    data['workshop_id'] = this._workshopId;
    data['vehicle_id'] = this._vehicleId;
    data['part_id'] = this._partId;
    data['agent_id'] = this._agentId;
    data['dealer_id'] = this._dealerId;
    data['product_id'] = this._productId;
    data['status'] = this._status;
    data['reqStatus'] = this._reqStatus;
    data['agntreqUserid'] = this._agntreqUserid;
    data['agntreqDatetime'] = this._agntreqDatetime;
    data['dlerresUserid'] = this._dlerresUserid;
    data['dlerresDatetime'] = this._dlerresDatetime;
    data['dealerPrice'] = this._dealerPrice;
    data['agntrlsUserid'] = this._agntrlsUserid;
    data['agntrlsDatetime'] = this._agntrlsDatetime;
    data['agentPrice'] = this._agentPrice;
    data['quantity'] = this._quantity;
    return data;
  }
}
