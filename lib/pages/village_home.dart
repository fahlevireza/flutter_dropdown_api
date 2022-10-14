import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:latihan_dropdown_search_api/models/city.dart';
import 'package:latihan_dropdown_search_api/models/district.dart';
import 'package:latihan_dropdown_search_api/models/province.dart';
import 'package:http/http.dart' as http;
import 'package:latihan_dropdown_search_api/models/village.dart';

String? idProv;
String? idKab;
String? idKec;
final String apiKey =
    "da59cf99d501240e81948ca3e8cd34fc5cb56d7631c81f643866967767cfea56";

class VillageHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        titleTextStyle: TextStyle(color: Colors.black),
        title: Text("Village Home"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(30),
          height: 435,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              Container(
                color: Colors.amber,
                height: 70,
                margin: EdgeInsets.only(top: 50),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Text("Code"),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.amberAccent,
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(left: 50),
                        child: Text("Country"),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 13,
                            bottom: 13,
                            right: 30,
                          ),
                          child: DropdownSearch(
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            mode: Mode.MENU,
                            items: ["Indonesia"],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(left: 50),
                        child: Text("Province"),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 13,
                            bottom: 13,
                            right: 30,
                          ),
                          child: DropdownSearch<Province>(
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            mode: Mode.MENU,
                            // showSearchBox: true,
                            onChanged: (value) => idProv = value?.id,
                            dropdownBuilder: (context, selectedItem) =>
                                Text(selectedItem?.name ?? ""),
                            popupItemBuilder: (context, item, isSelected) =>
                                ListTile(
                              title: Text(item.name),
                            ),
                            onFind: (text) async {
                              var response = await http.get(Uri.parse(
                                  "https://api.binderbyte.com/wilayah/provinsi?api_key=$apiKey"));
                              if (response.statusCode != 200) {
                                return [];
                              }
                              List allProvince = (json.decode(response.body)
                                  as Map<String, dynamic>)["value"];
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.amber,
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(left: 50),
                        child: Text("City"),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 13,
                            bottom: 13,
                            right: 30,
                          ),
                          child: DropdownSearch<City>(
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            mode: Mode.MENU,
                            // showSearchBox: true,
                            onChanged: (value) => idKab = value?.id,
                            dropdownBuilder: (context, selectedItem) =>
                                Text(selectedItem?.name ?? ""),
                            popupItemBuilder: (context, item, isSelected) =>
                                ListTile(
                              title: Text(item.name),
                            ),
                            onFind: (text) async {
                              var response = await http.get(Uri.parse(
                                  "https://api.binderbyte.com/wilayah/kabupaten?api_key=$apiKey&id_provinsi=$idProv"));
                              if (response.statusCode != 200) {
                                return [];
                              }
                              List allCity = (json.decode(response.body)
                                  as Map<String, dynamic>)["value"];
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
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(left: 50),
                        child: Text("District"),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 13,
                            bottom: 13,
                            right: 30,
                          ),
                          child: DropdownSearch<District>(
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            mode: Mode.MENU,
                            // showSearchBox: true,
                            onChanged: (value) => idKec = value?.id,
                            dropdownBuilder: (context, selectedItem) =>
                                Text(selectedItem?.name ?? ""),
                            popupItemBuilder: (context, item, isSelected) =>
                                ListTile(
                              title: Text(item.name),
                            ),
                            onFind: (text) async {
                              var response = await http.get(Uri.parse(
                                  "https://api.binderbyte.com/wilayah/kecamatan?api_key=$apiKey&id_kabupaten=$idKab"));
                              if (response.statusCode != 200) {
                                return [];
                              }
                              List allDistrict = (json.decode(response.body)
                                  as Map<String, dynamic>)["value"];
                              List<District> allModelDistrict = [];
                              allDistrict.forEach((element) {
                                allModelDistrict.add(
                                  District(
                                    id: element["id"],
                                    idKabupaten: element["id_kabupaten"],
                                    name: element["name"],
                                  ),
                                );
                              });
                              return allModelDistrict;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.amberAccent,
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(left: 50),
                        child: Text("Village"),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.only(
                          right: 30,
                          top: 13,
                          bottom: 13,
                        ),
                        child: DropdownSearch<Village>(
                          dropdownSearchDecoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          mode: Mode.MENU,
                          // showSearchBox: true,
                          onChanged: (value) => print(value?.toJson()),
                          dropdownBuilder: (context, selectedItem) =>
                              Text(selectedItem?.name ?? ""),
                          popupItemBuilder: (context, item, isSelected) =>
                              ListTile(
                            title: Text(item.name),
                          ),
                          onFind: (text) async {
                            var response = await http.get(Uri.parse(
                                "https://api.binderbyte.com/wilayah/kelurahan?api_key=$apiKey&id_kecamatan=$idKec"));
                            if (response.statusCode != 200) {
                              return [];
                            }
                            List allVillage = (json.decode(response.body)
                                as Map<String, dynamic>)["value"];
                            List<Village> allModelVillage = [];
                            allVillage.forEach((element) {
                              allModelVillage.add(
                                Village(
                                  id: element["id"],
                                  idKecamatan: element["id_kecamatan"],
                                  name: element["name"],
                                ),
                              );
                            });
                            return allModelVillage;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: Icon(Icons.search),
                    ),
                  ),
                  SizedBox(width: 15),
                  SizedBox(
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
