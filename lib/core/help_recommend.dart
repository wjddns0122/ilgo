/// Local, offline-first recommendation of help contacts for a given risk type.
///
/// The backend `GET /help-contacts?risk_type=` returns the same shape, but the
/// risk-detail screen needs deterministic, network-free CTAs for the demo (and
/// as a fallback when the API is unavailable). Kept as a pure function so it is
/// unit-testable without a widget or network.
///
/// Two tiers:
///  - [RiskHelp.tier1] "지금 확인" — who to call to verify before acting.
///  - [RiskHelp.victim] "벌써 당했다면" — what to do if already harmed
///    (report + freeze payment + relief channels). Guidance tone only, never a
///    promise of compensation.
library;

/// A single recommended contact (title / org / phone).
class HelpContactRef {
  const HelpContactRef(
    this.title,
    this.org,
    this.phone, {
    this.emergency = false,
  });

  final String title;
  final String org;
  final String phone;
  final bool emergency;
}

/// "벌써 당했다면" guidance: a 존댓말 note from 또바기 + report/relief contacts.
class VictimHelp {
  const VictimHelp({required this.guide, required this.contacts});

  final String guide;
  final List<HelpContactRef> contacts;
}

/// Recommended help for one risk type.
class RiskHelp {
  const RiskHelp({this.tier1 = const [], this.victim});

  /// "지금 확인" contacts (verify before acting). May be empty → only the
  /// full "도움받을 곳 보기" screen is offered.
  final List<HelpContactRef> tier1;

  /// "벌써 당했다면" block, or null when not applicable (e.g. 과태료/기한).
  final VictimHelp? victim;
}

/// Map a (possibly loosely-typed) risk type string to recommended contacts.
///
/// Uses substring matching so backend variants (`사기`/`스미싱`/`피싱`…) all map
/// correctly, mirroring the front/back contract in the work orders.
RiskHelp recommendedHelp(String? riskType) {
  final t = (riskType ?? '').trim();
  bool has(List<String> keys) => keys.any(t.contains);

  // 사기 / 스미싱 / 피싱 → 118 확인, 피해 시 112 + 지급정지 + 법률구조.
  if (has(['사기', '스미싱', '피싱', '보이스피싱'])) {
    return const RiskHelp(
      tier1: [HelpContactRef('스미싱·해킹 상담', 'KISA/보호나라', '118')],
      victim: VictimHelp(
        guide: '혹시 벌써 링크를 눌렀거나 돈을 보내셨어요? 지금 바로 112에 신고하고, '
            '보낸 은행 고객센터에 지급정지를 요청해요. 돌려받을 수 있는 공식 절차가 있어요.',
        contacts: [
          HelpContactRef('경찰 신고', '경찰', '112', emergency: true),
          HelpContactRef('지급정지·보이스피싱 상담', '금융감독원', '1332'),
          HelpContactRef('무료 법률상담', '대한법률구조공단', '132'),
        ],
      ),
    );
  }

  // 임금 / 계약 / 부당공제 → 1350 상담, 피해 시 1350 + 대지급금 안내.
  if (has(['임금', '급여', '일당', '부당공제', '계약', '숙소비', '공제'])) {
    return const RiskHelp(
      tier1: [
        HelpContactRef('임금·노동 상담', '고용노동부', '1350'),
        HelpContactRef('외국인종합안내센터', '법무부', '1345'),
      ],
      victim: VictimHelp(
        guide: '임금을 못 받거나 부당하게 공제됐어요? 고용노동부 1350에 상담해요. '
            '회사가 끝내 안 주면 국가가 대신 주는 대지급금 제도가 있어요.',
        contacts: [
          HelpContactRef('임금·노동 상담', '고용노동부', '1350'),
          HelpContactRef('외국인종합안내센터', '법무부', '1345'),
        ],
      ),
    );
  }

  // 건강보험 → 공식 고객센터.
  if (has(['건강보험'])) {
    return const RiskHelp(
      tier1: [HelpContactRef('건강보험 문의', '국민건강보험공단', '1577-1000')],
    );
  }

  // 과태료 / 기한 / 기타 → 전체 "도움받을 곳"만.
  return const RiskHelp();
}
