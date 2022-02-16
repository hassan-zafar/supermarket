// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

class ProductsModel {
  ProductsModel({
    this.documents,
  });

  List<Document>? documents;

  factory ProductsModel.fromRawJson(String str) =>
      ProductsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        documents: List<Document>.from(
            json["documents"].map((x) => Document.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "documents": List<dynamic>.from(documents!.map((x) => x.toJson())),
      };
}

class Document {
  Document({
    this.name,
    this.fields,
    this.createTime,
    this.updateTime,
  });

  String? name;
  Fields? fields;
  DateTime? createTime;
  DateTime? updateTime;

  factory Document.fromRawJson(String str) =>
      Document.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        name: json["name"],
        fields: Fields.fromJson(json["fields"]),
        createTime: DateTime.parse(json["createTime"]),
        updateTime: DateTime.parse(json["updateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "fields": fields!.toJson(),
        "createTime": createTime!.toIso8601String(),
        "updateTime": updateTime!.toIso8601String(),
      };
}

class Fields {
  Fields({
    this.counterSelected,
    this.priceIntermarche,
    this.pricePingodoce,
    this.description,
    this.priceMini,
    this.name,
    this.imageUrl,
    this.priceAuchan,
    this.priceSpar,
    this.brand,
    this.priceContinete,
  });

  CounterSelected? counterSelected;
  Price? priceIntermarche;
  Price? pricePingodoce;
  Brand? description;
  Price? priceMini;
  Brand? name;
  Brand? imageUrl;
  Price? priceAuchan;
  Price? priceSpar;
  Brand? brand;
  Price? priceContinete;

  factory Fields.fromRawJson(String str) => Fields.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        counterSelected: CounterSelected.fromJson(json["counter_selected"]),
        priceIntermarche: Price.fromJson(json["price_intermarche"]),
        pricePingodoce: Price.fromJson(json["price_pingodoce"]),
        description: Brand.fromJson(json["Description"]),
        priceMini: Price.fromJson(json["price_mini"]),
        name: Brand.fromJson(json["Name"]),
        imageUrl: Brand.fromJson(json["imageURL"]),
        priceAuchan: Price.fromJson(json["price_auchan"]),
        priceSpar: Price.fromJson(json["price_spar"]),
        brand: Brand.fromJson(json["Brand"]),
        priceContinete: Price.fromJson(json["price_continete"]),
      );

  Map<String, dynamic> toJson() => {
        "counter_selected": counterSelected!.toJson(),
        "price_intermarche": priceIntermarche!.toJson(),
        "price_pingodoce": pricePingodoce!.toJson(),
        "Description": description!.toJson(),
        "price_mini": priceMini!.toJson(),
        "Name": name!.toJson(),
        "imageURL": imageUrl!.toJson(),
        "price_auchan": priceAuchan!.toJson(),
        "price_spar": priceSpar!.toJson(),
        "Brand": brand!.toJson(),
        "price_continete": priceContinete!.toJson(),
      };
}

class Brand {
  Brand({
    this.stringValue,
  });

  String? stringValue;

  factory Brand.fromRawJson(String str) => Brand.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        stringValue: json["stringValue"],
      );

  Map<String, dynamic> toJson() => {
        "stringValue": stringValue,
      };
}

class CounterSelected {
  CounterSelected({
    this.integerValue,
  });

  String? integerValue;

  factory CounterSelected.fromRawJson(String str) =>
      CounterSelected.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CounterSelected.fromJson(Map<String, dynamic> json) =>
      CounterSelected(
        integerValue: json["integerValue"],
      );

  Map<String, dynamic> toJson() => {
        "integerValue": integerValue,
      };
}

class Price {
  Price({
    this.doubleValue,
  });

  double? doubleValue;

  factory Price.fromRawJson(String str) => Price.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        doubleValue: json["doubleValue"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "doubleValue": doubleValue,
      };
}
