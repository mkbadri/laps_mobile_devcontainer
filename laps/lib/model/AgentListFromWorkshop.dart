class AgentListFromWorkshop {
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
  Merchant _merchant;
  List<Productimages> _productimages;

  AgentListFromWorkshop(
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
      int merchantId,
      Merchant merchant,
      List<Productimages> productimages}) {
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
    this._merchant = merchant;
    this._productimages = productimages;
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
  Merchant get merchant => _merchant;
  set merchant(Merchant merchant) => _merchant = merchant;
  List<Productimages> get productimages => _productimages;
  set productimages(List<Productimages> productimages) =>
      _productimages = productimages;

  AgentListFromWorkshop.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _productNotes = json['productNotes'];
    _productQuality = json['productQuality'] != null ?json['productQuality'].toDouble() : 0;
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
    _merchant = json['merchant'] != null
        ? new Merchant.fromJson(json['merchant'])
        : null;
    if (json['productimages'] != null) {
      _productimages = new List<Productimages>();
      json['productimages'].forEach((v) {
        _productimages.add(new Productimages.fromJson(v));
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
    if (this._merchant != null) {
      data['merchant'] = this._merchant.toJson();
    }
    if (this._productimages != null) {
      data['productimages'] =
          this._productimages.map((v) => v.toJson()).toList();
    }
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
