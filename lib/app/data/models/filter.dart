class Filter{
  String? search;
  DateTime? from;
  DateTime? to;
  late List<int> catIds;
  late List<String> types;

  Filter({this.from, this.to, this.search, List<String>? types, List<int>? catIds}){
    this.types = types ?? [];
    this.catIds = catIds ?? [];
  }
}