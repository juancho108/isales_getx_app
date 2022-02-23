import 'package:agenda/app/data/provider/customer_provider.dart';

class CustomerRepository {
  final CustomerProvider api;

  CustomerRepository(this.api);

  getAllCustomers() {
    print('Clientes Carregados 😀^_^');
    return api.getCustomers();
  }
}
