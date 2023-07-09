// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/bloc/app_states.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/core/utils/media_query_values.dart';
import 'package:university_project/widgets/my_text_field.dart';

class AddEmployeePage extends StatelessWidget {
  const AddEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit appCubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.primaryColor,
                  )),
              elevation: 0,
              title: Text(
                "إضافة حساب",
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontFamily: AppStrings.appFont,
                    fontSize: context.textScaleFactor * 20),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 5,
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: SizedBox(
                              height: context.height * 0.14,
                              child: Form(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: MyTextField(
                                  controller: appCubit.employeeNameController,
                                  labelText: 'اسم الموظف',
                                  validator: "names",
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 6, right: 6, top: 3),
                            child: SizedBox(
                              height: context.height * 0.14,
                              child: Form(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: MyTextField(
                                  controller:
                                      appCubit.employeeAddressController,
                                  labelText: 'العنوان',
                                  validator: "names",
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 6, right: 6, top: 3),
                            child: SizedBox(
                              height: context.height * 0.14,
                              child: Form(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: MyTextField(
                                  controller: appCubit.employeePhoneController,
                                  labelText: 'الهاتف',
                                  validator: 'names',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 6, right: 6, top: 6),
                            child: SizedBox(
                              height: context.height * 0.14,
                              child: Form(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: MyTextField(
                                  controller: appCubit.employeeSalaryController,
                                  labelText: 'الراتب',
                                  validator: "names",
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 6, right: 6, top: 6),
                            child: SizedBox(
                              height: context.height * 0.14,
                              child: Form(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: MyTextField(
                                  controller: appCubit.employeeTypeController,
                                  labelText: 'نوع الموظف',
                                  validator: "names",
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: BorderSide(
                                            color: AppColors.primaryColor,
                                            width: 2,
                                            strokeAlign: 5),
                                      ),
                                      backgroundColor: Colors.white,
                                      elevation: 0),
                                  child: Text(
                                    'إلغاء',
                                    style: TextStyle(
                                        fontFamily: AppStrings.appFont,
                                        fontSize:
                                            context.height <= 600 ? 10 : 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await appCubit.addNewEmployeeSql(
                                        name: appCubit
                                            .employeeNameController.text,
                                        address: appCubit
                                            .employeeAddressController.text,
                                        phone: appCubit
                                            .employeePhoneController.text,
                                        type: appCubit
                                            .employeeTypeController.text,
                                        salary: appCubit
                                            .employeeSalaryController.text);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      backgroundColor: AppColors.primaryColor,
                                      elevation: 0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Text(
                                      'إضافة',
                                      style: TextStyle(
                                          fontFamily: AppStrings.appFont,
                                          fontSize:
                                              context.height <= 600 ? 10 : 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          );
        });
  }
}
