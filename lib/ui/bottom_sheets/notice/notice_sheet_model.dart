import 'package:filter/app/app.locator.dart';
import 'package:filter/data_model/country_state.dart';
import 'package:filter/services/json_resource_service.dart';
import 'package:filter/ui/utils/string_util.dart';
import 'package:stacked/stacked.dart';

class NoticeSheetModel extends FutureViewModel<List<CountryState>?> {
  final _jsonResourceService = locator<JsonResourceService>();
  List<CountryState>? searchList;
  List<CountryState>? memoryList;

  Future<List<CountryState>?> _fetchStates() async {
    try {
      final states = await _jsonResourceService.loadStatesFromAsset();
      memoryList = states;
      rebuildUi();
      return states;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<CountryState>?> futureToRun() async {
    return await _fetchStates();
  }

  void filter(String? value) {
    if (memoryList == null && memoryList!.isEmpty) {
      return;
    }

    /// Restore to showing all available states if user clears
    /// the search box
    if (StringUtil.isEmpty(value)) {
      data?.clear();
      data?.addAll(memoryList ?? []);
      rebuildUi();
      return;
    }

    // Append into search list
    searchList?.addAll(memoryList ?? []);

    /// filter in-memory available states for the search value
    var result = searchList?.where((e) {
      bool isAMatch =
          e.name?.toLowerCase().contains(value!.trim().toLowerCase()) ?? false;
      return isAMatch;
    }).toList();

    data?.clear();
    if (result != null && result.isNotEmpty) {
      data = result;
    }

    rebuildUi();
  }
}
