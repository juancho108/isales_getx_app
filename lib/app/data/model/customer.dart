import 'package:flutter/material.dart';

class Customer {
  Customer(
      {this.posCustomersId,
      this.code,
      this.name,
      this.address,
      this.nif,
      this.isPurchase,
      this.isVisit,
      this.city,
      this.phone,
      this.email,
      this.countryid,
      this.salesupid,
      this.comercialConditions,
      this.daysToPay,
      this.nOpendocs,
      this.balance,
      this.creditLimit,
      this.gracePeriod,
      this.addresslocal,
      this.officialname,
      this.codpostal,
      this.restday,
      this.schedule,
      this.weekRest,
      this.openHour,
      this.closeHour,
      this.visitHour,
      this.deliveryDay,
      this.deliveryHour,
      this.resMon,
      this.resTue,
      this.resWed,
      this.resThu,
      this.resFri,
      this.resSat,
      this.resSun,
      this.creditControl,
      this.creditPassword,
      this.isNational,
      this.nextVisit,
      this.sent,
      this.androidNew,
      this.status,
      this.syncOk,
      this.supervisorNotes,
      this.vendorNotes,
      this.contact,
      this.androidUpdate,
      this.androidDelete,
      this.routeCode,
      this.routeLinePos,
      this.active,
      this.considerNew,
      this.gpsLat,
      this.gpsLon,
      this.contactName,
      this.contactPost,
      this.contactPhone,
      this.contactEmail,
      this.contactName2,
      this.contactPost2,
      this.contactPhone2,
      this.contactEmail2,
      this.contactName3,
      this.contactPost3,
      this.contactPhone3,
      this.contactEmail3,
      this.respCreditLimit,
      this.negotiatePrice,
      this.logisticOperatorId,
      this.onlyContractProducts,
      this.frequencyVisit,
      this.week1,
      this.week2,
      this.week3,
      this.week4,
      this.paymentConditions,
      this.externalDoc,
      this.onlyCashSales,
      this.apuraIva,
      this.tabTaras,
      this.country,
      this.normalizeCode,
      this.normalizeOfficialname,
      this.normalizeName,
      this.normalizeAddress,
      this.normalizeNif,
      this.normalizeCity,
      this.normalizePhone,
      this.contratacaoPublica,
      this.compromissoContratacaoPublica,
      this.layoutpage});

  String? code;
  String? name;
  String? address;
  String? nif;
  int? isPurchase;
  int? isVisit;
  int? posCustomersId;
  String? city;
  String? phone;
  String? email;
  String? countryid;
  String? comercialConditions;
  int? salesupid;
  int? daysToPay;
  int? nOpendocs;
  String? balance;
  String? creditLimit;
  int? gracePeriod;
  String? addresslocal;
  String? officialname;
  String? codpostal;
  String? restday;
  String? schedule;
  String? weekRest;
  String? openHour;
  String? closeHour;
  String? visitHour;
  String? deliveryDay;
  String? deliveryHour;
  String? resMon;
  String? resTue;
  String? resWed;
  String? resThu;
  String? resFri;
  String? resSat;
  String? resSun;
  String? creditPassword;
  String? isNational;
  String? nextVisit;
  String? sent;
  int? creditControl;
  int? androidNew;
  int? status;
  int? syncOk;
  int? androidUpdate;
  int? androidDelete;
  int? active;
  int? considerNew;
  String? supervisorNotes;
  String? contact;
  String? vendorNotes;
  String? routeCode;
  String? routeLinePos;
  String? gpsLat;
  String? gpsLon;
  String? contactName;
  String? contactPost;
  String? contactPhone;
  String? contactEmail;
  String? contactName2;
  String? contactPost2;
  String? contactPhone2;
  String? contactEmail2;
  String? contactName3;
  String? contactPost3;
  String? contactPhone3;
  String? contactEmail3;
  String? frequencyVisit;
  double? respCreditLimit;
  int? negotiatePrice;
  int? logisticOperatorId;
  int? onlyContractProducts;
  int? week1;
  int? week2;
  int? week3;
  int? week4;
  int? externalDoc;
  int? onlyCashSales;
  int? apuraIva;
  int? tabTaras;
  int? contratacaoPublica;
  String? paymentConditions;
  String? country;
  String? normalizeCode;
  String? normalizeOfficialname;
  String? normalizeName;
  String? normalizeAddress;
  String? normalizeNif;
  String? normalizeCity;
  String? normalizePhone;
  String? compromissoContratacaoPublica;
  Widget? layoutpage;

  static Customer getCustomerbyName(String name, List<Customer> customers) {
    return customers.firstWhere(
        (Customer a) => a.name!.toUpperCase() == name.toUpperCase());
  }

  int getIdCustomer(String name, List<Customer> customers) {
    Customer customer = getCustomerbyName(name, customers);
    return customer.posCustomersId!;
  }

  factory Customer.fromJson(Map<String, dynamic> json) {
    var value = json['CREDIT_LIMIT'] ?? 00;
    var vdouble = value.toDouble();
    final credit = '\$${vdouble.toStringAsFixed(2)}';

    double value2 = json['BALANCE'] ?? 00;
    var vdouble2 = value2.toDouble();
    final saldo = '\$${vdouble2.toStringAsFixed(2)}';
    return Customer(
      posCustomersId: json["POS_CUSTOMERS_ID"],
      code: json["CODE"] ?? 'vazio',
      name: json["NAME"] ?? 'vazio',
      address: json["ADDRESS"] ?? 'vazio',
      nif: json["NIF"].toString(),
      isPurchase: json["IS_PURCHASE"] ?? -1,
      isVisit: json["IS_VISIT"] ?? -1,
      city: json["CITY"] ?? 'vazio',
      phone: json["PHONE"] ?? 'vazio',
      email: json["EMAIL"] ?? 'vazio',
      countryid: json["COUNTRYID"] ?? 'vazio',
      salesupid: json["SALESUPID"] ?? -1,
      comercialConditions: json["COMERCIAL_CONDITIONS"] ?? 'vazio',
      daysToPay: json["DAYS_TO_PAY"] ?? -1,
      nOpendocs: json["N_OPENDOCS"] ?? -1,
      balance: saldo,
      creditLimit: credit,
      gracePeriod: json["GRACE_PERIOD"] ?? -1,
      addresslocal: json["ADDRESSLOCAL"] ?? 'vazio',
      officialname: json["OFFICIALNAME"] ?? 'vazio',
      codpostal: json["CODPOSTAL"] ?? 'vazio',
      restday: json["RESTDAY"] ?? 'vazio',
      schedule: json["SCHEDULE"] ?? 'vazio',
      weekRest: json["WEEK_REST"] ?? 'vazio',
      openHour: json["OPEN_HOUR"] ?? 'vazio',
      closeHour: json["CLOSE_HOUR"] ?? 'vazio',
      visitHour: json["VISIT_HOUR"] ?? 'vazio',
      deliveryDay: json["DELIVERY_DAY"] ?? 'vazio',
      deliveryHour: json["DELIVERY_HOUR"] ?? 'vazio',
      resMon: json["RES_MON"] ?? 'vazio',
      resTue: json["RES_TUE"] ?? 'vazio',
      resWed: json["RES_WED"] ?? 'vazio',
      resThu: json["RES_THU"] ?? 'vazio',
      resFri: json["RES_FRI"] ?? 'vazio',
      resSat: json["RES_SAT"] ?? 'vazio',
      resSun: json["RES_SUN"] ?? 'vazio',
      creditControl: json["CREDIT_CONTROL"] ?? -1,
      creditPassword: json["CREDIT_PASSWORD"] ?? 'vazio',
      isNational: json["IS_NATIONAL"] ?? 'vazio',
      nextVisit: json["NEXT_VISIT"] ?? 'vazio',
      sent: json["SENT"] ?? 'vazio',
      androidNew: json["ANDROID_NEW"] ?? -1,
      status: json["STATUS"] ?? -1,
      syncOk: json["SYNC_OK"] ?? -1,
      supervisorNotes: json["SUPERVISOR_NOTES"] ?? 'vazio',
      vendorNotes: json["VENDOR_NOTES"] ?? 'vazio',
      contact: json["CONTACT"] ?? 'vazio',
      androidUpdate: json["ANDROID_UPDATE"] ?? -1,
      androidDelete: json["ANDROID_DELETE"] ?? -1,
      routeCode: json["ROUTE_CODE"] ?? 'vazio',
      routeLinePos: json["ROUTE_LINE_POS"] ?? 'vazio',
      active: json["ACTIVE"] ?? -1,
      considerNew: json["CONSIDER_NEW"] ?? -1,
      gpsLat: json["GPS_LAT"] ?? 'vazio',
      gpsLon: json["GPS_LON"] ?? 'vazio',
      contactName: json["CONTACT_NAME"] ?? 'vazio',
      contactPost: json["CONTACT_POST"] ?? 'vazio',
      contactPhone: json["CONTACT_PHONE"] ?? 'vazio',
      contactEmail: json["CONTACT_EMAIL"] ?? 'vazio',
      contactName2: json["CONTACT_NAME_2"] ?? 'vazio',
      contactPost2: json["CONTACT_POST_2"] ?? 'vazio',
      contactPhone2: json["CONTACT_PHONE_2"] ?? 'vazio',
      contactEmail2: json["CONTACT_EMAIL_2"] ?? 'vazio',
      contactName3: json["CONTACT_NAME_3"] ?? 'vazio',
      contactPost3: json["CONTACT_POST_3"] ?? 'vazio',
      contactPhone3: json["CONTACT_PHONE_3"] ?? 'vazio',
      contactEmail3: json["CONTACT_EMAIL_3"] ?? 'vazio',
      respCreditLimit: json["RESP_CREDIT_LIMIT"] ?? -1.0,
      negotiatePrice: json["NEGOTIATE_PRICE"] ?? -1,
      logisticOperatorId: json["LOGISTIC_OPERATOR_ID"] ?? -1,
      onlyContractProducts: json["ONLY_CONTRACT_PRODUCTS"] ?? -1,
      frequencyVisit: json["FREQUENCY_VISIT"] ?? 'vazio',
      week1: json["WEEK1"] ?? -1,
      week2: json["WEEK2"] ?? -1,
      week3: json["WEEK3"] ?? -1,
      week4: json["WEEK4"] ?? -1,
      paymentConditions: json["PAYMENT_CONDITIONS"] ?? 'vazio',
      externalDoc: json["EXTERNAL_DOC"] ?? -1,
      onlyCashSales: json["ONLY_CASH_SALES"] ?? -1,
      apuraIva: json["APURA_IVA"] ?? -1,
      tabTaras: json["TAB_TARAS"] ?? -1,
      country: json["COUNTRY"] ?? 'vazio',
      normalizeCode: json["NORMALIZE_CODE"] ?? 'vazio',
      normalizeOfficialname: json["NORMALIZE_OFFICIALNAME"] ?? 'vazio',
      normalizeName: json["NORMALIZE_NAME"] ?? 'vazio',
      normalizeAddress: json["NORMALIZE_ADDRESS"] ?? 'vazio',
      normalizeNif: json["NORMALIZE_NIF"] ?? 'vazio',
      normalizeCity: json["NORMALIZE_CITY"] ?? 'vazio',
      normalizePhone: json["NORMALIZE_PHONE"] ?? 'vazio',
      contratacaoPublica: json["CONTRATACAO_PUBLICA"] ?? -1,
      compromissoContratacaoPublica:
          json["COMPROMISSO_CONTRATACAO_PUBLICA"] ?? 'vazio',
    );
  }

  Map<String, dynamic> toJson() => {
        "POS_CUSTOMERS_ID": posCustomersId,
        "CODE": code,
        "NAME": name,
        "ADDRESS": address,
        "NIF": nif,
        "IS_PURCHASE": isPurchase,
        "IS_VISIT": isVisit,
        "CITY": city,
        "PHONE": phone,
        "EMAIL": email,
        "COUNTRYID": countryid,
        "SALESUPID": salesupid,
        "COMERCIAL_CONDITIONS": comercialConditions,
        "DAYS_TO_PAY": daysToPay,
        "N_OPENDOCS": nOpendocs,
        "BALANCE": balance,
        "CREDIT_LIMIT": creditLimit,
        "GRACE_PERIOD": gracePeriod,
        "ADDRESSLOCAL": addresslocal,
        "OFFICIALNAME": officialname,
        "CODPOSTAL": codpostal,
        "RESTDAY": restday,
        "SCHEDULE": schedule,
        "WEEK_REST": weekRest,
        "OPEN_HOUR": openHour,
        "CLOSE_HOUR": closeHour,
        "VISIT_HOUR": visitHour,
        "DELIVERY_DAY": deliveryDay,
        "DELIVERY_HOUR": deliveryHour,
        "RES_MON": resMon,
        "RES_TUE": resTue,
        "RES_WED": resWed,
        "RES_THU": resThu,
        "RES_FRI": resFri,
        "RES_SAT": resSat,
        "RES_SUN": resSun,
        "CREDIT_CONTROL": creditControl,
        "CREDIT_PASSWORD": creditPassword,
        "IS_NATIONAL": isNational,
        "NEXT_VISIT": nextVisit,
        "SENT": sent,
        "ANDROID_NEW": androidNew,
        "STATUS": status,
        "SYNC_OK": syncOk,
        "SUPERVISOR_NOTES": supervisorNotes,
        "VENDOR_NOTES": vendorNotes,
        "CONTACT": contact,
        "ANDROID_UPDATE": androidUpdate,
        "ANDROID_DELETE": androidDelete,
        "ROUTE_CODE": routeCode,
        "ROUTE_LINE_POS": routeLinePos,
        "ACTIVE": active,
        "CONSIDER_NEW": considerNew,
        "GPS_LAT": gpsLat,
        "GPS_LON": gpsLon,
        "CONTACT_NAME": contactName,
        "CONTACT_POST": contactPost,
        "CONTACT_PHONE": contactPhone,
        "CONTACT_EMAIL": contactEmail,
        "CONTACT_NAME_2": contactName2,
        "CONTACT_POST_2": contactPost2,
        "CONTACT_PHONE_2": contactPhone2,
        "CONTACT_EMAIL_2": contactEmail2,
        "CONTACT_NAME_3": contactName3,
        "CONTACT_POST_3": contactPost3,
        "CONTACT_PHONE_3": contactPhone3,
        "CONTACT_EMAIL_3": contactEmail3,
        "RESP_CREDIT_LIMIT": respCreditLimit,
        "NEGOTIATE_PRICE": negotiatePrice,
        "LOGISTIC_OPERATOR_ID": logisticOperatorId,
        "ONLY_CONTRACT_PRODUCTS": onlyContractProducts,
        "FREQUENCY_VISIT": frequencyVisit,
        "WEEK1": week1,
        "WEEK2": week2,
        "WEEK3": week3,
        "WEEK4": week4,
        "PAYMENT_CONDITIONS": paymentConditions,
        "EXTERNAL_DOC": externalDoc,
        "ONLY_CASH_SALES": onlyCashSales,
        "APURA_IVA": apuraIva,
        "TAB_TARAS": tabTaras,
        "COUNTRY": country,
        "NORMALIZE_CODE": normalizeCode,
        "NORMALIZE_OFFICIALNAME": normalizeOfficialname,
        "NORMALIZE_NAME": normalizeName,
        "NORMALIZE_ADDRESS": normalizeAddress,
        "NORMALIZE_NIF": normalizeNif,
        "NORMALIZE_CITY": normalizeCity,
        "NORMALIZE_PHONE": normalizePhone,
        "CONTRATACAO_PUBLICA": contratacaoPublica,
        "COMPROMISSO_CONTRATACAO_PUBLICA": compromissoContratacaoPublica,
      };
}
