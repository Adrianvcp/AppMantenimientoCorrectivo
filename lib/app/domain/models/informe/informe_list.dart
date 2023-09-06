import 'dart:convert';

InformeList informeListFromJson(String str) => InformeList.fromJson(json.decode(str));

String informeListToJson(InformeList data) => json.encode(data.toJson());

class InformeList {
    InformeList({
        required this.informeListDetails,
    });
    final List<InformeListDetail> informeListDetails;

    factory InformeList.fromJson(Map<String, dynamic> json) => InformeList(
        informeListDetails: List<InformeListDetail>.from(json["data"].map((x) => InformeListDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(informeListDetails.map((x) => x.toJson())),
    };
}

class InformeListDetail {
    InformeListDetail({
      required  this.cid,
      required  this.name,
      required  this.phonenumber,
      required  this.ticket,
      required this.backupequipment,
      required  this.addresssede,
      required  this.sede,
      required this.datetime,
      required  this.clientname,
      required  this.clientphonenumber,
      required this.requirement,
      required  this.observation,
      required this.idUser,
    });

    final String cid;
    final String name;
    final String phonenumber;
    final String ticket;
    final String backupequipment;
    final String addresssede;
    final String sede;
    final String datetime;
    final String clientname;
    final String clientphonenumber;
    final Requirement requirement;
    final String observation;
    final int idUser;

    factory InformeListDetail.fromJson(Map<String, dynamic> json) => InformeListDetail(
        cid: json["CID"],
        name: json["Name"],
        phonenumber: json["PhoneNumber"],
        ticket: json["Ticket"],
        backupequipment: json["BackupEquipment"],
        addresssede: json["AddressSede"],
        sede: json["Sede"],
        datetime: json["DateTime"],
        clientname: json["ClientName"],
        clientphonenumber: json["ClientPhoneNumber"],
        requirement: Requirement.fromJson((json['Requirement'])),
        observation: json["Observation"],
        idUser: json["idUser"],
    );

    Map<String, dynamic> toJson() => {
        "CID": cid,
        "Name": name,
        "PhoneNumber": phonenumber,
        "Ticket": ticket,
        "BackupEquipment": backupequipment,
        "AddressSede": addresssede,
        "Sede": sede,
        "DateTime": datetime,
        "ClientName": clientname,
        "ClientPhoneNumber": clientphonenumber,
        "Requirement": requirement.toJson(),
        "Observation": observation,
        "idUser": idUser,

    };

  
}

class Requirement{
    Requirement({
        required this.sctr,
        required this.pruebacovid19,

    });
    RequirementDetail sctr;
    RequirementDetail pruebacovid19;

    factory Requirement.fromJson(Map<String, dynamic> json) => Requirement(
        sctr: RequirementDetail.fromJson(json['SCTR']),
        pruebacovid19: RequirementDetail.fromJson(json["PRUEBA COVID-19"]),
    );

    Map<String, dynamic> toJson() => {
        "SCTR": sctr,
        "PRUEBA COVID-19": pruebacovid19,
    };

  }


  class RequirementDetail {
  RequirementDetail({ required this.contrata, required this.supervisor});
  bool contrata;
  bool supervisor;

  factory RequirementDetail.fromJson(Map<String, dynamic> json) => RequirementDetail(
    contrata: json["CONTRATA"],
    supervisor: json["SUPERVISOR"],
  );

  Map<String, dynamic> toJson() => {
    "CONTRATA": contrata,
    "SUPERVISOR": supervisor,
  };
}