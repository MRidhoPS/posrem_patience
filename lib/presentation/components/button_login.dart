import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posrem_profileapp/presentation/provider/login_provider.dart';
import 'package:provider/provider.dart';

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<LoginProvider, bool>(
      selector: (context, provider) => provider.isLoading,
      builder: (context, isLoading, child) {
        return ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
            minimumSize:
                WidgetStateProperty.all(const Size(double.infinity, 50)),
          ),
          onPressed: isLoading
              ? null
              : () => context.read<LoginProvider>().loginUser(context),
          child: Text(
            isLoading ? "Loading..." : "Login",
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: const Color(0xFF4B4B4B),
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
  }
}
