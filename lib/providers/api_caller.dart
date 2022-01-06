import 'package:squaretest/models/squaremodel.dart';
import 'package:squaretest/providers/base_model.dart';
import 'package:squaretest/utilities/api.dart';
import 'package:squaretest/utilities/locator.dart';
import 'package:squaretest/utilities/viewstate.dart';

class HomeModel extends BaseModel {
  Api _api = locator<Api>();

  List<SquareApi>? data;

  Future getData() async {
    setState(ViewState.Busy);
    data = await _api.callApplicantApi();
    setState(ViewState.Idle);
  }
}
