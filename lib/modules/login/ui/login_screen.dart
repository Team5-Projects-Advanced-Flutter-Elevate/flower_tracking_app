import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseStatefulWidgetState<LoginScreen> {
  bool isRememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          appLocalizations.login,
          style: theme.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.03,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    label: Text(appLocalizations.email),
                    hintText: appLocalizations.enterEmail,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text(appLocalizations.password),
                    hintText: appLocalizations.enterPassword,
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isRememberMe,

                      onChanged: (value) {
                        setState(() {
                          isRememberMe = value ?? false;
                        });
                      },
                    ),
                    Text(
                      appLocalizations.rememberMe,
                      style: theme.textTheme.bodyMedium,
                    ),
                    const Spacer(),
                    Text(
                      appLocalizations.forgetPassword,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.25),
                FilledButton(
                  onPressed: () {},
                  child: Text(appLocalizations.continueWord),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
