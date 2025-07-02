class LoginResponse {
  LoginResponse({
    required this.user,
    required this.token,
  });
  late final User user;
  late final dynamic token;

  LoginResponse.fromJson(Map<dynamic, dynamic> json) {
    user = User.fromJson(json['user']);
    token = json['token'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['user'] = user.toJson();
    _data['token'] = token;
    return _data;
  }
}

class User {
  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.supplierNumber,
    required this.employeeNumber,
    required this.centerCost,
    required this.profileImageUrl,
    required this.lastLoginDate,
    required this.getLastLoginDateDisplay,
    required this.positionEmployee,
    required this.clabe,
    this.joinDate,
    required this.role,
    required this.authorities,
    required this.numberSociety,
    this.businessName,
    required this.usernameSAP,
    required this.permissions,
    required this.id,
    required this.active,
    required this.supplier,
    required this.notLocked,
    required this.rfcsupplier,
  });
  late final dynamic userId;
  late final dynamic firstName;
  late final dynamic lastName;
  late final dynamic username;
  late final dynamic supplierNumber;
  late final dynamic employeeNumber;
  late final dynamic centerCost;
  late final dynamic profileImageUrl;
  late final dynamic lastLoginDate;
  late final dynamic getLastLoginDateDisplay;
  late final dynamic positionEmployee;
  late final dynamic clabe;
  late final dynamic joinDate;
  late final dynamic role;
  late final List<dynamic> authorities;
  late final dynamic numberSociety;
  late final dynamic businessName;
  late final dynamic usernameSAP;
  late final List<Permissions> permissions;
  late final dynamic id;
  late final bool active;
  late final bool supplier;
  late final bool notLocked;
  late final dynamic rfcsupplier;

  User.fromJson(Map<dynamic, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    supplierNumber = json['supplierNumber'];
    employeeNumber = json['employeeNumber'];
    centerCost = json['centerCost'];
    profileImageUrl = json['profileImageUrl'];
    lastLoginDate = json['lastLoginDate'];
    getLastLoginDateDisplay = json['getLastLoginDateDisplay'];
    positionEmployee = json['positionEmployee'];
    clabe = json['clabe'];
    joinDate = dynamic;
    role = json['role'];
    authorities = List.castFrom<dynamic, dynamic>(json['authorities']);
    numberSociety = json['numberSociety'];
    businessName = dynamic;
    usernameSAP = json['usernameSAP'];
    permissions = List.from(json['permissions'])
        .map((e) => Permissions.fromJson(e))
        .toList();
    id = json['id'];
    active = json['active'];
    supplier = json['supplier'];
    notLocked = json['notLocked'];
    rfcsupplier = json['rfcsupplier'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['userId'] = userId;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['username'] = username;
    _data['supplierNumber'] = supplierNumber;
    _data['employeeNumber'] = employeeNumber;
    _data['centerCost'] = centerCost;
    _data['profileImageUrl'] = profileImageUrl;
    _data['lastLoginDate'] = lastLoginDate;
    _data['getLastLoginDateDisplay'] = getLastLoginDateDisplay;
    _data['positionEmployee'] = positionEmployee;
    _data['clabe'] = clabe;
    _data['joinDate'] = joinDate;
    _data['role'] = role;
    _data['authorities'] = authorities;
    _data['numberSociety'] = numberSociety;
    _data['businessName'] = businessName;
    _data['usernameSAP'] = usernameSAP;
    _data['permissions'] = permissions.map((e) => e.toJson()).toList();
    _data['id'] = id;
    _data['active'] = active;
    _data['supplier'] = supplier;
    _data['notLocked'] = notLocked;
    _data['rfcsupplier'] = rfcsupplier;
    return _data;
  }
}

class Permissions {
  Permissions({
    required this.keyPermission,
    required this.description,
    required this.idUserPermission,
  });
  late final dynamic keyPermission;
  late final dynamic description;
  late final dynamic idUserPermission;

  Permissions.fromJson(Map<dynamic, dynamic> json) {
    keyPermission = json['keyPermission'];
    description = json['description'];
    idUserPermission = json['idUserPermission'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['keyPermission'] = keyPermission;
    _data['description'] = description;
    _data['idUserPermission'] = idUserPermission;
    return _data;
  }
}