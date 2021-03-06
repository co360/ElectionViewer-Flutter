part of 'service.dart';


class CalonService {
  final fire_store.CollectionReference _calonCollection = fire_store.FirebaseFirestore
    .instance.collection('calon'); 

  Future<void> updateCalon(String id, {int totalSuara, int sahSuara, int tidaksahSuara}) async {

    final fire_store.DocumentSnapshot snapshot = await _calonCollection
      .doc(id).get();
    
    final Map<String, dynamic> data = {};

    if (totalSuara != null) {
      data['total_suara'] = totalSuara + (snapshot.data()['total_suara'] as num).toInt();
    }
    if (sahSuara != null) {
      data['suara_sah'] = sahSuara + (snapshot.data()['suara_sah'] as num).toInt();
    }
    if (tidaksahSuara != null) {
      data['suara_tidak_sah'] = tidaksahSuara  + (snapshot.data()['suara_tidak_sah'] as num).toInt();
    }
    
    await _calonCollection.doc(id).update(data);
  }

  Future<List<Calon>> getCalons({bool encrypt = true}) async {
    final fire_store.QuerySnapshot snapshot = await _calonCollection.get();
    
    final List<Calon> data = snapshot.docs.map((e) => Calon(
      e.id,
      e.data()["nama"] as String,
      (e.data()["nomor"] as num).toInt(),
      totalSuara: encrypt ? 0 : (e.data()["total_suara"] as num).toInt(),
      sahSuara: encrypt ? 0 : (e.data()["suara_sah"] as num).toInt(),
      tidaksahSuara: encrypt ? 0 : (e.data()["suara_tidak_sah"] as num).toInt(),
    )).toList();

    data.sort((calon1, calon2) => calon1.number.compareTo(calon2.number));

    return data;
  }

  Future<Calon> getCalon(String id) async {
    final fire_store.DocumentSnapshot snapshot = await _calonCollection
      .doc(id).get();
    
    return Calon(
      id,
      snapshot.data()["nama"] as String,
      (snapshot.data()["nomor"] as num).toInt(),
      totalSuara: (snapshot.data()["total_suara"] as num).toInt(),
      sahSuara: (snapshot.data()["suara_sah"] as num).toInt(),
      tidaksahSuara: (snapshot.data()["suara_tidak_sah"] as num).toInt(),
    );
  }

  Stream<int> streamSuaraCalon(String id)  {
    return _calonCollection.doc(id).snapshots()
      .map((event) => (event.data()['total_suara'] as num).toInt());
  }
}