import 'package:filter/app/app.locator.dart';
import 'package:filter/app/app.logger.dart';
import 'package:filter/data_model/country_state.dart';
import 'package:filter/services/json_resource_service.dart';
import 'package:filter/ui/utils/string_util.dart';
import 'package:stacked/stacked.dart';

class NoticeSheetModel extends FutureViewModel<List<CountryState>?> {
  final _jsonResourceService = locator<JsonResourceService>();
  final _log = getLogger('NoticeSheetModel');

  List<CountryState>? searchList;
  List<CountryState>? memoryList;

  Future<List<CountryState>?> _fetchStates() async {
    try {
      final states = await _jsonResourceService.loadStatesFromAsset();
      memoryList = states;
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
    _log.i('search value: $value');

    if (memoryList == null && memoryList!.isEmpty) {
      _log.i('no states in memory');

      return;
    }

    // Append into search list
    searchList = memoryList;

    /// Restore to showing all available states if user clears
    /// the search box
    if (StringUtil.isEmpty(value)) {
      _log.i('search keyword is empty');
      data?.clear();
      data?.addAll(memoryList ?? []);
      rebuildUi();
      return;
    }

    _log.i('searchList Length: ${searchList?.length}');

    /// filter in-memory available states for the search value
    var result = searchList?.where((e) {
      bool isAMatch =
          e.name?.toLowerCase().contains(value!.trim().toLowerCase()) ?? false;
      _log.i('isAMatch: $isAMatch');

      return isAMatch;
    }).toList();

    if (result != null && result.isNotEmpty) {
      data?.clear();
      data = result;
    }

    rebuildUi();
  }
}
