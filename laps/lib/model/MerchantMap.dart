class MerchantMap {
  int _id;
  int _merchantId;
  int _mapRoletype;
  int _mapMerchantid;
  int _createdby;
  String _createdon;
  int _updatedby;
  String _updatedon;

  MerchantMap(
      {int id,
      int merchantId,
      int mapRoletype,
      int mapMerchantid,
      int createdby,
      String createdon,
      int updatedby,
      String updatedon}) {
    this._id = id;
    this._merchantId = merchantId;
    this._mapRoletype = mapRoletype;
    this._mapMerchantid = mapMerchantid;
    this._createdby = createdby;
    this._createdon = createdon;
    this._updatedby = updatedby;
    this._updatedon = updatedon;
  }

  int get id => _id;
  set id(int id) => _id = id;
  int get merchantId => _merchantId;
  set merchantId(int merchantId) => _merchantId = merchantId;
  int get mapRoletype => _mapRoletype;
  set mapRoletype(int mapRoletype) => _mapRoletype = mapRoletype;
  int get mapMerchantid => _mapMerchantid;
  set mapMerchantid(int mapMerchantid) => _mapMerchantid = mapMerchantid;
  int get createdby => _createdby;
  set createdby(int createdby) => _createdby = createdby;
  String get createdon => _createdon;
  set createdon(String createdon) => _createdon = createdon;
  int get updatedby => _updatedby;
  set updatedby(int updatedby) => _updatedby = updatedby;
  String get updatedon => _updatedon;
  set updatedon(String updatedon) => _updatedon = updatedon;

  MerchantMap.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _merchantId = json['merchantId'];
    _mapRoletype = json['mapRoletype'];
    _mapMerchantid = json['mapMerchantid'];
    _createdby = json['createdby'];
    _createdon = json['createdon'];
    _updatedby = json['updatedby'];
    _updatedon = json['updatedon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['merchantId'] = this._merchantId;
    data['mapRoletype'] = this._mapRoletype;
    data['mapMerchantid'] = this._mapMerchantid;
    data['createdby'] = this._createdby;
    data['createdon'] = this._createdon;
    data['updatedby'] = this._updatedby;
    data['updatedon'] = this._updatedon;
    return data;
  }
}
