import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FireIndexBloc {
  final _fireIndexStreamController = StreamController<double>();

  get fireIndexStream => _fireIndexStreamController.stream;

  void requestFireIndex(double lat, double lon) async {
    final fireIndex = await _fetchFireIndex(lat, lon);
    _fireIndexStreamController.sink.add(fireIndex);
  }

  Future<double> _fetchFireIndex(double lat, double lon) async {
    final url =
        "https://api.climacell.co/v3/insights/fire-index?lat=$lat&lon=$lon";

    final header = {
      "apikey": "b2WSGCFcr4qIHisz3CDvrSBQDqtW7tkQ",
      "Content-Type": "application/json"
    };

    final request = await http.get(url, headers: header);

    if (request.statusCode == 200) {
      final jsonStr = request.body;
      final parsed = json.decode(jsonStr);
      return parsed[0]['fire_index'];
    } else {
      throw Exception('status code ${request.statusCode}');
    }
  }
}


