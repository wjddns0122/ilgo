import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/responsive.dart';
import '../../core/theme.dart';

/// Reply detail + share (Figma node 30:1540): shown when a reply draft is
/// tapped. Copy to clipboard and open KakaoTalk / Messages to paste.
class ReplyDetailView extends StatefulWidget {
  const ReplyDetailView({super.key});

  @override
  State<ReplyDetailView> createState() => _ReplyDetailViewState();
}

const _kakaoYellow = Color(0xFFFADE3C);
const _kakaoInk = Color(0xFF3A2E00);
const _toastBg = Color(0xFF26221C);

class _ReplyDetailViewState extends State<ReplyDetailView> {
  bool _showToast = false;
  Timer? _toastTimer;

  late final String _korean;
  late final String _note;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    _korean = (args is Map && args['korean'] is String)
        ? args['korean'] as String
        : '';
    _note = (args is Map && args['note'] is String) ? args['note'] as String : '';
  }

  @override
  void dispose() {
    _toastTimer?.cancel();
    super.dispose();
  }

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: _korean));
    _toastTimer?.cancel();
    setState(() => _showToast = true);
    _toastTimer = Timer(const Duration(milliseconds: 2600), () {
      if (mounted) setState(() => _showToast = false);
    });
  }

  Future<void> _shareKakao() async {
    await _copy();
    // Best-effort: open KakaoTalk so the user can paste the copied reply.
    final uri = Uri.parse('kakaotalk://');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _shareSms() async {
    await _copy();
    final uri = Uri.parse('sms:');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kOnbMaxWidth),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(context),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: context.rs(28)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: context.rs(20)),
                              Text(
                                '한국어 답장',
                                style: GoogleFonts.notoSansKr(
                                  fontSize: context.rs(18),
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.forest,
                                ),
                              ),
                              SizedBox(height: context.rs(12)),
                              _replyCard(context),
                              if (_note.trim().isNotEmpty) ...[
                                SizedBox(height: context.rs(14)),
                                Text(
                                  _note,
                                  style: GoogleFonts.notoSansKr(
                                    fontSize: context.rs(18),
                                    height: 1.5,
                                    color: AppColors.stone,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(context.rs(28), context.rs(8),
                          context.rs(28), context.rs(24)),
                      child: _shareRow(context),
                    ),
                  ],
                ),
                _toast(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          context.rs(15), context.rs(15), context.rs(28), context.rs(8)),
      child: Row(
        children: [
          SizedBox(
            width: context.rs(22),
            height: context.rs(22),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: context.rs(22),
              icon: const Icon(Icons.arrow_back, color: AppColors.ink),
              onPressed: () => Get.back(),
            ),
          ),
          SizedBox(width: context.rs(12)),
          Icon(Icons.mail_outline, size: context.rs(26), color: AppColors.stone),
          SizedBox(width: context.rs(10)),
          Text(
            '메시지 · 답장',
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(19),
              fontWeight: FontWeight.w700,
              color: AppColors.stone,
            ),
          ),
        ],
      ),
    );
  }

  Widget _replyCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: context.rs(26), vertical: context.rs(24)),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.hairline),
      ),
      child: SelectableText(
        _korean.isEmpty ? '—' : _korean,
        style: GoogleFonts.notoSansKr(
          fontSize: context.rs(22),
          height: 1.6,
          fontWeight: FontWeight.w600,
          color: AppColors.ink,
        ),
      ),
    );
  }

  Widget _shareRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _shareButton(
            context,
            label: '카톡',
            icon: Icons.chat_bubble,
            bg: _kakaoYellow,
            fg: _kakaoInk,
            onTap: _shareKakao,
          ),
        ),
        SizedBox(width: context.rs(16)),
        Expanded(
          child: _shareButton(
            context,
            label: '문자',
            icon: Icons.mail_outline,
            bg: AppColors.card,
            fg: const Color(0xFF4A4439),
            bordered: true,
            onTap: _shareSms,
          ),
        ),
      ],
    );
  }

  Widget _shareButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color bg,
    required Color fg,
    required VoidCallback onTap,
    bool bordered = false,
  }) {
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: context.rs(72),
          alignment: Alignment.center,
          decoration: bordered
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.hairline),
                )
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: context.rs(23), color: fg),
              SizedBox(width: context.rs(8)),
              Text(
                label,
                style: GoogleFonts.notoSansKr(
                  fontSize: context.rs(19),
                  fontWeight: FontWeight.w700,
                  color: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _toast(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      left: context.rs(28),
      right: context.rs(28),
      bottom: _showToast ? context.rs(24) : -context.rs(140),
      child: AnimatedOpacity(
        opacity: _showToast ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: context.rs(22), vertical: context.rs(18)),
          decoration: BoxDecoration(
            color: _toastBg,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 18,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: context.rs(34),
                height: context.rs(34),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Color(0xFF3B7A57), shape: BoxShape.circle),
                child: Icon(Icons.check, size: context.rs(18), color: Colors.white),
              ),
              SizedBox(width: context.rs(16)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '답장을 복사했어요.',
                      style: GoogleFonts.notoSansKr(
                        fontSize: context.rs(19),
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '카톡·문자에 붙여넣으세요.',
                      style: GoogleFonts.notoSansKr(
                        fontSize: context.rs(19),
                        color: const Color(0xFFA59D8F),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
