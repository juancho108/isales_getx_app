import 'dart:io';

import 'package:agenda/app/data/model/customer.dart';
import 'package:agenda/models/agenda.dart';
import 'package:get/get.dart';

import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class DbLite extends GetxService {
  late Database db;
  ////////////////////////////////////////////////////////////////////
  // metodo de conectar ao banco, verificando se já possui um banco //
  static Future<Database> database() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "powersales.db");

    var exists = await databaseExists(path);

    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    ByteData data = await rootBundle.load(join("assets", "powersales.db"));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Write and flush the bytes written
    if (!exists) {
      await File(path).writeAsBytes(bytes, flush: true);
      print('criando banco de dados');
      // Should happen only the first time you launch your application

    } else {}
// open the database
    final db = await openDatabase(path);

    return db;
  }
  ////////////////////////////////////////////////////////////////////

  ////////////////////////////////////////////////////////////////////
  // metodo de conectar ao banco, sempre copiando o db novamente    //
  static Future<Database> createdatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "powersales.db");

    // var exists = await sql.databaseExists(path);
    //print("Creating new copy from asset");

    // Make sure the parent directory exists
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    ByteData data = await rootBundle.load(join("assets", "powersales.db"));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Write and flush the bytes written
    // if (!exists) {
    await File(path).writeAsBytes(bytes, flush: true);
    // Should happen only the first time you launch your application

    // } else {
    // print("Created database from 0");
    // }
// open the database
    final db = await openDatabase(path);
    print("Database Created: " + db.path);
    return db;
  }
  ////////////////////////////////////////////////////////////////////

  ////////////////////////////////////////////////////////////////////
  // coletar os compromissos do dialog                              //
  // static Future<List<Map<String, dynamic>>> getData() async {
  //   final db = await DbLite.database();
  //   const myquery = """select
  //      datetime(oc.APPOINTMENT_DATE) as date,
  //      ot.NAME as type,
  //      oc.POS_OCCURRENCE_ID as id,
  //      0 as classID,
  //      oc.HOUR as hour,
  //      c.NAME as name
  //      from POS_OCCURRENCES as oc
  //      left join POS_OCC_TYPE as ot on ot.SALESUP_ID = oc.OCCURRENCE_ID and ot.SHOW_AGENDA = 1
  //      left join POS_CUSTOMERS as c on c.SALESUPID = oc.CUSTOMER_ID
  //      --where date(oc.APPOINTMENT_DATE) = "2021-11-08" and oc.SOLVED = 0
  //      where oc.SOLVED = 0
  //      union
  //      select
  //      datetime(c.NEXT_CONTACT_DATE) as date,
  //      ct.NAME as type,
  //      c.POS_CONTACT_ID as id,
  //      1 as classID,
  //      c.NEXT_CONTACT_HOUR as hour,
  //      c.OPPORTUNITY as name
  //      from POS_CONTACT as c
  //      left join POS_CONTACT_TYPE as ct on c.TYPE_CODE = ct.CODE
  //      --where date(NEXT_CONTACT_DATE) = "2021-11-08" order by hour""";
  //   return db.rawQuery(myquery);
  // }
  ////////////////////////////////////////////////////////////////////////

  ///
  ///
  /// coleta do banco de dados
  ///
  Future<DbLite> init() async {
    db = await database();
    return this;
  }

  Future<List<Customer>> getClients() async {
    const sql = """select *  from POS_CUSTOMERS""";
    final response = await db.rawQuery(sql);
    return response.map((e) => Customer.fromJson(e)).toList();
  }

  static Future<int?> getNumberClients() async {
    final db = await DbLite.database();
    const myquery = """select COUNT(POS_CUSTOMERS_ID)  from POS_CUSTOMERS""";

    return Sqflite.firstIntValue(await db.rawQuery(myquery));
  }

  static Future<int?> getNumberProducts() async {
    final db = await DbLite.database();
    const myquery = """select COUNT(POS_PRODUCTS_ID)  from POS_PRODUCTS""";

    return Sqflite.firstIntValue(await db.rawQuery(myquery));
  }

  static Future<int?> getNumberEvents() async {
    final db = await DbLite.database();
    const myquery =
        """select COUNT(POS_CALENDAR_ID)  from POS_CALENDAR WHERE SOLVED = 0  AND DATE >= DATETIME()""";

    return Sqflite.firstIntValue(await db.rawQuery(myquery));
  }

  static Future<int?> getPendentTransactions() async {
    final db = await DbLite.database();
    const myquery =
        """select COUNT(POS_TRANSACTIONS_ID)  from POS_TRANSACTIONS WHERE SYNC_OK = 0""";

    return Sqflite.firstIntValue(await db.rawQuery(myquery));
  }

  static Future<int?> getNumberOportunitys() async {
    final db = await DbLite.database();
    const myquery = """select COUNT(POS_CONTACT_ID)  from POS_CONTACT""";

    return Sqflite.firstIntValue(await db.rawQuery(myquery));
  }

  static Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await DbLite.database();
    const myquery = """SELECT POS_PRODUCTS.POS_PRODUCTS_ID,
    POS_PRODUCTS.SALESUP_ID,
    POS_PRODUCTS.CODE,
    POS_PRODUCTS.NAME,
    POS_PRODUCTS.SLOGAN,
    POS_PRODUCTS.CODSEG1,
    POS_PRODUCTS.CODSEG2,
    POS_PRODUCTS.CODSEG3,
    POS_PRODUCTS.CODSEG4,
    POS_PRODUCTS.CODSEG5,
    POS_PRODUCTS.CODSEG6,
    POS_PRODUCTS.PVP1,
    POS_PRODUCTS.PVP2,
    POS_PRODUCTS.PVP3,
    POS_PRODUCTS.PVP4,
    POS_PRODUCTS.PVP5,
    POS_PRODUCTS.PVP6,
    POS_PRODUCTS.PVP7,
    POS_PRODUCTS.PVP8,
    POS_PRODUCTS.IVA,
    POS_PRODUCTS."SIZE",
    POS_PRODUCTS.UNIT_PER_BOX,
    POS_PRODUCTS.DISC1_MAX,
    POS_PRODUCTS.DISC2_MAX,
    POS_PRODUCTS.DISC3_MAX,
    POS_PRODUCTS.SELLING_UNIT,
    POS_PRODUCTS.PRICE_MIN,
    POS_PRODUCTS.DISC1_TABLE,
    POS_PRODUCTS.DISC2_TABLE,
    POS_PRODUCTS.DISC3_TABLE,
    POS_PRODUCTS.DISC4_TABLE,
    POS_PRODUCTS.DISC5_TABLE,
    POS_PRODUCTS.DISC6_TABLE,
    POS_PRODUCTS.DISC7_TABLE,
    POS_PRODUCTS.DISC8_TABLE,
    POS_PRODUCTS.URL,
    POS_PRODUCTS.EDIT_NAME,
    POS_PRODUCTS.SYNC_OK,
    POS_PRODUCTS.MANAGES_STOCK,
    POS_PRODUCTS.SELL_NEGATIVE_STOCK,
    POS_PRODUCTS.IS_CONTAINER,
    POS_PRODUCTS.GROSS_WEIGHT,
    POS_PRODUCTS.NET_WEIGHT,
    POS_PRODUCTS.IMAGE_FILE,
    POS_PRODUCTS.HTML_DETAILS,
    POS_PRODUCTS.VARIATION,
    POS_PRODUCTS.IS_SOGENAVE,
    POS_PRODUCTS.PROVIDER_CODE,
    POS_PRODUCTS.CONV_BOXES,
    POS_PRODUCTS.BUYING_UNIT,
    POS_PRODUCTS.IABA_SELL,
    POS_PRODUCTS.MEMBERSPRICE,
    POS_PRODUCTS.IS_REDUCTION,
    POS_PRODUCTS.PVP1_IVA,
    POS_PRODUCTS.PVP2_IVA,
    POS_PRODUCTS.PVP3_IVA,
    POS_PRODUCTS.PVP4_IVA,
    POS_PRODUCTS.PVP5_IVA,
    POS_PRODUCTS.PVP6_IVA,
    POS_PRODUCTS.PVP7_IVA,
    POS_PRODUCTS.PVP8_IVA,
    POS_PRODUCTS.CONTROLA_LOTE,
    POS_PRODUCTS.RASTREABILIDADE,
    POS_PRODUCTS.DEFPROD1,
    POS_PRODUCTS.DEFPROD2,
    POS_PRODUCTS.UNIDADE_CAP,
    POS_PRODUCTS.CASAS_DECIMAIS_QTD,
    POS_PRODUCTS.PRODUZ_SO_COM_ENCOMENDA,
    POS_PRODUCTS.NAME2,
    ifnull(ps.available, 0.0) AS AVAILABLE,
    
    POS_SEGPROD1.NAME AS SEGPROD1,
    
    POS_SEGPROD2.NAME AS SEGPROD2,
    POS_SEGPROD3.NAME AS SEGPROD3,
    POS_SEGPROD4.NAME AS SEGPROD4,
    POS_SEGPROD5.NAME AS SEGPROD5,
    POS_SEGPROD6.NAME AS SEGPROD6
	FROM POS_PRODUCTS
 INNER JOIN POS_SEGPROD1 ON POS_SEGPROD1.CODE = POS_PRODUCTS.CODSEG1
 INNER JOIN POS_SEGPROD2 ON POS_SEGPROD2.CODE = POS_PRODUCTS.CODSEG2
 INNER JOIN POS_SEGPROD3 ON POS_SEGPROD3.CODE = POS_PRODUCTS.CODSEG3 
 INNER JOIN POS_SEGPROD4 ON POS_SEGPROD4.CODE = POS_PRODUCTS.CODSEG4 
 INNER JOIN POS_SEGPROD5 ON POS_SEGPROD5.CODE = POS_PRODUCTS.CODSEG5 
 INNER JOIN POS_SEGPROD6 ON POS_SEGPROD6.CODE = POS_PRODUCTS.CODSEG6
 left join POS_STOCK ps on POS_PRODUCTS.SALESUP_ID = ps.product_id;
""";
    return db.rawQuery(myquery);
  }

  static Future<List<Map<String, dynamic>>> getProductsMerchandising() async {
    final db = await DbLite.database();
    const myquery = """SELECT POS_PRODUCTS.POS_PRODUCTS_ID,
    POS_PRODUCTS.SALESUP_ID,
    POS_PRODUCTS.CODE,
    POS_PRODUCTS.NAME,
    POS_PRODUCTS.SLOGAN,
    POS_PRODUCTS.CODSEG1,
    POS_PRODUCTS.CODSEG2,
    POS_PRODUCTS.CODSEG3,
    POS_PRODUCTS.CODSEG4,
    POS_PRODUCTS.CODSEG5,
    POS_PRODUCTS.CODSEG6,
    POS_PRODUCTS.PVP1,
    POS_PRODUCTS.PVP2,
    POS_PRODUCTS.PVP3,
    POS_PRODUCTS.PVP4,
    POS_PRODUCTS.PVP5,
    POS_PRODUCTS.PVP6,
    POS_PRODUCTS.PVP7,
    POS_PRODUCTS.PVP8,
    POS_PRODUCTS.IVA,
    POS_PRODUCTS."SIZE",
    POS_PRODUCTS.UNIT_PER_BOX,
    POS_PRODUCTS.DISC1_MAX,
    POS_PRODUCTS.DISC2_MAX,
    POS_PRODUCTS.DISC3_MAX,
    POS_PRODUCTS.SELLING_UNIT,
    POS_PRODUCTS.PRICE_MIN,
    POS_PRODUCTS.DISC1_TABLE,
    POS_PRODUCTS.DISC2_TABLE,
    POS_PRODUCTS.DISC3_TABLE,
    POS_PRODUCTS.DISC4_TABLE,
    POS_PRODUCTS.DISC5_TABLE,
    POS_PRODUCTS.DISC6_TABLE,
    POS_PRODUCTS.DISC7_TABLE,
    POS_PRODUCTS.DISC8_TABLE,
    POS_PRODUCTS.URL,
    POS_PRODUCTS.EDIT_NAME,
    POS_PRODUCTS.SYNC_OK,
    POS_PRODUCTS.MANAGES_STOCK,
    POS_PRODUCTS.SELL_NEGATIVE_STOCK,
    POS_PRODUCTS.IS_CONTAINER,
    POS_PRODUCTS.GROSS_WEIGHT,
    POS_PRODUCTS.NET_WEIGHT,
    POS_PRODUCTS.IMAGE_FILE,
    POS_PRODUCTS.HTML_DETAILS,
    POS_PRODUCTS.VARIATION,
    POS_PRODUCTS.IS_SOGENAVE,
    POS_PRODUCTS.PROVIDER_CODE,
    POS_PRODUCTS.CONV_BOXES,
    POS_PRODUCTS.BUYING_UNIT,
    POS_PRODUCTS.IABA_SELL,
    POS_PRODUCTS.MEMBERSPRICE,
    POS_PRODUCTS.IS_REDUCTION,
    POS_PRODUCTS.PVP1_IVA,
    POS_PRODUCTS.PVP2_IVA,
    POS_PRODUCTS.PVP3_IVA,
    POS_PRODUCTS.PVP4_IVA,
    POS_PRODUCTS.PVP5_IVA,
    POS_PRODUCTS.PVP6_IVA,
    POS_PRODUCTS.PVP7_IVA,
    POS_PRODUCTS.PVP8_IVA,
    POS_PRODUCTS.CONTROLA_LOTE,
    POS_PRODUCTS.RASTREABILIDADE,
    POS_PRODUCTS.DEFPROD1,
    POS_PRODUCTS.DEFPROD2,
    POS_PRODUCTS.UNIDADE_CAP,
    POS_PRODUCTS.CASAS_DECIMAIS_QTD,
    POS_PRODUCTS.PRODUZ_SO_COM_ENCOMENDA,
    POS_PRODUCTS.NAME2,
    ifnull(ps.available, 0.0) AS AVAILABLE,
    
    POS_SEGPROD1.NAME AS SEGPROD1,
    
    POS_SEGPROD2.NAME AS SEGPROD2,
    POS_SEGPROD3.NAME AS SEGPROD3,
    POS_SEGPROD4.NAME AS SEGPROD4,
    POS_SEGPROD5.NAME AS SEGPROD5,
    POS_SEGPROD6.NAME AS SEGPROD6
	FROM POS_PRODUCTS
 INNER JOIN POS_SEGPROD1 ON POS_SEGPROD1.CODE = POS_PRODUCTS.CODSEG1
 INNER JOIN POS_SEGPROD2 ON POS_SEGPROD2.CODE = POS_PRODUCTS.CODSEG2
 INNER JOIN POS_SEGPROD3 ON POS_SEGPROD3.CODE = POS_PRODUCTS.CODSEG3 
 INNER JOIN POS_SEGPROD4 ON POS_SEGPROD4.CODE = POS_PRODUCTS.CODSEG4 
 INNER JOIN POS_SEGPROD5 ON POS_SEGPROD5.CODE = POS_PRODUCTS.CODSEG5 
 INNER JOIN POS_SEGPROD6 ON POS_SEGPROD6.CODE = POS_PRODUCTS.CODSEG6
 left join POS_STOCK ps on POS_PRODUCTS.SALESUP_ID = ps.product_id
 WHERE POS_PRODUCTS.POS_PRODUCTS_ID > 10 AND POS_PRODUCTS.POS_PRODUCTS_ID < 26
 ;
""";
    return db.rawQuery(myquery);
  }

  static Future<List<Map<String, dynamic>>> getOportunidade() async {
    final db = await DbLite.database();
    const myquery = """SELECT *,
     pcft.NAME as TIPO_OPORTUNIDADE,
     POS_CUSTOMERS.CODE as CODCLIENTE, 
     POS_CUSTOMERS.NAME AS NAMECLIENTE, 
     POS_CUSTOMERS.OFFICIALNAME AS NAMECLIENTEFISCAL 
     FROM POS_CONTACT pc
      LEFT JOIN POS_CUSTOMERS  ON POS_CUSTOMERS.NIF = pc.NIF 
      LEFT JOIN POS_CONTACT_FOLLOWUP_TYPE pcft ON pcft.CODE = pc.NEXT_TYPE_FOLLOWUP_ID;""";
    // print(db.rawQuery(myquery));
    return db.rawQuery(myquery);
  }

  static Future<List<Map<String, dynamic>>> getAgenda() async {
    final db = await DbLite.database();
    const myquery = """SELECT 
CALENDAR.POS_CALENDAR_ID AS ID,
CALENDAR.SALESUPID,
CLI.POS_CUSTOMERS_ID AS ID_CLIENTE,
CLI.NAME AS CLIENTE,
CLI.ADDRESS AS ENDERECO,
CLI.CITY AS CIDADE,
CALENDAR.DATE,
CALENDAR.HOUR,
CALENDAR.SOLVE_DATE,
CALENDAR.SOLVED,
PROD.NAME AS PRODUTO,
PROD.POS_PRODUCTS_ID AS ID_PRODUTO,
OPORT.OPPORTUNITY AS OPORTUNIDADE,
OCC.NOTES AS OCORRENCIAS,
OPER.POS_OPERATORS_ID AS OPERATOR_ID,
OPER.NAME AS OPERADOR,
CALENDAR.SOLVED AS STATUS,
CALENDAR.SOLVE_NOTES,
CALENDAR.NOTES,
ACT.CODE AS ID_ACAO,
ACT.NAME AS ACAO,
ACT.ACTION_COLOR
from POS_CALENDAR CALENDAR
LEFT JOIN POS_CUSTOMERS CLI ON CLI.POS_CUSTOMERS_ID = CALENDAR.CUSTOMER_ID 
LEFT JOIN POS_PRODUCTS PROD ON PROD.POS_PRODUCTS_ID = CALENDAR.PRODUCT_ID 
LEFT JOIN POS_CONTACT OPORT ON OPORT.POS_CONTACT_ID = CALENDAR.OPORTUNITY_ID
LEFT JOIN POS_OCCURRENCES OCC ON OCC.POS_OCCURRENCE_ID = CALENDAR.OCCURRENCE_ID
LEFT JOIN POS_OPERATORS OPER ON OPER.POS_OPERATORS_ID = CALENDAR.OPERATOR_ID 
LEFT JOIN POS_FORM FORM ON FORM.POS_FORM_ID = CALENDAR.FORM_ID
INNER JOIN POS_ACTIVITY_TYPES ACT ON ACT.CODE = CALENDAR.ACTION_TYPE_ID
WHERE CALENDAR.SOLVED = 0   AND CALENDAR.DATE >= DATETIME()""";
    // print(db.rawQuery(myquery));
    return db.rawQuery(myquery);
  }

  static Future<List<Map<String, dynamic>>> getCustomerAgenda(
      int idClient) async {
    final db = await DbLite.database();
    final id = idClient;
    final myquery = """SELECT 
CALENDAR.POS_CALENDAR_ID AS ID,
CALENDAR.SALESUPID,
CLI.POS_CUSTOMERS_ID AS ID_CLIENTE,
CLI.NAME AS CLIENTE,
CLI.ADDRESS AS ENDERECO,
CLI.CITY AS CIDADE,
CALENDAR.DATE,
CALENDAR.HOUR,
CALENDAR.SOLVE_DATE,
CALENDAR.SOLVED,
PROD.NAME AS PRODUTO,
PROD.POS_PRODUCTS_ID AS ID_PRODUTO,
OPORT.OPPORTUNITY AS OPORTUNIDADE,
OCC.NOTES AS OCORRENCIAS,
OPER.NAME AS OPERADOR,
CALENDAR.SOLVED AS STATUS,
CALENDAR.SOLVE_NOTES,
CALENDAR.NOTES,
ACT.POS_ACTIONTYPE_ID AS ID_ACAO,
ACT.ACTION_NAME AS ACAO,
ACT.ACTION_COLOR
from POS_CALENDAR CALENDAR
LEFT JOIN POS_CUSTOMERS CLI ON CLI.POS_CUSTOMERS_ID = CALENDAR.CUSTOMER_ID 
LEFT JOIN POS_PRODUCTS PROD ON PROD.POS_PRODUCTS_ID = CALENDAR.PRODUCT_ID 
LEFT JOIN POS_CONTACT OPORT ON OPORT.POS_CONTACT_ID = CALENDAR.OPORTUNITY_ID
LEFT JOIN POS_OCCURRENCES OCC ON OCC.POS_OCCURRENCE_ID = CALENDAR.OCCURRENCE_ID
LEFT JOIN POS_OPERATORS OPER ON OPER.POS_OPERATORS_ID = CALENDAR.OPERATOR_ID 
LEFT JOIN POS_FORM FORM ON FORM.POS_FORM_ID = CALENDAR.FORM_ID
INNER JOIN POS_ACTION_TYPE ACT ON ACT.CODE = CALENDAR.ACTION_TYPE_ID
WHERE CALENDAR.CUSTOMER_ID = $id; """;
    // print(db.rawQuery(myquery));
    return db.rawQuery(myquery);
  }

  static Future<List<Map<String, dynamic>>> getDateActionType(
      int idClient) async {
    final db = await DbLite.database();
    final id = idClient;
    final myquery = """SELECT 
CALENDAR.DATE,
CALENDAR.POS_CALENDAR_ID AS ID,
ACT.ACTION_NAME AS ACAO

from POS_CALENDAR CALENDAR
INNER JOIN POS_ACTION_TYPE ACT ON ACT.ACTION_CODE = CALENDAR.ACTION_TYPE_ID
WHERE CALENDAR.CUSTOMER_ID = $id  ORDER BY CALENDAR.DATE ASC; """;
// AND CALENDAR.SOLVED = 0
    // print(db.rawQuery(myquery));
    return db.rawQuery(myquery);
  }

  static Future<List<Map<String, dynamic>>> getDateActivitiesTypes(
      int idClient) async {
    final db = await DbLite.database();
    final id = idClient;
    final myquery = """SELECT 
CALENDAR.DATE,
CALENDAR.POS_CALENDAR_ID AS ID,
ACT.ACTION_NAME AS ACAO

from POS_CALENDAR CALENDAR
INNER JOIN POS_ACTIVITY_TYPES ACT ON ACT.CODE = CALENDAR.ACTION_TYPE_ID
WHERE CALENDAR.CUSTOMER_ID = $id  ORDER BY CALENDAR.DATE ASC; """;
// AND CALENDAR.SOLVED = 0
    // print(db.rawQuery(myquery));
    return db.rawQuery(myquery);
  }

  static Future<void> closeEvent(int id, String notes) async {
    final db = await DbLite.database();
    final sql = """UPDATE POS_CALENDAR
SET  SOLVED=1, SOLVE_NOTES='$notes'
WHERE POS_CALENDAR_ID= $id""";
    db.rawQuery(sql);
  }

  static Future<List<Map<String, dynamic>>> updateXmlForm(
      String response, Agenda agenda) async {
    final db = await DbLite.database();
    final sql = """UPDATE POS_CALENDAR
SET XML_UPDATE_SERVER='$response'
WHERE POS_CALENDAR_ID=${agenda.id};
;""";
    return db.rawQuery(sql);
  }

  ////////////////////////////////
  ///
  ///pega o layout das paginas
  static Future<List<Map<String, dynamic>>> getJsonCustomerDetail() async {
    final db = await DbLite.database();
    const myquery =
        """SELECT  JsonParserDetails FROM DINAMIC_LAYOUT_PDA where ViewName = 'CUSTOMER'""";

    return db.rawQuery(myquery);
  }

  static Future<List<Map<String, dynamic>>> getLayoutCustomersCard() async {
    final db = await DbLite.database();
    const myquery =
        """SELECT  JsonParserTable FROM DINAMIC_LAYOUT_PDA where ViewName = 'CUSTOMER'""";

    return db.rawQuery(myquery);
  }

  static Future<List<Map<String, dynamic>>>
      getLayoutCustomersCardTitle() async {
    final db = await DbLite.database();
    const myquery =
        """SELECT  JsonParserTableTitle FROM DINAMIC_LAYOUT_PDA where ViewName = 'CUSTOMER'""";
    // print(await db.rawQuery(myquery));
    return db.rawQuery(myquery);
  }

////////////////////////////////////////////////////////////////
  ///
  ///products json parser
  ///
  ///
////////////////////////////////////////////////////////////////
  static Future<List<Map<String, dynamic>>> getJsonProductDetail() async {
    final db = await DbLite.database();
    const myquery =
        """SELECT  JsonParserDetails FROM DINAMIC_LAYOUT_PDA where ViewName = 'PRODUCT'""";

    return db.rawQuery(myquery);
  }

  static Future<List<Map<String, dynamic>>> getLayoutProductsCard() async {
    final db = await DbLite.database();
    const myquery =
        """SELECT  JsonParserTable FROM DINAMIC_LAYOUT_PDA where ViewName = 'PRODUCT'""";

    return db.rawQuery(myquery);
  }

  static Future<List<Map<String, dynamic>>> getLayoutProductsCardTitle() async {
    final db = await DbLite.database();
    const myquery =
        """SELECT  JsonParserTableTitle FROM DINAMIC_LAYOUT_PDA where ViewName = 'PRODUCT'""";

    return db.rawQuery(myquery);
  }

  ////////////////////////////////////////////////////////////////
  ///
  /// Oportunidades json
  ///
  ////////////////////////////////////////////////////////////////
  ///
  static Future<List<Map<String, dynamic>>> getJsonOportunidadeDetail() async {
    final db = await DbLite.database();
    const myquery =
        """SELECT  JsonParserDetails FROM DINAMIC_LAYOUT_PDA where ViewName = 'OPORTUNITY'""";

    return db.rawQuery(myquery);
  }

  static Future<List<Map<String, dynamic>>> getLayoutOportunidadesCard() async {
    final db = await DbLite.database();
    const myquery =
        """SELECT  JsonParserTable FROM DINAMIC_LAYOUT_PDA where ViewName = 'OPORTUNITY'""";

    return db.rawQuery(myquery);
  }

  static Future<List<Map<String, dynamic>>>
      getLayoutOportunidadesCardTitle() async {
    final db = await DbLite.database();
    const myquery =
        """SELECT  JsonParserTableTitle FROM DINAMIC_LAYOUT_PDA where ViewName = 'OPORTUNITY'""";

    return db.rawQuery(myquery);
  }

////////////////////////////////////////////////////////////////

  // static Future<List<Map<String, dynamic>>> getLayoutHomePage() async {
  //   final db = await DbLite.database();
  //   const myquery =
  //       """SELECT  JsonParser FROM DINAMIC_LAYOUT_PDA where ViewName = 'HOME_PAGE'""";

  //   return db.rawQuery(myquery);
  // }

  // static Future<List<Map<String, dynamic>>> getLayoutCustomersDetails() async {
  //   final db = await DbLite.database();
  //   const myquery =
  //       """SELECT  JsonParser FROM DINAMIC_LAYOUT_PDA where ViewName = 'CUSTOMER_DETAILS'""";

  //   return db.rawQuery(myquery);
  // }

  // static Future<List<Map<String, dynamic>>> getLayoutProductsList() async {
  //   final db = await DbLite.database();
  //   const myquery =
  //       """SELECT  JsonParser FROM DINAMIC_LAYOUT_PDA where ViewName = 'PRODUCT_LIST'""";

  //   return db.rawQuery(myquery);
  // }

  static Future<List<Map<String, dynamic>>> getJsonAgendaDetail() async {
    final db = await DbLite.database();
    const myquery =
        """SELECT  JsonParserDetails FROM DINAMIC_LAYOUT_PDA where ViewName = 'CALENDAR'""";

    return db.rawQuery(myquery);
  }

  static Future<List<Map<String, dynamic>>> getLayoutAgendasCard() async {
    final db = await DbLite.database();
    const myquery =
        """SELECT  JsonParserTable FROM DINAMIC_LAYOUT_PDA where ViewName = 'CALENDAR'""";

    return db.rawQuery(myquery);
  }

  static Future<List<Map<String, dynamic>>> getLayoutAgendasCardTitle() async {
    final db = await DbLite.database();
    const myquery =
        """SELECT  JsonParserTableTitle FROM DINAMIC_LAYOUT_PDA where ViewName = 'CALENDAR'""";

    return db.rawQuery(myquery);
  }

  static Future<List<Map<String, dynamic>>> getHtmlPage() async {
    final db = await DbLite.database();
    const myquery =
        """SELECT  HtmlStoredPage FROM DINAMIC_LAYOUT_PDA where ViewName = 'CALENDAR'""";

    return db.rawQuery(myquery);
  }

  static Future<List<Map<String, dynamic>>> getActivities() async {
    final db = await DbLite.database();
    const myquery = """SELECT
CUSTOMERS.NAME,
ACTIVITIES.POS_ACTIVITIES_ID,
ACTIVITIES.NOTES,
ACTIVITIES.DATE,
CATEGORIES.NAME AS CATEGORIA,
CATEGORIES.POS_ACTIVITY_CATEGORIES_ID,
TYPES.NAME AS TIPO,
TYPES.POS_ACTIVITY_TYPES_ID ,
REASONS.NAME AS REASON,
REASONS.POS_ACTIVITY_REASONS_ID ,
RESULTS.NAME AS RESULTADO,
RESULTS.POS_ACTIVITY_RESULTS_ID 
FROM POS_ACTIVITIES ACTIVITIES
INNER JOIN POS_ACTIVITY_CATEGORIES CATEGORIES ON CATEGORIES.POS_ACTIVITY_CATEGORIES_ID = ACTIVITIES.CATID
INNER JOIN POS_ACTIVITY_TYPES TYPES ON TYPES.POS_ACTIVITY_TYPES_ID = ACTIVITIES.TYPEID 
LEFT JOIN POS_CUSTOMERS CUSTOMERS ON CUSTOMERS.POS_CUSTOMERS_ID = ACTIVITIES.CUSTOMERID 
INNER JOIN POS_ACTIVITY_REASONS REASONS ON REASONS.POS_ACTIVITY_REASONS_ID = ACTIVITIES.REASONID 
INNER JOIN POS_ACTIVITY_RESULTS RESULTS ON RESULTS.POS_ACTIVITY_RESULTS_ID = ACTIVITIES.RESULTID""";

    return db.rawQuery(myquery);
  }
}
