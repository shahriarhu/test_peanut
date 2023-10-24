import 'package:flutter/material.dart';
import 'package:test_peanut/core/enums/view_state.dart';
import 'package:test_peanut/core/view_models/sign_in_view_model.dart';
import 'package:test_peanut/ui/route_navigation.dart';
import 'package:test_peanut/ui/shared/app_colors.dart';
import 'package:test_peanut/ui/shared/ui_helpers.dart';
import 'package:test_peanut/ui/views/base_view.dart';
import 'package:test_peanut/ui/widgets/elevated_button_main_widget.dart';
import 'package:test_peanut/ui/widgets/loading_widget.dart';
import 'package:test_peanut/ui/widgets/text_field_widget.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SignInViewModel>(
      onModelReady: (model) {
        model.setSavedPassword();
      },
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: SizedBox(
              height: UIHelper.deviceHeight(context),
              child: Padding(
                padding: EdgeInsets.all(UIHelper.responsiveBigPadding(context)),
                child: Form(
                  key: model.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFieldWidget(
                        textFieldLabel: 'ID',
                        leadingIcon: Icons.person_outline,
                        formValidator: (input) => model.idValidator(input!),
                        typeKeyboard: TextInputType.number,
                        textLengthSize: 9,
                        controller: model.iDController,
                      ),
                      TextFieldWidget(
                        textFieldLabel: 'Password',
                        leadingIcon: Icons.lock_outline,
                        isLastField: true,
                        passwordField: model.isPasswordVisible ? false : true,
                        noBottomPadding: true,
                        trialWidget: Icon(
                          model.isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: kMainColor,
                        ),
                        trialIconOnTap: () {
                          model.changeIsPasswordVisible();
                        },
                        controller: model.passwordController,
                        formValidator: (input) =>
                            model.passwordValidator(input!),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: UIHelper.deviceWidth(context) >
                                    UIHelper.deviceHeight(context)
                                ? UIHelper.deviceWidth(context) * 0.2
                                : 0,
                          ),
                          Checkbox(
                            value: model.isCredentialsSaved,
                            checkColor: kScaffoldBackgroundColor,
                            activeColor: kMainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            onChanged: (value) {
                              model.toggleIsCredentialsSaved();
                            },
                          ),
                          const Flexible(
                            child: Text(
                              'Remember my credentials',
                              style: TextStyle(
                                color: kTextSecondaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      model.state == ViewState.idle
                          ? ElevatedButtonMainWidget(
                              buttonName: 'Log In',
                              onClickListener: () async {
                                if (model.formKey.currentState!.validate()) {
                                  if (await model.signIn()) {
                                    if (context.mounted) {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        RouteNavigation.home,
                                        (route) => false,
                                      );
                                    }
                                  }
                                }
                              },
                            )
                          : const LoadingWidget(size: 40.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
