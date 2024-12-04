import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/core/routing/app_routes.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';
import 'package:online_shopping/features/login/view.dart';
import 'package:online_shopping/features/profile/cubit/profile_cubit.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime(2100);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate; // This triggers a rebuild
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 95.0.dg,
        centerTitle: true,
        backgroundColor: CustomsColros.primaryColor,
        title: Column(
          children: [
            Text(
              'Profile',
              style: AppTextStyles.font30blackTitle,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0.dg),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileError) {
                return Center(child: Text(state.error));
              } else if (state is ProfileLoaded) {
                final user = state.user;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile information',
                      style: AppTextStyles.font25blackRegular,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: AppTextStyles.font18gray,
                        ),
                        SizedBox(
                          width: 150.w,
                        ),
                        Text(
                          '${user.firstName} ${user.lastName}',
                          style: AppTextStyles.font20blacSubTitle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'E_mail',
                          style: AppTextStyles.font18gray,
                        ),
                        SizedBox(
                          width: 40.w,
                        ),
                        Text(
                          user.email,
                          style: AppTextStyles.font20blacSubTitle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Phone Number',
                          style: AppTextStyles.font18gray,
                        ),
                        SizedBox(
                          width: 60.w,
                        ),
                        Text(
                          user.phoneNumber,
                          style: AppTextStyles.font20blacSubTitle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Date of birth',
                          style: AppTextStyles.font18gray,
                        ),
                        SizedBox(
                          width: 80.w,
                        ),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: CustomsColros.primaryColor,
                                width: 1.4,
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              _selectedDate == null
                                  ? 'Select date'
                                  : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                              style: AppTextStyles.font20blacSubTitle,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.read<ProfileCubit>().logout();
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                                settings: const RouteSettings(
                                    arguments: {'hideNavBar': true}),
                              ),
                              (route) =>
                                  false, // This removes all previous routes
                            );
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                                color: Colors.red), // Example text style
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }
              return const Center(child: Text('No data available.'));
            },
          ),
        ),
      ),
    );
  }
}
