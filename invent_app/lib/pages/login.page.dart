
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invent_app/bloc/auth/login.bloc.dart';
import 'package:invent_app/bloc/auth/login.state.dart';
import 'package:invent_app/pages/home.page.dart';
import 'package:invent_app/utils/constants.dart';
import 'package:invent_app/utils/responsive.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static String routeName = "login_page";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginBloc? _loginBloc;

  bool showPassword = false;
  late String lastEmail;

  final lightTextColor = const Color(0xff999999);
  final textFieldColor = const Color(0xffF5F6FA);
  bool isSwitchedNot = false;

  TextEditingController userText = TextEditingController();
  TextEditingController passwordText = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userText.dispose();
    passwordText.dispose();
    super.dispose();
  }

  void initialData() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // if (preferences.getString('lastEmail') != null) {
    //   lastEmail = preferences.getString('lastEmail')!;
    //   userText.text = lastEmail;
    // }
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  void initState() {
    initialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          if (state is IsLoadingAuth) {
            // ProgressDialog.show(context);
          } else if (state is SuccessAuth) {
            // ProgressDialog.dissmiss(context);
            // snackbarSuccess(context, "Acceso correcto");
            savePref(
              1,
              state.response!.token,
              state.response!.user.firstName,
              state.response!.user.lastName,
              state.response!.user.username,
              state.response!.user.role,
              state.response!.user.profileImageUrl,
              state.response!.user.clabe.toString(),
            );

            Navigator.pushReplacementNamed(context, HomePag.routeName);
          }
          if (state is ErrorAuth) {
            // ProgressDialog.dissmiss(context);
            // snackbarError(context, state.messageError!);
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                height: responsive.height,
                color: Constants.blueGeneric,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 72,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              alignment: Alignment.center,
                              height: 60.0,
                              width: 150,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/logon.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                       
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Wrap(
                        children: [
                          const Text(
                            "Hola, ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.of(context).pushNamedAndRemoveUntil(
                              //     RegisterPage.routeName,
                              //     (Route<dynamic> route) => false);
                            },
                            child: const Text(
                              "inicia sesión: ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      getTextField(
                          hint: "Correo electronico", textController: userText),
                      const SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: passwordText,
                        keyboardType: TextInputType.text,
                        obscureText: !showPassword,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            filled: true,
                            fillColor: textFieldColor,
                            hintText: "Ingresa la contraseña",
                            hintStyle: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.white,
                              ),
                              child: Checkbox(
                                checkColor: Color.fromARGB(255, 8, 6, 0),
                                value: showPassword,
                                onChanged: (value) {
                                  setState(() {
                                    showPassword = value!;
                                  });
                                },
                                activeColor: Color.fromARGB(255, 254, 255, 255),
                              ),
                            ),
                          ),
                          const Text(
                            'Mostrar contraseña',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
  style: TextButton.styleFrom(
    backgroundColor: const Color.fromRGBO(0, 34, 91, 1), // Background color
    padding: const EdgeInsets.symmetric(vertical: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
      side: const BorderSide(color: Colors.black),
    ),
  ),
  onPressed: () {
    onSubmit(context);
  },
  child: Text(
    "Acceder",
    style: TextStyle(
      color: Colors.white,
      fontSize: responsive.dp(1.8),
    ),
  ),
),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          const SizedBox(width: 16),
                          Text(
                            "Ó",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: 
          TextButton(
  style: TextButton.styleFrom(
    backgroundColor: Colors.white, // Background color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
      side: const BorderSide(color: Colors.black),
    ),
    padding: const EdgeInsets.symmetric(vertical: 20),
  ),
  onPressed: () {
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => const ResetPasswordPage(),
    // ));
  },
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Image.asset("assets/images/lock.png"),
      const SizedBox(width: 10),
      const Text(
        "¿Olvidaste tu contraseña?",
        style: TextStyle(
          fontSize: 17,
          color: Colors.black, // Text color
        ),
      ),
    ],
  ),
)
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getTextField({String? hint, TextEditingController? textController}) {
    return TextField(
      controller: textController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent, width: 0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          filled: true,
          fillColor: textFieldColor,
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          )),
    );
  }

  void onSubmit(BuildContext context) async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.setBool("environment", isSwitchedNot);

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);
    bool validate = true;

    if (!regExp.hasMatch(userText.text.trim())) {
      // snackbarInfo(context, "Coloca un email valido");
      validate = false;
    }

    // Validamos que los campos no sean nulos
    if (passwordText.text.isEmpty || userText.text.isEmpty) {
      // snackbarInfo(context, "Es necesario llenar todos los campos login");
      validate = false;
      // snackbarError(context, "El campo nombre (s) no puede estar vacio!!");
      // snackbarSuccess(context, "El campo nombre (s) no puede estar vacio!!");
    }

    if (validate) {
      // _loginBloc?.add(EventAuth(
      //     user: userText.text.trim(), password: passwordText.text.trim()));
    }

    // Navigator.pushReplacementNamed(context, HomePage.routeName);
  }

  savePref(int value, String token, String name, String surname, String email,
      String phone, String userId, String dateExpires) async {
   
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // setState(() {
    //   preferences.setInt("value", value);
    //   preferences.setString("token", token);
    //   preferences.setString("name", name);
    //   preferences.setString("surname", surname);
    //   preferences.setString("email", email);
    //   preferences.setString("phone", phone);
    //   preferences.setString("user_id", userId);
    //   preferences.setBool("dactilar", false);
    //   preferences.setString("lastEmail", email);
    //   preferences.setBool("environment", isSwitchedNot);
    //   preferences.setString(
    //       "expiredToken", JwtDecoder.getExpirationDate(token).toString());
    //   // ignore: deprecated_member_use
    //   preferences.commit();
    // });
  }
}