// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

List<Store> storeFromJson(String str) =>
    List<Store>.from(json.decode(str).map((x) => Store.fromJson(x)));

String storeToJson(List<Store> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Store {
  Store({
    required this.store_id,
    required this.store_code,
    required this.store_name,
    required this.address,
    required this.dc_id,
    required this.dc_name,
    required this.account_id,
    required this.account_name,
    required this.subchannel_id,
    required this.subchannel_name,
    required this.channel_id,
    required this.channel_name,
    required this.area_id,
    required this.area_name,
    required this.region_id,
    required this.region_name,
    required this.latitude,
    required this.longitude,
  });

  String store_id;
  String store_code;
  String store_name;
  String address;
  String dc_id;
  String dc_name;
  String account_id;
  String account_name;
  String subchannel_id;
  String subchannel_name;
  String channel_id;
  String channel_name;
  String area_id;
  String area_name;
  String region_id;
  String region_name;
  String latitude;
  String longitude;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        store_id: json["store_id"],
        store_code: json["store_code"],
        store_name: json["store_name"],
        address: json["address"],
        dc_id: json["dc_id"],
        dc_name: json["dc_name"],
        account_id: json["account_id"],
        account_name: json["account_name"],
        subchannel_id: json["subchannel_id"],
        subchannel_name: json["subchannel_name"],
        channel_id: json["channel_id"],
        channel_name: json["channel_name"],
        area_id: json["area_id"],
        area_name: json["area_name"],
        region_id: json["region_id"],
        region_name: json["region_name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "store_id": store_id,
        "store_code": store_code,
        "store_name": store_name,
        "address": address,
        "dc_id": dc_id,
        "dc_name": dc_name,
        "account_id": account_id,
        "account_name": account_name,
        "subchannel_id": subchannel_id,
        "subchannel_name": subchannel_name,
        "channel_id": channel_id,
        "channel_name": channel_name,
        "area_id": area_id,
        "area_name": area_name,
        "region_id": region_id,
        "region_name": region_name,
        "latitude": latitude,
        "longitude": longitude,
      };
}
