class UserInfo {
  int _id;
  String _loginId;
  String _userName;
  String _userEmailId;
  String _userMobileNo;
  int _roleId;
  String _roleName;
  int _roleType;
  int _merchantId;
  String _merchantName;
  String _merchantAddress;
  String _merchantMobileNo;

  UserInfo(
      {int id,
      String loginId,
      String userName,
      String userEmailId,
      String userMobileNo,
      int roleId,
      String roleName,
      int roleType,
      int merchantId,
      String merchantName,
      String merchantAddress,
      String merchantMobileNo}) {
    this._id = id;
    this._loginId = loginId;
    this._userName = userName;
    this._userEmailId = userEmailId;
    this._userMobileNo = userMobileNo;
    this._roleId = roleId;
    this._roleName = roleName;
    this._roleType = roleType;
    this._merchantId = merchantId;
    this._merchantName = merchantName;
    this._merchantAddress = merchantAddress;
    this._merchantMobileNo = merchantMobileNo;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get loginId => _loginId;
  set loginId(String loginId) => _loginId = loginId;
  String get userName => _userName;
  set userName(String userName) => _userName = userName;
  String get userEmailId => _userEmailId;
  set userEmailId(String userEmailId) => _userEmailId = userEmailId;
  String get userMobileNo => _userMobileNo;
  set userMobileNo(String userMobileNo) => _userMobileNo = userMobileNo;
  int get roleId => _roleId;
  set roleId(int roleId) => _roleId = roleId;
  String get roleName => _roleName;
  set roleName(String roleName) => _roleName = roleName;
  int get roleType => _roleType;
  set roleType(int roleType) => _roleType = roleType;
  int get merchantId => _merchantId;
  set merchantId(int merchantId) => _merchantId = merchantId;
  String get merchantName => _merchantName;
  set merchantName(String merchantName) => _merchantName = merchantName;
  String get merchantAddress => _merchantAddress;
  set merchantAddress(String merchantAddress) =>
      _merchantAddress = merchantAddress;
  String get merchantMobileNo => _merchantMobileNo;
  set merchantMobileNo(String merchantMobileNo) =>
      _merchantMobileNo = merchantMobileNo;

  UserInfo.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _loginId = json['loginId'];
    _userName = json['userName'];
    _userEmailId = json['userEmailId'];
    _userMobileNo = json['userMobileNo'];
    _roleId = json['roleId'];
    _roleName = json['roleName'];
    _roleType = json['roleType'];
    _merchantId = json['merchantId'];
    _merchantName = json['merchantName'];
    _merchantAddress = json['merchantAddress'];
    _merchantMobileNo = json['merchantMobileNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['loginId'] = this._loginId;
    data['userName'] = this._userName;
    data['userEmailId'] = this._userEmailId;
    data['userMobileNo'] = this._userMobileNo;
    data['roleId'] = this._roleId;
    data['roleName'] = this._roleName;
    data['roleType'] = this._roleType;
    data['merchantId'] = this._merchantId;
    data['merchantName'] = this._merchantName;
    data['merchantAddress'] = this._merchantAddress;
    data['merchantMobileNo'] = this._merchantMobileNo;
    return data;
  }
}
