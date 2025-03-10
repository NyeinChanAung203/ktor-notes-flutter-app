import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:my_template/src/core/routers/routes.dart';

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
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
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                Gap(60),
                TextFormField(
                  decoration: InputDecoration(labelText: "Username"),
                ),
                Gap(16),
                TextFormField(
                  decoration: InputDecoration(labelText: "Email"),
                ),
                Gap(16),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                Gap(16),
                FilledButton(
                  onPressed: () {},
                  child: Text("Sign Up"),
                ),
                Gap(60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        context.goNamed(Routes.signIn.name);
                      },
                      child: Text("Sign In"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
