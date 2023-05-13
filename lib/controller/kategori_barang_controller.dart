import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:publicapi/model/kategori_barang_model.dart';

class BarangController {
  final String apiUrl = "http://10.0.2.2:8000/api/";

  Future<List<KategoriBarangModel>> getKategoriBarang() async {
    var result = await http.get(Uri.parse("${apiUrl}barang/getAllKB/"));

    if (result.statusCode == 200) {
      var data = json.decode(result.body);
      List<KategoriBarangModel> kategoriBarang = [];
      for (var datas in data) {
        KategoriBarangModel kategori = KategoriBarangModel.fromMap(datas);
        kategoriBarang.add(kategori);
      }
      return kategoriBarang;
    } else {
      throw Exception('Gagal mengambil data kategori barang');
    }
  }

  Future addKategoriBarang(KategoriBarangModel kategoriBarang) async {
    var result = await http.post(Uri.parse("${apiUrl}barang/addKB/"),
        body: {"nama_kategori_barang": kategoriBarang.nama});

    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      throw Exception('Gagal menambahkan data kategori barang');
    }
  }

  Future deleteKategoriBarang(int id) async {
    var result = await http.post(Uri.parse("${apiUrl}barang/deleteKB/$id"));

    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      throw Exception('Gagal menghapus data kategori barang');
    }
  }

  Future updateKategoriBarang(int id, String nama) async {
    var result = await http.post(Uri.parse("${apiUrl}barang/updateKB/$id"),
        body: {"nama_kategori_barang": nama});

    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      throw Exception('Gagal mengubah data kategori barang');
    }
  }
}
