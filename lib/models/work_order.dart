class WorkOrder {
  String city;
  String houseNumber;
  String id;
  String name;
  String street;

  WorkOrder({
    this.id,
    this.city,
    this.name,
    this.houseNumber,
    this.street,
  });

  factory WorkOrder.fromJson(Map<String, dynamic> json) {
    try {
      var entity = WorkOrder();
      entity.id = json['id'];
      entity.city = json['city'];
      entity.name = json['name'];
      entity.houseNumber = json['houseNumber'].toString();
      entity.street = json['street'];

      return entity;
    } catch (ex) {
      print('Workorder parse error ${ex.toString()}');
    }
  }
}
