import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latihan_dropdown_search_api/models/city.dart';
import 'package:latihan_dropdown_search_api/models/province.dart';

String? idProv;
final String apiKey =
    "da59cf99d501240e81948ca3e8cd34fc5cb56d7631c81f643866967767cfea56";

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WILAYAH INDONESIA"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          DropdownSearch<Province>(
            mode: Mode.DIALOG,
            showSearchBox: true,
            onChanged: (value) => idProv = value?.id,
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem?.name ?? "Belum memilih provinsi"),
            popupItemBuilder: (context, item, isSelected) => ListTile(
              title: Text(item.name),
            ),
            onFind: (text) async {
              var response = await http.get(Uri.parse(
                  "https://api.binderbyte.com/wilayah/provinsi?api_key=$apiKey"));
              if (response.statusCode != 200) {
                return [];
              }
              List allProvince =
                  (json.decode(response.body) as Map<String, dynamic>)["value"];
              List<Province> allModelProvince = [];
              allProvince.forEach((element) {
                allModelProvince.add(
                  Province(
                    id: element["id"],
                    name: element["name"],
                  ),
                );
              });
              return allModelProvince;
            },
          ),
          SizedBox(height: 20),
          DropdownSearch<City>(
            mode: Mode.DIALOG,
            showSearchBox: true,
            onChanged: (value) => print(value?.toJson()),
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem?.name ?? "Belum memilih kota/kabupaten"),
            popupItemBuilder: (context, item, isSelected) => ListTile(
              title: Text(item.name),
            ),
            onFind: (text) async {
              var response = await http.get(Uri.parse(
                  "https://api.binderbyte.com/wilayah/kabupaten?api_key=$apiKey&id_provinsi=$idProv"));
              if (response.statusCode != 200) {
                return [];
              }
              List allCity =
                  (json.decode(response.body) as Map<String, dynamic>)["value"];
              List<City> allModelCity = [];
              allCity.forEach((element) {
                allModelCity.add(
                  City(
                    id: element['id'],
                    idProvinsi: element['id_provinsi'],
                    name: element['name'],
                  ),
                );
              });
              return allModelCity;
            },
          ),
        ],
      ),
    );
  }
}
