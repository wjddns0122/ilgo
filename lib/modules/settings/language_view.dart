import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../data/services/profile_service.dart';

/// Full-page language picker (Figma "LanguageChange", node 17:1289 frame).
/// Lists every supported mother tongue + 한국어, with search. Consistent with
/// the app's paper/forest design system.
class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

/// code → native-script endonym.
const _endonyms = <String, String>{
  'ko': '한국어',
  'km': 'ភាសាខ្មែរ',
  'vi': 'Tiếng Việt',
  'ne': 'नेपाली',
  'en': 'English',
  'zh': '中文',
  'th': 'ภาษาไทย',
  'id': 'Bahasa Indonesia',
};

class _LanguageViewState extends State<LanguageView> {
  final ProfileService _profile = Get.find<ProfileService>();
  String _query = '';

  List<MapEntry<String, String>> get _filtered {
    final q = _query.trim().toLowerCase();
    final all = ProfileService.langLabels.entries.toList();
    if (q.isEmpty) return all;
    return all.where((e) {
      final endonym = (_endonyms[e.key] ?? '').toLowerCase();
      return e.value.toLowerCase().contains(q) || endonym.contains(q);
    }).toList();
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
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      context.rs(28), context.rs(8), context.rs(28), context.rs(16)),
                  child: _searchField(context),
                ),
                Expanded(
                  child: Obx(() {
                    final current = _profile.lang.value;
                    final items = _filtered;
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: context.rs(28)),
                      itemCount: items.length,
                      separatorBuilder: (_, _) =>
                          Divider(height: 1, color: AppColors.hairline),
                      itemBuilder: (_, i) =>
                          _langTile(context, items[i], current == items[i].key),
                    );
                  }),
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
          SizedBox(width: context.rs(16)),
          Text(
            '내 언어',
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(18.4),
              fontWeight: FontWeight.w700,
              letterSpacing: -0.184,
              color: AppColors.forest,
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.hairline),
      ),
      padding: EdgeInsets.symmetric(horizontal: context.rs(14)),
      child: Row(
        children: [
          Icon(Icons.search, size: context.rs(20), color: AppColors.stone),
          SizedBox(width: context.rs(10)),
          Expanded(
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              style: GoogleFonts.notoSansKr(
                  fontSize: context.rs(16), color: AppColors.ink),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: '언어 검색',
                hintStyle: GoogleFonts.notoSansKr(
                    fontSize: context.rs(16), color: AppColors.stone),
                contentPadding:
                    EdgeInsets.symmetric(vertical: context.rs(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _langTile(
      BuildContext context, MapEntry<String, String> lang, bool selected) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          await _profile.setProfile(language: lang.key);
          Get.back();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.rs(18)),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang.value,
                      style: GoogleFonts.notoSansKr(
                        fontSize: context.rs(18),
                        fontWeight: FontWeight.w700,
                        color: selected ? AppColors.forest : AppColors.ink,
                      ),
                    ),
                    SizedBox(height: context.rs(2)),
                    // Plain style → native-script endonyms render via system font.
                    Text(
                      _endonyms[lang.key] ?? '',
                      style: TextStyle(
                          fontSize: context.rs(15), color: AppColors.stone),
                    ),
                  ],
                ),
              ),
              if (selected)
                Icon(Icons.check_circle,
                    color: AppColors.forest, size: context.rs(24)),
            ],
          ),
        ),
      ),
    );
  }
}
