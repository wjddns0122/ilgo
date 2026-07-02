// Unit tests for the "읽고" data layer. Pure-Dart parsing/logic — no Flutter
// binding needed, so they run fast and stay green in CI.

import 'package:flutter_test/flutter_test.dart';
import 'package:ilgo/data/models/analysis.dart';
import 'package:ilgo/data/models/analysis_summary.dart';
import 'package:ilgo/data/models/enums.dart';

void main() {
  group('OutputMode', () {
    test('maps to/from wire strings', () {
      expect(OutputMode.easyKorean.wire, 'easy_korean');
      expect(OutputMode.nativeLang.wire, 'native');
      expect(OutputMode.fromWire('native'), OutputMode.nativeLang);
      expect(OutputMode.fromWire('unknown'), OutputMode.easyKorean);
    });
  });

  group('RiskLevel', () {
    test('parses known levels and degrades unknown to unknown', () {
      expect(RiskLevel.fromString('red'), RiskLevel.red);
      expect(RiskLevel.fromString('green'), RiskLevel.green);
      expect(RiskLevel.fromString('yellow'), RiskLevel.yellow);
      expect(RiskLevel.fromString('???'), RiskLevel.unknown);
      expect(RiskLevel.fromString(null), RiskLevel.unknown);
    });
  });

  group('Analysis.fromJson', () {
    test('parses a full easy-korean result', () {
      final json = {
        'id': 'anl_0001',
        'status': 'done',
        'output_mode': 'easy_korean',
        'lang': 'ko',
        'doc_type': '고지서',
        'summary_one_line': '8월 15일까지 6만 8천 원',
        'original_text': '원문',
        'explained_text': '쉬운 풀이',
        'consequence': '연체료',
        'cards': {'what': '건강보험료', 'amount': '68,000원', 'deadline': '2026-08-15'},
        'risks': [
          {'id': 'rsk_1', 'level': 'yellow', 'type': '기한', 'message': '연체 주의'}
        ],
        'actions': [
          {'id': 'act_1', 'text': '납부', 'priority': 1, 'is_done': false}
        ],
        'reply_drafts': [],
        'created_at': '2026-06-30T07:10:00Z',
      };

      final a = Analysis.fromJson(json);

      expect(a.id, 'anl_0001');
      expect(a.outputMode, 'easy_korean');
      expect(a.cards?.amount, '68,000원');
      expect(a.risks.single.levelEnum, RiskLevel.yellow);
      expect(a.actions.single.isDone, isFalse);
      expect(a.replyDrafts, isEmpty);
    });

    test('defaults missing lists to empty', () {
      final a = Analysis.fromJson({
        'id': 'x',
        'status': 'done',
        'output_mode': 'native',
        'lang': 'en',
        'created_at': '2026-06-30T07:10:00Z',
      });
      expect(a.risks, isEmpty);
      expect(a.actions, isEmpty);
      expect(a.replyDrafts, isEmpty);
      expect(a.cards, isNull);
    });
  });

  group('AnalysisListResponse.fromJson', () {
    test('parses paginated list with real API data', () {
      final json = {
        "items": [
          {
            "id": "c9f4636b-a05d-4137-93eb-d5b6249d2290",
            "doc_type": "고지서",
            "summary_one_line": "2009년 2월 전기요금 62,210원을 3월 5일까지 내야 합니다.",
            "top_risk_level": "yellow",
            "card_deadline": "2009-03-05",
            "created_at": "2026-07-02T00:33:32.962395Z"
          },
          {
            "id": "a903fc61-042b-471b-a7d0-d94c393fa326",
            "doc_type": "고지서",
            "summary_one_line": "2009년 2월분 전기요금 62,210원을 3월 5일까지 내야 합니다.",
            "top_risk_level": "yellow",
            "card_deadline": "2009-03-05",
            "created_at": "2026-07-02T00:15:33.983207Z"
          }
        ],
        "next_cursor": null
      };

      final response = AnalysisListResponse.fromJson(json);
      expect(response.items.length, 2);
      expect(response.items[0].id, 'c9f4636b-a05d-4137-93eb-d5b6249d2290');
      expect(response.items[1].docType, '고지서');
      expect(response.nextCursor, isNull);
    });
  });
}
