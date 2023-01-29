class AgentListSupplierHome {
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
  Reqtab _reqtab;
  Vehicle _vehicle;
  Part _part;
  Agent _agent;
  Agent _dealer;
  Product _product;

  AgentListSupplierHome(
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
      int quantity,
      Reqtab reqtab,
      Vehicle vehicle,
      Part part,
      Agent agent,
      Agent dealer,
      Product product}) {
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
    this._reqtab = reqtab;
    this._vehicle = vehicle;
    this._part = part;
    this._agent = agent;
    this._dealer = dealer;
    this._product = product;
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
  Reqtab get reqtab => _reqtab;
  set reqtab(Reqtab reqtab) => _reqtab = reqtab;
  Vehicle get vehicle => _vehicle;
  set vehicle(Vehicle vehicle) => _vehicle = vehicle;
  Part get part => _part;
  set part(Part part) => _part = part;
  Agent get agent => _agent;
  set agent(Agent agent) => _agent = agent;
  Agent get dealer => _dealer;
  set dealer(Agent dealer) => _dealer = dealer;
  Product get product => _product;
  set product(Product product) => _product = product;

  AgentListSupplierHome.fromJson(Map<String, dynamic> json) {
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
    _dealerPrice = json['dealerPrice'] != null ? json['dealerPrice'].toDouble() : 0;
    _agntrlsUserid = json['agntrlsUserid'];
    _agntrlsDatetime = json['agntrlsDatetime'];
    _agentPrice = json['agentPrice'] != null ? json['agentPrice'].toDouble() : 0;
    _quantity = json['quantity'];
    _reqtab =
        json['reqtab'] != null ? new Reqtab.fromJson(json['reqtab']) : null;
    _vehicle =
        json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;
    _part = json['part'] != null ? new Part.fromJson(json['part']) : null;
    _agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    _dealer =
        json['dealer'] != null ? new Agent.fromJson(json['dealer']) : null;
    _product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
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
    if (this._reqtab != null) {
      data['reqtab'] = this._reqtab.toJson();
    }
    if (this._vehicle != null) {
      data['vehicle'] = this._vehicle.toJson();
    }
    if (this._part != null) {
      data['part'] = this._part.toJson();
    }
    if (this._agent != null) {
      data['agent'] = this._agent.toJson();
    }
    if (this._dealer != null) {
      data['dealer'] = this._dealer.toJson();
    }
    if (this._product != null) {
      data['product'] = this._product.toJson();
    }
    return data;
  }
}

class Reqtab {
  int _id;
  String _requestId;
  String _requestDate;
  String _expiryDate;
  String _irn;
  int _workshopId;
  int _vehicleId;
  String _make;
  String _model;
  String _variant;
  String _year;
  int _partId;
  String _partName;
  int _dealerId;
  int _agentId;
  int _productId;
  String _notes;
  double _quality;
  double _price;
  String _chassis;
  int _instore;
  double _finalPrice;
  int _quantity;
  int _status;
  int _createdby;
  String _createdon;
  int _updatedby;
  String _updatedon;

  Reqtab(
      {int id,
      String requestId,
      String requestDate,
      String expiryDate,
      String irn,
      int workshopId,
      int vehicleId,
      String make,
      String model,
      String variant,
      String year,
      int partId,
      String partName,
      int dealerId,
      int agentId,
      int productId,
      String notes,
      double quality,
      double price,
      String chassis,
      int instore,
      double finalPrice,
      int quantity,
      int status,
      int createdby,
      String createdon,
      int updatedby,
      String updatedon}) {
    this._id = id;
    this._requestId = requestId;
    this._requestDate = requestDate;
    this._expiryDate = expiryDate;
    this._irn = irn;
    this._workshopId = workshopId;
    this._vehicleId = vehicleId;
    this._make = make;
    this._model = model;
    this._variant = variant;
    this._year = year;
    this._partId = partId;
    this._partName = partName;
    this._dealerId = dealerId;
    this._agentId = agentId;
    this._productId = productId;
    this._notes = notes;
    this._quality = quality;
    this._price = price;
    this._chassis = chassis;
    this._instore = instore;
    this._finalPrice = finalPrice;
    this._quantity = quantity;
    this._status = status;
    this._createdby = createdby;
    this._createdon = createdon;
    this._updatedby = updatedby;
    this._updatedon = updatedon;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get requestId => _requestId;
  set requestId(String requestId) => _requestId = requestId;
  String get requestDate => _requestDate;
  set requestDate(String requestDate) => _requestDate = requestDate;
  String get expiryDate => _expiryDate;
  set expiryDate(String expiryDate) => _expiryDate = expiryDate;
  String get irn => _irn;
  set irn(String irn) => _irn = irn;
  int get workshopId => _workshopId;
  set workshopId(int workshopId) => _workshopId = workshopId;
  int get vehicleId => _vehicleId;
  set vehicleId(int vehicleId) => _vehicleId = vehicleId;
  String get make => _make;
  set make(String make) => _make = make;
  String get model => _model;
  set model(String model) => _model = model;
  String get variant => _variant;
  set variant(String variant) => _variant = variant;
  String get year => _year;
  set year(String year) => _year = year;
  int get partId => _partId;
  set partId(int partId) => _partId = partId;
  String get partName => _partName;
  set partName(String partName) => _partName = partName;
  int get dealerId => _dealerId;
  set dealerId(int dealerId) => _dealerId = dealerId;
  int get agentId => _agentId;
  set agentId(int agentId) => _agentId = agentId;
  int get productId => _productId;
  set productId(int productId) => _productId = productId;
  String get notes => _notes;
  set notes(String notes) => _notes = notes;
  double get quality => _quality;
  set quality(double quality) => _quality = quality;
  double get price => _price;
  set price(double price) => _price = price;
  String get chassis => _chassis;
  set chassis(String chassis) => _chassis = chassis;
  int get instore => _instore;
  set instore(int instore) => _instore = instore;
  double get finalPrice => _finalPrice;
  set finalPrice(double finalPrice) => _finalPrice = finalPrice;
  int get quantity => _quantity;
  set quantity(int quantity) => _quantity = quantity;
  int get status => _status;
  set status(int status) => _status = status;
  int get createdby => _createdby;
  set createdby(int createdby) => _createdby = createdby;
  String get createdon => _createdon;
  set createdon(String createdon) => _createdon = createdon;
  int get updatedby => _updatedby;
  set updatedby(int updatedby) => _updatedby = updatedby;
  String get updatedon => _updatedon;
  set updatedon(String updatedon) => _updatedon = updatedon;

  Reqtab.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _requestId = json['requestId'];
    _requestDate = json['requestDate'];
    _expiryDate = json['expiryDate'];
    _irn = json['irn'];
    _workshopId = json['workshopId'];
    _vehicleId = json['vehicleId'];
    _make = json['make'];
    _model = json['model'];
    _variant = json['variant'];
    _year = json['year'];
    _partId = json['partId'];
    _partName = json['partName'];
    _dealerId = json['dealerId'];
    _agentId = json['agentId'];
    _productId = json['productId'];
    _notes = json['notes'];
    _quality = json['quality'] != null ? json['quality'].toDouble() : 0;
    _price = json['price'] != null ? json['price'].toDouble() : 0;
    _chassis = json['chassis'];
    _instore = json['instore'];
    _finalPrice = json['finalPrice'] != null ? json['finalPrice'].toDouble() : 0;
    _quantity = json['quantity'];
    _status = json['status'];
    _createdby = json['createdby'];
    _createdon = json['createdon'];
    _updatedby = json['updatedby'];
    _updatedon = json['updatedon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['requestId'] = this._requestId;
    data['requestDate'] = this._requestDate;
    data['expiryDate'] = this._expiryDate;
    data['irn'] = this._irn;
    data['workshopId'] = this._workshopId;
    data['vehicleId'] = this._vehicleId;
    data['make'] = this._make;
    data['model'] = this._model;
    data['variant'] = this._variant;
    data['year'] = this._year;
    data['partId'] = this._partId;
    data['partName'] = this._partName;
    data['dealerId'] = this._dealerId;
    data['agentId'] = this._agentId;
    data['productId'] = this._productId;
    data['notes'] = this._notes;
    data['quality'] = this._quality;
    data['price'] = this._price;
    data['chassis'] = this._chassis;
    data['instore'] = this._instore;
    data['finalPrice'] = this._finalPrice;
    data['quantity'] = this._quantity;
    data['status'] = this._status;
    data['createdby'] = this._createdby;
    data['createdon'] = this._createdon;
    data['updatedby'] = this._updatedby;
    data['updatedon'] = this._updatedon;
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

class Agent {
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

  Agent(
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

  Agent.fromJson(Map<String, dynamic> json) {
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

class Product {
  int _id;
  String _productNotes;
  double _productQuality;
  double _productPrice;
  String _productChassisnum;
  int _productInstore;
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

  Product(
      {int id,
      String productNotes,
      double productQuality,
      double productPrice,
      String productChassisnum,
      int productInstore,
      int productQuantity,
      String productStatus,
      double productSoldprice,
      int createdby,
      String createdon,
      int updatedby,
      String updatedon,
      int vehicleId,
      int partId,
      int merchantId}) {
    this._id = id;
    this._productNotes = productNotes;
    this._productQuality = productQuality;
    this._productPrice = productPrice;
    this._productChassisnum = productChassisnum;
    this._productInstore = productInstore;
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

  Product.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _productNotes = json['productNotes'];
    _productQuality = json['productQuality'] != null ? json['productQuality'].toDouble() : 0;
    _productPrice = json['productPrice'] != null ? json['productPrice'].toDouble() : 0;
    _productChassisnum = json['productChassisnum'];
    _productInstore = json['productInstore'];
    _productQuantity = json['productQuantity'];
    _productStatus = json['productStatus'];
    _productSoldprice = json['productSoldprice'] != null ? json['productSoldprice'].toDouble() : 0;
    _createdby = json['createdby'];
    _createdon = json['createdon'];
    _updatedby = json['updatedby'];
    _updatedon = json['updatedon'];
    _vehicleId = json['vehicle_id'];
    _partId = json['part_id'];
    _merchantId = json['merchant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['productNotes'] = this._productNotes;
    data['productQuality'] = this._productQuality;
    data['productPrice'] = this._productPrice;
    data['productChassisnum'] = this._productChassisnum;
    data['productInstore'] = this._productInstore;
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
    return data;
  }
}

class AgentsDealerList {
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

  AgentsDealerList(
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

  AgentsDealerList.fromJson(Map<String, dynamic> json) {
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
