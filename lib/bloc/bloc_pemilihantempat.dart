part of 'bloc.dart';

class PemilihanTempatBloc implements Bloc {

  final BehaviorSubject<Map<String, List>> _pemilihanController = BehaviorSubject();
  Stream<Map<String, List>> get pemilihanStream => _pemilihanController.stream;

  final BehaviorSubject<bool> _loadingController = BehaviorSubject();
  Stream<bool> get isLoadingStream => _loadingController.stream;

  final KecamatanService _kecamatanService = locator.get<KecamatanService>(
    instanceName: 'Service Kecamatan');
  final KelurahanService _kelurahanService = locator.get<KelurahanService>(
    instanceName: 'Service Kelurahan');

  List<Kecamatan> _kecamatans = [];
  List<Kecamatan> get kecamatans => _kecamatans;

  List<Kelurahan> _kelurahans = [];
  List<Kelurahan> get kelurahans => _kelurahans;
  
  List<String> _tpses = [];
  List<String> get tpses => _tpses;

  final Map<String, dynamic> _selectedTempat = {};
  Map<String, dynamic> get selectedTempat => _selectedTempat;
  
  final Map<String, List> pemilihan = const {
    'kecamata': [],
    'kelurahan': [],
    'tps': []
  };

  @override
  Future<void> init() async {
    _loadingController.sink.add(true);
    await getKecamatans().whenComplete(() => _loadingController.sink.add(false));
  }

  @override
  void dispose() {
    _pemilihanController.close();
  }

  void selectTempat({int indexKec, int indexKel, int indexTPS}) {

    if (indexKec != null) {
      _selectedTempat['kecamatan'] = _kecamatans[indexKec];
      _selectedTempat.remove('kelurahan');
      _selectedTempat.remove('tps');
    }
    if (indexKel != null) {
      _selectedTempat['kelurahan'] = _kelurahans[indexKel];
      _selectedTempat.remove('tps');
    }
    if (indexTPS != null) _selectedTempat['tps'] = _tpses[indexTPS];
  }

  void updatePemilihanStream({List kec, List kel, List tps}) {
    final Map<String, List> data = {
      'kecamatan': _kecamatans,
      'kelurahan': _kelurahans,
      'tps': _tpses
    };

    if (kec != null) data['kecamatan'] = kec;
    if (kel != null) data['kelurahan'] = kel;
    if (tps != null) data['tps'] = tps;

    _pemilihanController.sink.add(data);
  }

  Future<void> getKecamatans() async {
    await _kecamatanService.getKecamatans()
    .then((list) {
      _kecamatans = list;
      updatePemilihanStream(kec: _kecamatans);
    });
  }
 
  Future<void> getKelurahans(int idKec) async {
   await _kelurahanService.getKelurahans(idKec)
    .then((list) {
      _kelurahans = list;
      updatePemilihanStream(kel: _kelurahans);
    });
  }

  void generateTPSes() {
    _tpses = List.generate(5, (index) => 'TPS 0${index+1}');
    updatePemilihanStream(tps: _tpses);  
  }

  void onSelectedTempat() {
    locator.call<Pemantau>(instanceName: 'Pemantau Active').copyWith(tempat: {
      'kecamatan': _selectedTempat['kecamatan'].toString(),
      'kelurahan': _selectedTempat['kelurahan'].toString(),
      'tps': _selectedTempat['tps'] as String,
    });
  }
}