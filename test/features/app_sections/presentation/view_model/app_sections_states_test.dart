import 'package:flowery/features/app_sections/presentation/view_model/cubit/app_sections_states.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppSectionsStates', () {
    test('اتنين states بنفس الـ currentIndex بيبقوا equal (بفضل Equatable)', () {
      const a = AppSectionsStates(currentIndex: 1);
      const b = AppSectionsStates(currentIndex: 1);
      expect(a, equals(b));
    });

    test('اتنين states بـ currentIndex مختلف بيبقوا مش equal', () {
      const a = AppSectionsStates(currentIndex: 0);
      const b = AppSectionsStates(currentIndex: 1);
      expect(a, isNot(equals(b)));
    });

    test('copyWith بيغيّر currentIndex بس', () {
      const original = AppSectionsStates(currentIndex: 0);
      final updated = original.copyWith(currentIndex: 3);
      expect(updated.currentIndex, 3);
    });

    test('copyWith من غير أي parameter بيرجع نفس القيمة', () {
      const original = AppSectionsStates(currentIndex: 2);
      final updated = original.copyWith();
      expect(updated, equals(original));
    });

    test('props بترجع currentIndex بس', () {
      const state = AppSectionsStates(currentIndex: 5);
      expect(state.props, [5]);
    });
  });
}