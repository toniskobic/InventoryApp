import 'package:flutter/cupertino.dart';
import 'package:inv_app/Classes/tag.dart';
import 'package:inv_app/Views/filter.dart';

class FilterState extends ChangeNotifier {
  Sort? _sort = Sort.nameAZ;
  Sort? get sort => _sort;

  List<Tag>? _selectedTagsList = [];
  List<Tag>? get selectedTagsList => _selectedTagsList;
  set selectedTagsList(List<Tag>? tags) => _selectedTagsList = tags;

  FilterState(this._sort, this._selectedTagsList);

  void addFilterTags(dynamic tag) {
    if (_selectedTagsList != null) {
      if (!_selectedTagsList!.contains(tag)) {
        _selectedTagsList?.add(tag);
      } else {
        _selectedTagsList?.remove(tag);
      }
    }
    notifyListeners();
  }

  void changeSort(Sort? sort) {
    _sort = sort;
    notifyListeners();
  }
}
