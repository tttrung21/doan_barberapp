class DropdownItem {
  int? id;
  String? name;
  String? code;
  int? price;

  DropdownItem({
    this.id,
    this.name,
    this.code,
    this.price,
  });

  DropdownItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    price = json['price'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['price'] = price;
    return data;
  }

  @override
  bool operator ==(Object other) {
    return other is DropdownItem && other.id == id;
  }

  static List<DropdownItem> fromJsonToList(List<dynamic> list) {
    // ignore: unnecessary_lambdas
    return list.map((c) => DropdownItem.fromJson(c)).toList();
  }
}
