abstract class BaseEntity<TId> {
  TId? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  BaseEntity({this.id, this.createdAt, this.updatedAt}) {
    createdAt = DateTime.now();
    updatedAt = DateTime.now();
  }
}
