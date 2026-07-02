import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../data/models/tobagi.dart';
import '../../widgets/tobagi_image.dart';

/// Shared UI for the login & signup screens. Both use the same design system
/// (paper background, forest primary button, 또바기 greeting), so the field,
/// label, button, greeting, and cross-link builders live here to keep each
/// view lean and consistent.

/// Field label (e.g. "이메일", "비밀번호").
Widget authLabel(BuildContext context, String text) {
  return Text(
    text,
    style: GoogleFonts.notoSansKr(
      fontSize: context.rs(18),
      fontWeight: FontWeight.w700,
      color: AppColors.stone,
    ),
  );
}

/// Rounded card-style text field matching the login design.
Widget authField(
  BuildContext context, {
  required TextEditingController controller,
  required String hint,
  bool obscure = false,
  Widget? suffix,
  TextInputType? keyboardType,
  ValueChanged<String>? onChanged,
}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.hairline),
    ),
    padding: EdgeInsets.only(left: context.rs(20), right: context.rs(8)),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            obscureText: obscure,
            keyboardType: keyboardType,
            onChanged: onChanged,
            style: GoogleFonts.notoSansKr(
                fontSize: context.rs(19), color: AppColors.ink),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: hint,
              hintStyle: GoogleFonts.notoSansKr(
                  fontSize: context.rs(19), color: AppColors.stone),
              contentPadding: EdgeInsets.symmetric(vertical: context.rs(20)),
            ),
          ),
        ),
        ?suffix,
      ],
    ),
  );
}

/// Visibility toggle for a password field.
Widget authObscureToggle(
  BuildContext context, {
  required bool obscure,
  required VoidCallback onToggle,
}) {
  return IconButton(
    iconSize: context.rs(24),
    icon: Icon(
      obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
      color: AppColors.stone,
    ),
    onPressed: onToggle,
  );
}

/// Full-width forest primary button with a busy spinner.
Widget authPrimaryButton(
  BuildContext context, {
  required String label,
  required bool enabled,
  required bool busy,
  required VoidCallback onTap,
}) {
  final active = enabled && !busy;
  return SizedBox(
    width: double.infinity,
    child: Material(
      color:
          active ? AppColors.forest : AppColors.forest.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: active ? onTap : null,
        child: Container(
          height: context.rs(64),
          alignment: Alignment.center,
          child: busy
              ? SizedBox(
                  width: context.rs(24),
                  height: context.rs(24),
                  child: const CircularProgressIndicator(
                      strokeWidth: 2.5, color: Colors.white),
                )
              : Text(
                  label,
                  style: GoogleFonts.notoSansKr(
                    fontSize: context.rs(20),
                    fontWeight: FontWeight.w700,
                    color: AppColors.paper,
                  ),
                ),
        ),
      ),
    ),
  );
}

/// 또바기 greeting row shown above the auth form.
Widget authTobagiGreeting(BuildContext context, String message) {
  return Row(
    children: [
      const TobagiImage(tobagiJejuAsset, size: 64),
      SizedBox(width: context.rs(12)),
      Expanded(
        child: Text(
          message,
          style: GoogleFonts.notoSansKr(
            fontSize: context.rs(15),
            height: 1.5,
            fontWeight: FontWeight.w600,
            color: AppColors.forest,
          ),
        ),
      ),
    ],
  );
}

/// Centered "leading  action" cross-link (login ↔ signup).
Widget authSwitchLink(
  BuildContext context, {
  required String leading,
  required String action,
  required VoidCallback onTap,
}) {
  return Center(
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.rs(8), vertical: context.rs(12)),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '$leading  ',
                style: GoogleFonts.notoSansKr(
                    fontSize: context.rs(16), color: AppColors.stone),
              ),
              TextSpan(
                text: action,
                style: GoogleFonts.notoSansKr(
                  fontSize: context.rs(16),
                  fontWeight: FontWeight.w700,
                  color: AppColors.forest,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

/// Back-arrow button used in the top-left of the auth screens. Returns an
/// empty spacer when the route can't be popped.
Widget authBackButton(BuildContext context, {required bool canPop}) {
  return SizedBox(
    width: context.rs(34),
    height: context.rs(34),
    child: canPop
        ? IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            iconSize: context.rs(28),
            icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.ink),
            onPressed: () => Navigator.of(context).maybePop(),
          )
        : null,
  );
}
