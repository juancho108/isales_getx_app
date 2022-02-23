import 'package:agenda/app/data/model/customer.dart';
import 'package:agenda/app/data/provider/db_util.dart';
import 'package:get/get.dart';

class CustomerProvider {
  final services = Get.find<DbLite>();

  Future<List<Customer>> getCustomers() async {
    return await services.getClients();
  }
}
