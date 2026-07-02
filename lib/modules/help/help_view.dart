import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../data/api/ilgo_api.dart';
import '../../data/services/profile_service.dart';

/// A support contact shown on the "도움받을 곳" screen.
class _Contact {
  const _Contact(this.title, this.org, this.number, {this.emergency = false});
  final String title;
  final String org;
  final String number;
  final bool emergency;
}

/// Offline / first-paint fallback until the API responds.
const _fallback = <_Contact>[
  _Contact('외국인 노동자 상담', '고용노동부', '1350'),
  _Contact('외국인종합안내센터', '법무부', '1345'),
  _Contact('건강보험 문의', '국민건강보험공단', '1577-1000'),
  _Contact('긴급 · 범죄 신고', '경찰', '112', emergency: true),
];

/// "도움받을 곳" screen (Figma node 30:1651). Contacts come from
/// GET /help-contacts (tailored by language); falls back offline.
class HelpView extends StatefulWidget {
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  List<_Contact> _contacts = _fallback;

  // Context from the risk-detail screen: lets the backend recommend the right
  // hotline first (e.g. 사기·스미싱 → 118, 임금·부당공제 → 1350).
  String? _riskType;
  String? _docType;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map) {
      _riskType = args['risk_type'] as String?;
      _docType = args['doc_type'] as String?;
    }
    _load();
  }

  Future<void> _load() async {
    if (!Get.isRegistered<IlgoApi>()) return; // offline → keep fallback
    final lang = Get.isRegistered<ProfileService>()
        ? Get.find<ProfileService>().lang.value
        : null;
    try {
      final res =
          await Get.find<IlgoApi>().helpContacts(lang, _docType, _riskType, null);
      if (!mounted || res.items.isEmpty) return;
      setState(() {
        _contacts = [
          for (final c in res.items)
            _Contact(
              c.title,
              c.org ?? '',
              c.phone ?? '',
              emergency: c.emergency,
            ),
        ];
      });
    } catch (_) {
      // keep fallback list
    }
  }

  /// Dial the number directly (opens the phone app with it pre-filled).
  Future<void> _dial(String raw) async {
    final digits = raw.replaceAll(RegExp(r'[^0-9+]'), '');
    if (digits.isEmpty) return;
    await launchUrl(
      Uri(scheme: 'tel', path: digits),
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kOnbMaxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(context),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.rs(28)),
                      child: Column(
                        children: [
                          SizedBox(height: context.rs(20)),
                          for (var i = 0; i < _contacts.length; i++) ...[
                            i == 0
                                ? _primaryCard(context, _contacts[i])
                                : _card(context, _contacts[i]),
                            SizedBox(height: context.rs(16)),
                          ],
                          SizedBox(height: context.rs(8)),
                          Text(
                            '누르면 바로 전화가 연결돼요.',
                            style: GoogleFonts.notoSansKr(
                              fontSize: context.rs(17),
                              color: AppColors.stone,
                            ),
                          ),
                          SizedBox(height: context.rs(24)),
                        ],
                      ),
                    ),
                  ),
                ),
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
          context.rs(15), context.rs(15), context.rs(28), context.rs(4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
              Icon(Icons.support_agent,
                  size: context.rs(30), color: AppColors.forest),
              SizedBox(width: context.rs(10)),
              Text(
                '도움받을 곳',
                style: GoogleFonts.notoSansKr(
                  fontSize: context.rs(27),
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
            ],
          ),
          SizedBox(height: context.rs(10)),
          Padding(
            padding: EdgeInsets.only(left: context.rs(13)),
            child: Text(
              '무료로 상담할 수 있어요. 통역도 도와줘요.',
              style: GoogleFonts.notoSansKr(
                  fontSize: context.rs(18), color: AppColors.stone),
            ),
          ),
        ],
      ),
    );
  }

  /// The first contact is the recommended CTA — a filled, prominent card.
  Widget _primaryCard(BuildContext context, _Contact c) {
    final bg = c.emergency ? const Color(0xFFB04A3A) : AppColors.forest;
    final subtitle = [c.org, c.number].where((s) => s.isNotEmpty).join(' · ');
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _dial(c.number),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              horizontal: context.rs(24), vertical: context.rs(22)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.recommend,
                      color: Colors.white, size: context.rs(20)),
                  SizedBox(width: context.rs(6)),
                  Text(
                    '여기로 먼저 전화하세요',
                    style: GoogleFonts.notoSansKr(
                      fontSize: context.rs(15),
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.rs(12)),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.title,
                          style: GoogleFonts.notoSansKr(
                            fontSize: context.rs(24),
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: context.rs(3)),
                        Text(
                          subtitle,
                          style: GoogleFonts.notoSansKr(
                            fontSize: context.rs(18),
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: context.rs(12)),
                  Container(
                    width: context.rs(64),
                    height: context.rs(64),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Icon(Icons.call, color: bg, size: context.rs(30)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(BuildContext context, _Contact c) {
    final callColor = c.emergency ? const Color(0xFFB04A3A) : AppColors.forest;
    final subtitle = [c.org, c.number].where((s) => s.isNotEmpty).join(' · ');
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _dial(c.number),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: context.rs(24), vertical: context.rs(20)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.hairline),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.title,
                      style: GoogleFonts.notoSansKr(
                        fontSize: context.rs(21),
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                    SizedBox(height: context.rs(3)),
                    Text(
                      subtitle,
                      style: GoogleFonts.notoSansKr(
                        fontSize: context.rs(18),
                        color: AppColors.stone,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.rs(12)),
              Container(
                width: context.rs(58),
                height: context.rs(58),
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(color: callColor, shape: BoxShape.circle),
                child:
                    Icon(Icons.call, color: Colors.white, size: context.rs(26)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
