class FilterItem{
  int? isCancelled;
  String? barberId;

  FilterItem({this.isCancelled,this.barberId});

  FilterItem nullItem(){
    return FilterItem(isCancelled: null,barberId: null);
  }
}