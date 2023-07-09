import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/bloc/app_states.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await appCubit.addNewEmployeeSql(
                          name: 'majed',
                          address: 'hama',
                          phone: '0968438264',
                          salary: '2200',
                          type: '0');
                    },
                    child: const Text('add emp ')),
                ElevatedButton(
                    onPressed: () async {
                      final alaEmp = await appCubit.getAllEmployees();
                      print(alaEmp);
                    },
                    child: const Text('all emp')),
              ],
            ),
          ),
        );
      },
    );
  }
}
