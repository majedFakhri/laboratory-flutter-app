import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project/bloc/app_states.dart';
import 'package:university_project/core/enums/loading_enum.dart';
import 'package:university_project/pages/admin_pages/employees_page/employees_page.dart';
import 'package:university_project/pages/admin_pages/expenses_page/expenses_page.dart';
import 'package:university_project/pages/admin_pages/home_page/home_page.dart';
import 'package:university_project/pages/admin_pages/revenues_page/revenues_page.dart';
import 'package:university_project/sql/db.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());
  static AppCubit get(context) => BlocProvider.of(context);

  ///controllers///
  TextEditingController employeeNameController = TextEditingController();
  TextEditingController employeeAddressController = TextEditingController();
  TextEditingController employeePhoneController = TextEditingController();
  TextEditingController employeeSalaryController = TextEditingController();
  TextEditingController employeeTypeController = TextEditingController();

  ///variables///
  int currentIndexForNavBar = 0;
  List screensList = [
    const AdminHomePage(),
    const AdminExpensesPage(),
    const AdminRevenuesPage(),
    const AdminEmployeesPage()
  ];
  List employeesList = [];
  List expensesList = [];
  List testsList = [];
  List ordersList = [];
  List pillsList = [];
  List employeesTypes = ['موظف الاستقبال', 'طبيب', 'عامل'];

  ///Enums///
  LoadingEnum loadingEnum = LoadingEnum.loaded;

  ///db///
  SqlDb sqlDb = SqlDb();

  ///User sql operation///
  Future<List<Map>> getAllUsersql() async {
    String selectLine = "SELECT * FROM 'users'";
    List<Map<dynamic, dynamic>> response = await sqlDb.readData(selectLine);
    emit(RefreshUIAppState());
    print(response);
    return response;
  }

  Future<int> addUserSql() async {
    String insertLine =
        "INSERT INTO 'users' ('name','email','password','type') VALUES ('mm','mm@gmail.com','00000000','1')";
    int response = await sqlDb.insertData(insertLine);
    emit(RefreshUIAppState());
    return response;
  }

  Future<int> deleteUserSql({
    required int id,
  }) async {
    loadingEnum = LoadingEnum.loading;
    String deleteLine = "DELETE FROM `users` WHERE `id`='$id'";
    int response = await sqlDb.deleteData(deleteLine);
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  void changeIndexForNavBar(int index) {
    currentIndexForNavBar = index;

    emit(RefreshUIAppState());
  }

  ///employees sql operation////
  Future<List<Map>> getAllEmployees() async {
    loadingEnum = LoadingEnum.loading;
    String selectLine = "SELECT * FROM 'employee'";
    List<Map<dynamic, dynamic>> response = await sqlDb.readData(selectLine);
    employeesList = response;
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    print(response);
    return response;
  }

  Future<int> addNewEmployeeSql(
      {required String name,
      required String address,
      required String phone,
      required String type,
      required String salary}) async {
    String insertLine =
        "INSERT INTO 'employee' ('name','address','phone','type','salary') VALUES ('$name','$address','$phone','$type','$salary')";
    int response = await sqlDb.insertData(insertLine);
    emit(RefreshUIAppState());
    return response;
  }

  Future<int> editEmployeeSql({
    required int id,
    required TextEditingController controller,
    required String whatEditing,
  }) async {
    String fieldEditing = controller.text;
    String updateSql =
        "UPDATE `employee` SET `$whatEditing` ='$fieldEditing' WHERE `id`='$id' ";
    int response = await sqlDb.updateData(updateSql);

    emit(RefreshUIAppState());
    return response;
  }

  Future<int> deleteEmployeeSql({
    required int id,
  }) async {
    loadingEnum = LoadingEnum.loading;
    String deleteLine = "DELETE FROM `employee` WHERE `id`='$id'";
    int response = await sqlDb.deleteData(deleteLine);
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  ///expenses sql operation////
  Future<List<Map>> getAllExpenses() async {
    loadingEnum = LoadingEnum.loading;
    String selectLine = "SELECT * FROM 'expenses'";
    List<Map<dynamic, dynamic>> response = await sqlDb.readData(selectLine);
    expensesList = response;
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  Future<int> addNewExpensesSql(
      {required String description,
      required int value,
      required int employeeId}) async {
    String insertLine =
        "INSERT INTO 'expenses' ('description','value','employee_id') VALUES ('$description','$value','$employeeId')";
    int response = await sqlDb.insertData(insertLine);
    emit(RefreshUIAppState());
    return response;
  }

  Future<int> editExpensesSql({
    required int id,
    required TextEditingController controller,
    required String whatEditing,
  }) async {
    String fieldEditing = controller.text;
    String updateSql =
        "UPDATE `expenses` SET `$whatEditing` ='$fieldEditing' WHERE `id`='$id' ";
    int response = await sqlDb.updateData(updateSql);

    emit(RefreshUIAppState());
    return response;
  }

  Future<int> deleteExpensesSql({
    required int id,
  }) async {
    loadingEnum = LoadingEnum.loading;
    String deleteLine = "DELETE FROM `expenses` WHERE `id`='$id'";
    int response = await sqlDb.deleteData(deleteLine);
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  ///test sql operation////
  Future<List<Map>> getAllTests() async {
    loadingEnum = LoadingEnum.loading;
    String selectLine = "SELECT * FROM 'test'";
    List<Map<dynamic, dynamic>> response = await sqlDb.readData(selectLine);
    testsList = response;
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  Future<int> addNewTestSql({
    required String name,
    required int type,
    required int price,
    required int employeeId,
  }) async {
    String insertLine =
        "INSERT INTO 'test' ('name','type','price','employee_id') VALUES ('$name','$type','$price','$employeeId')";
    int response = await sqlDb.insertData(insertLine);
    emit(RefreshUIAppState());
    return response;
  }

  Future<int> editTestSql({
    required int id,
    required TextEditingController controller,
    required String whatEditing,
  }) async {
    String fieldEditing = controller.text;
    String updateSql =
        "UPDATE `test` SET `$whatEditing` ='$fieldEditing' WHERE `id`='$id' ";
    int response = await sqlDb.updateData(updateSql);

    emit(RefreshUIAppState());
    return response;
  }

  Future<int> deleteTestSql({
    required int id,
  }) async {
    loadingEnum = LoadingEnum.loading;
    String deleteLine = "DELETE FROM `test` WHERE `id`='$id'";
    int response = await sqlDb.deleteData(deleteLine);
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  ///order sql operation////
  Future<List<Map>> getAllOrders() async {
    loadingEnum = LoadingEnum.loading;
    String selectLine = "SELECT * FROM 'orders'";
    List<Map<dynamic, dynamic>> response = await sqlDb.readData(selectLine);
    ordersList = response;
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  Future<int> addNewOrderSql({
    required String patientName,
    required var date,
    required String patientPhone,
    required String state,
    required int patientAge,
    required int testId,
    required int employeeId,
  }) async {
    String insertLine =
        "INSERT INTO 'orders' ('patient_name','date','patient_phone','state','patient_age','test_id','employee_id') VALUES ('$patientName','$date','$patientPhone','$state','$patientAge','$testId','$employeeId')";
    int response = await sqlDb.insertData(insertLine);
    emit(RefreshUIAppState());
    return response;
  }

  Future<int> editOrderSql({
    required int id,
    required TextEditingController controller,
    required String whatEditing,
  }) async {
    String fieldEditing = controller.text;
    String updateSql =
        "UPDATE `orders` SET `$whatEditing` ='$fieldEditing' WHERE `id`='$id' ";
    int response = await sqlDb.updateData(updateSql);

    emit(RefreshUIAppState());
    return response;
  }

  Future<int> deleteOrderSql({
    required int id,
  }) async {
    loadingEnum = LoadingEnum.loading;
    String deleteLine = "DELETE FROM `orders` WHERE `id`='$id'";
    int response = await sqlDb.deleteData(deleteLine);
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  ///order sql operation////
  Future<List<Map>> getAllPills() async {
    loadingEnum = LoadingEnum.loading;
    String selectLine = "SELECT * FROM 'pills'";
    List<Map<dynamic, dynamic>> response = await sqlDb.readData(selectLine);
    pillsList = response;
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  Future<int> addNewPillSql({
    required int value,
    required String patientName,
    required String result,
    required var date,
    required int orderId,
    required int testId,
    required int employeeId,
  }) async {
    String insertLine =
        "INSERT INTO 'pills' ('value','patient_name','result','date','order_id','test_id','employee_id') VALUES ('$value','$patientName','$result','$date','$orderId','$testId','$employeeId')";
    int response = await sqlDb.insertData(insertLine);
    emit(RefreshUIAppState());
    return response;
  }

  Future<int> editPillSql({
    required int id,
    required TextEditingController controller,
    required String whatEditing,
  }) async {
    String fieldEditing = controller.text;
    String updateSql =
        "UPDATE `pills` SET `$whatEditing` ='$fieldEditing' WHERE `id`='$id' ";
    int response = await sqlDb.updateData(updateSql);

    emit(RefreshUIAppState());
    return response;
  }

  Future<int> deletePillSql({
    required int id,
  }) async {
    loadingEnum = LoadingEnum.loading;
    String deleteLine = "DELETE FROM `pills` WHERE `id`='$id'";
    int response = await sqlDb.deleteData(deleteLine);
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  void clearEvent({
    required List<TextEditingController> controller,
  }) {
    for (int i = 0; i < controller.length; i++) {
      controller[i].clear();
    }
  }
}
