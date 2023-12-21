import 'package:ai_rdio/Services/authSevices.dart';
import 'package:ai_rdio/components/InputBox.dart';
import 'package:ai_rdio/components/customButton.dart';
import 'package:ai_rdio/gymOwner/Otpp.dart';
import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class regis extends StatefulWidget {
  const regis({super.key});

  @override
  State<regis> createState() => _regisState();
}

class _regisState extends State<regis> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String gender = "";
  final TextEditingController age = TextEditingController();

  authAervices Authservice = authAervices();
  EmailOTP myauth = EmailOTP();

  void register() {
    Authservice.signUp(
        context: context,
        name: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
        age: age.text,
        gender: gender.toString());
  }

  void loading() {
    EasyLoading.show(status: 'Sending OTP....');
  }

  void cancel() {
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 235, 179, 252),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Positioned(
          //   bottom: MediaQuery.of(context).viewInsets.bottom,
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(top: 60)),
                // ignore: prefer_const_constructors
                Text(
                  'Amplify fitness with Fit-Sync',
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 0.8,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 7),
                Image.asset('assets/images/regis-cover.jpg'),
                SizedBox(height: 50),
                InputBox(
                  icon: Icons.person,
                  hint: 'Username',
                  controller: usernameController,
                  hide: false,
                ),
                InputBox(
                  icon: Icons.mail,
                  hint: 'Email',
                  controller: emailController,
                  hide: false,
                ),
                InputBox(
                    icon: Icons.lock,
                    hint: 'Password',
                    hide: true,
                    controller: passwordController),
                SizedBox(height: 10),

                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Radio(
                      value: 'male',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    Text(
                      "Male",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Radio(
                      value: 'female',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    Text(
                      "Female",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                                borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green, width: 1.5),
                                borderRadius: BorderRadius.circular(20)),
                            prefixIcon:
                                Icon(Icons.boy_outlined, color: Colors.black),
                            filled: true,
                            fillColor: Color.fromARGB(255, 247, 242, 242),
                            labelText: "Age"),
                        showCursor: true,
                        controller: age,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),

                customButton(
                    text: 'REGISTER',
                    onpressed: () async {
                      // print("click register");
                      // register();
                      EasyLoading.show(status: 'Sending OTP....');

                      myauth.setConfig(
                          appEmail: "contact@hdevcoder.com",
                          appName: "Fit-Sync Email Verification",
                          userEmail: emailController.text,
                          otpLength: 4,
                          otpType: OTPType.digitsOnly);

                      if (await myauth.sendOTP() == true) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("OTP has been sent"),
                          backgroundColor: Colors.green,
                        ));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Oops, OTP send failed"),
                          backgroundColor: Colors.red,
                        ));
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtpScreen(
                                    myauth: myauth,
                                    callback: register,
                                    subject: "Email Verification OTP :",
                                  )));
                    }),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
