import 'package:filter/app/app.locator.dart';
import 'package:filter/app/app.logger.dart';
import 'package:filter/data_model/country_state.dart';
import 'package:filter/services/json_resource_service.dart';
import 'package:stacked/stacked.dart';

class NoticeSheetModel extends FutureViewModel<List<CountryState>?> {
  final _jsonResourceService = locator<JsonResourceService>();
  final _log = getLogger('NoticeSheetModel');

  List<CountryState> memoryList = [];

  Future<List<CountryState>?> _fetchStates() async {
    try {
      final states = await _jsonResourceService.loadStatesFromAsset();
      memoryList = states!; // states cannot be null
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

    if (value == null) return;

    _log.i('search value: $value');

    final List<CountryState> searchList = List.from(memoryList);

    if (value.isEmpty) {
      data = searchList;
      _log.i("List length: ${data!.length}");
    } else {
      data = searchList.where((item) => item.name!.toLowerCase().contains(value)).toList();
      _log.i("List length: ${data!.length}");
    }
    rebuildUi();
  }
}
