class AgentListHome {
  int _id;
  int _reqId;
  String _requestId;
  int _workshopId;
  int _vehicleId;
  int _partId;
  int _agentId;
  int _status;
  String _reqStatus;
  Reqtab _reqtab;
  Workshop _workshop;
  Vehicle _vehicle;
  Part _part;
  Workshop _agent;

  AgentListHome(
      {int id,
      int reqId,
      String requestId,
      int workshopId,
      int vehicleId,
      int partId,
      int agentId,
      int status,
      String reqStatus,
      Reqtab reqtab,
      Workshop workshop,
      Vehicle vehicle,
      Part part,
      Workshop agent}) {
    this._id = id;
    this._reqId = reqId;
    this._requestId = requestId;
    this._workshopId = workshopId;
    this._vehicleId = vehicleId;
    this._partId = partId;
    this._agentId = agentId;
    this._status = status;
    this._reqStatus = reqStatus;
    this._reqtab = reqtab;
    this._workshop = workshop;
    this._vehicle = vehicle;
    this._part = part;
    this._agent = agent;
  }

  int get id => _id;
  set id(int id) => _id = id;
  int get reqId => _reqId;
  set reqId(int reqId) => _reqId = reqId;
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
  int get status => _status;
  set status(int status) => _status = status;
  String get reqStatus => _reqStatus;
  set reqStatus(String reqStatus) => _reqStatus = reqStatus;
  Reqtab get reqtab => _reqtab;
  set reqtab(Reqtab reqtab) => _reqtab = reqtab;
  Workshop get workshop => _workshop;
  set workshop(Workshop workshop) => _workshop = workshop;
  Vehicle get vehicle => _vehicle;
  set vehicle(Vehicle vehicle) => _vehicle = vehicle;
  Part get part => _part;
  set part(Part part) => _part = part;
  Workshop get agent => _agent;
  set agent(Workshop agent) => _agent = agent;

  AgentListHome.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _reqId = json['req_id'];
    _requestId = json['requestId'];
    _workshopId = json['workshop_id'];
    _vehicleId = json['vehicle_id'];
    _partId = json['part_id'];
    _agentId = json['agent_id'];
    _status = json['status'];
    _reqStatus = json['reqStatus'];
    _reqtab =
        json['reqtab'] != null ? new Reqtab.fromJson(json['reqtab']) : null;
    _workshop = json['workshop'] != null
        ? new Workshop.fromJson(json['workshop'])
        : null;
    _vehicle =
        json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;
    _part = json['part'] != null ? new Part.fromJson(json['part']) : null;
    _agent =
        json['agent'] != null ? new Workshop.fromJson(json['agent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['req_id'] = this._reqId;
    data['requestId'] = this._requestId;
    data['workshop_id'] = this._workshopId;
    data['vehicle_id'] = this._vehicleId;
    data['part_id'] = this._partId;
    data['agent_id'] = this._agentId;
    data['status'] = this._status;
    data['reqStatus'] = this._reqStatus;
    if (this._reqtab != null) {
      data['reqtab'] = this._reqtab.toJson();
    }
    if (this._workshop != null) {
      data['workshop'] = this._workshop.toJson();
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
  String _requestNotes;
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
  List<Requestimages> _requestimages;

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
      String requestNotes,
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
      String updatedon,
      List<Requestimages> requestimages}) {
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
    this._requestNotes = requestNotes;
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
    this._requestimages = requestimages;
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
  String get requestNotes => _requestNotes;
  set requestNotes(String requestNotes) => _requestNotes = requestNotes;
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
  List<Requestimages> get requestimages => _requestimages;
  set requestimages(List<Requestimages> requestimages) =>
      _requestimages = requestimages;

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
    _requestNotes = json['requestNotes'] != null ? json['requestNotes'] : '';
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
    if (json['requestimages'] != null) {
      _requestimages = new List<Requestimages>();
      json['requestimages'].forEach((v) {
        _requestimages.add(new Requestimages.fromJson(v));
      });
    }
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
    data['requestNotes'] = this._requestNotes;
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
    if (this._requestimages != null) {
      data['requestimages'] =
          this._requestimages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Requestimages {
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
  int _reqId;

  Requestimages(
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
      int reqId}) {
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
    this._reqId = reqId;
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
  int get reqId => _reqId;
  set reqId(int reqId) => _reqId = reqId;

  Requestimages.fromJson(Map<String, dynamic> json) {
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
    _reqId = json['req_id'];
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
    data['req_id'] = this._reqId;
    return data;
  }
}

class Workshop {
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

  Workshop(
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

  Workshop.fromJson(Map<String, dynamic> json) {
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
