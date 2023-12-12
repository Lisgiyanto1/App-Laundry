import 'package:d_button/d_button.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryapp/config/app_color.dart';
import 'package:laundryapp/config/app_constants.dart';
import 'package:laundryapp/config/app_response.dart';
import 'package:laundryapp/config/failure.dart';
import 'package:laundryapp/datasources/user_datasources.dart';

import '../../config/app_assets.dart';
import '../../providers/register_provider.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final editUsername = TextEditingController();
  final editEmail = TextEditingController();
  final editPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  execute() {
    bool validInput = formKey.currentState!.validate();
    if (!validInput) return;

    setRegisterStatus(ref, 'loading');

    UserDataSources.register(
      editUsername.text,
      editEmail.text,
      editPassword.text,
    ).then((value) {
      String newStatus = '';
      value.fold((failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            newStatus = 'Server Error';
            DInfo.toastError(newStatus);
            break;
          case NotFoundFailure:
            newStatus = 'Error Not Found';
            DInfo.toastError(newStatus);
            break;
          case ForbiddenFailure:
            newStatus = 'You Don\'t Have Access To This Feature';
            DInfo.toastError(newStatus);
            break;
          case BadRequestFailure:
            newStatus = 'Bad Request';
            DInfo.toastError(newStatus);
            break;
          case InvalidInputFailure:
            newStatus = 'Invalid Input';
            AppResponse.InvaldInput(context, failure.message ?? '{}');
            break;
          case UnauthorizedFailure:
            newStatus = 'Unauthorised';
            DInfo.toastError(newStatus);
            break;
          default:
            newStatus = 'Request Error';
            DInfo.toastError(newStatus);
            newStatus = failure.message ?? '-';
            break;
        }

        setRegisterStatus(ref, newStatus);
      }, (result) {
        DInfo.toastSuccess('Register Success');
        setRegisterStatus(ref, 'success');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // agar sesuai dengan ukuran layar
        children: [
          Image.asset(
            AppAssets.bgAuth,
            fit: BoxFit.cover,
          ),
          Align(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black87,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                    children: [
                      Text(
                        AppConstants.APP_NAME,
                        style: GoogleFonts.poppins(
                          color: Colors.green[900],
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 5,
                        width: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            AspectRatio(
                              aspectRatio: 1.1,
                              child: Material(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(10.0),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            DView.spaceWidth(10),
                            Expanded(
                              child: DInput(
                                controller: editUsername,
                                fillColor: Colors.white70,
                                hint: 'Username',
                                radius: BorderRadius.circular(10.0),
                                validator: (input) => input == ''
                                    ? 'Username tidak boleh kosong'
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DView.spaceHeight(16),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            AspectRatio(
                              aspectRatio: 1.1,
                              child: Material(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(10.0),
                                child: const Icon(
                                  Icons.email,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            DView.spaceWidth(10),
                            Expanded(
                              child: DInput(
                                controller: editEmail,
                                fillColor: Colors.white70,
                                hint: 'Email',
                                radius: BorderRadius.circular(10.0),
                                validator: (input) => input == ''
                                    ? 'Email tidak boleh kosong'
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DView.spaceHeight(16),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Material(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(10.0),
                                child: const Icon(
                                  Icons.key,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            DView.spaceWidth(10),
                            Expanded(
                              child: DInputPassword(
                                controller: editPassword,
                                fillColor: Colors.white70,
                                hint: 'Password',
                                radius: BorderRadius.circular(10.0),
                                validator: (input) => input == ''
                                    ? 'Password tidak boleh kosong'
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DView.spaceHeight(16),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: DButtonFlat(
                                onClick: () {
                                  Navigator.pop(context);
                                },
                                padding: const EdgeInsets.all(0),
                                radius: 10,
                                mainColor: Colors.white70,
                                child: const Text(
                                  'LOG',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            DView.spaceWidth(10),
                            Expanded(
                              child: Consumer(
                                builder: (_, wiRef, __) {
                                  String status =
                                      wiRef.watch(registerStatusProvider);
                                  if (status == 'loading') {
                                    return DView.loadingCircle();
                                  }
                                  return ElevatedButton(
                                    onPressed: () => execute(),
                                    style: const ButtonStyle(
                                      alignment: Alignment.centerLeft,
                                    ),
                                    child: const Text('Register'),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      DView.spaceHeight(16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
