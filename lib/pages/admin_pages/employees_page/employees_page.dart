// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/bloc/app_states.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/pages/admin_pages/employees_page/add_employee_page.dart';
import 'package:university_project/widgets/Admin_FAB.dart';
import 'package:university_project/widgets/app_bar_wave.dart';

class AdminEmployeesPage extends StatelessWidget {
  const AdminEmployeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            backgroundColor: Colors.white,
            extendBody: true,
            appBar: AppBar(
              title: const Text(
                'الموظفين',
                style: TextStyle(
                  fontFamily: AppStrings.appFont,
                  color: Colors.white,
                ),
              ),
              backgroundColor: AppColors.secondaryColor,
              elevation: 0,
              centerTitle: true,
            ),
            floatingActionButton: MyAdminFAB(
                text: 'إضافة موظف',
                onPress: () async {
                  final alaEmp = await appCubit.getAllEmployees();
                  print(alaEmp);
                  appCubit.clearEvent(controller: [
                    appCubit.employeeNameController,
                    appCubit.employeeAddressController,
                    appCubit.employeePhoneController,
                    appCubit.employeeSalaryController,
                    appCubit.employeeTypeController,
                  ]);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddEmployeePage()));
                }),
            body: Column(
              children: [
                const AppBarWave(),
                // Text('item ${appCubit.employeesList[0]['name']}'),
                Expanded(
                  child: ListView.builder(
                    itemCount: appCubit.employeesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                            'item ${appCubit.employeesList[index]['name']}'),
                      );
                    },
                  ),
                )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: AppColors.secondaryColor,
              selectedIconTheme: IconThemeData(color: AppColors.secondaryColor),
              unselectedItemColor: Colors.grey,
              currentIndex: appCubit.currentIndexForNavBar,
              selectedFontSize: 20.0,
              elevation: 15.0,
              onTap: (index) {
                appCubit.changeIndexForNavBar(index);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => appCubit.screensList[index],
                ));
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'الرئيسية',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.monetization_on),
                  label: 'المصاريف',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.move_to_inbox),
                  label: 'الإيرادات',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: 'الموظفين',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
