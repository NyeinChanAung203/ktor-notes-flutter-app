import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:my_template/src/core/routers/routes.dart';
import 'package:my_template/src/core/ui/ui.dart';
import 'package:my_template/src/core/utils/utils.dart';
import 'package:my_template/src/features/auth/presentation/viewmodels/sign_in_viewmodel.dart';

class SignInScreen extends HookConsumerWidget {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final emailCtrl = useTextEditingController();
    final passwordCtrl = useTextEditingController();
    final isObsecure = useState(true);

    ref.listen(signInViewmodelProvider, (_, n) {
      switch (n) {
        case SignInError():
          showErrorDialog(context, n.message);
          break;
        case SignInSuccess():
          showSuccessSnackbar(context, "Successfully log in");
          break;
        default:
          break;
      }
    });
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Symbols.stylus_note_rounded,
                    size: 60,
                    weight: 300,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Text(
                    "Ktor Notes App",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  Gap(60),
                  TextFormField(
                    controller: emailCtrl,
                    validator: Validator.emailValidate,
                    decoration: InputDecoration(
                      labelText: "Email",
                      isDense: true,
                    ),
                  ),
                  Gap(16),
                  TextFormField(
                    controller: passwordCtrl,
                    validator: Validator.passwordValidate,
                    obscureText: isObsecure.value,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      isDense: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          isObsecure.value = !isObsecure.value;
                        },
                        icon: isObsecure.value
                            ? Icon(Symbols.visibility_off)
                            : Icon(Symbols.visibility),
                      ),
                    ),
                  ),
                  Gap(16),
                  Consumer(
                    builder: (context, reff, child) {
                      return FilledAsyncButton(
                          isLoading: reff.watch(signInViewmodelProvider)
                              is SignInLoading,
                          onPressed: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (!formKey.currentState!.validate()) return;

                            await reff
                                .read(signInViewmodelProvider.notifier)
                                .signIn(
                                  email: emailCtrl.text.trim(),
                                  password: passwordCtrl.text.trim(),
                                );
                          },
                          text: "Sign In");
                    },
                  ),
                  Gap(60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not have an account?"),
                      TextButton(
                        onPressed: () {
                          context.goNamed(Routes.signUp.name);
                        },
                        child: Text("Sign Up"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
