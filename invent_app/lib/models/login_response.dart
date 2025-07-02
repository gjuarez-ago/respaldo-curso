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
    final data = <dynamic, dynamic>{};
    data['user'] = user.toJson();
    data['token'] = token;
    return data;
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
    final data = <dynamic, dynamic>{};
    data['userId'] = userId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['username'] = username;
    data['supplierNumber'] = supplierNumber;
    data['employeeNumber'] = employeeNumber;
    data['centerCost'] = centerCost;
    data['profileImageUrl'] = profileImageUrl;
    data['lastLoginDate'] = lastLoginDate;
    data['getLastLoginDateDisplay'] = getLastLoginDateDisplay;
    data['positionEmployee'] = positionEmployee;
    data['clabe'] = clabe;
    data['joinDate'] = joinDate;
    data['role'] = role;
    data['authorities'] = authorities;
    data['numberSociety'] = numberSociety;
    data['businessName'] = businessName;
    data['usernameSAP'] = usernameSAP;
    data['permissions'] = permissions.map((e) => e.toJson()).toList();
    data['id'] = id;
    data['active'] = active;
    data['supplier'] = supplier;
    data['notLocked'] = notLocked;
    data['rfcsupplier'] = rfcsupplier;
    return data;
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
    final data = <dynamic, dynamic>{};
    data['keyPermission'] = keyPermission;
    data['description'] = description;
    data['idUserPermission'] = idUserPermission;
    return data;
  }
}