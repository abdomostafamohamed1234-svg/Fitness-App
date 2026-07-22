
import 'package:flowery/features/app_sections/domain/entities/custom_nav_item_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomNavItemModel', () {
    test('بيحتفظ بالـ icon و getLabel اللي اتبعتوله', () {
      const item = CustomNavItemModel(
        getLabel: _fakeLabel,
        icon: 'assets/icons/home.svg',
      );

      expect(item.icon, 'assets/icons/home.svg');
      expect(item.getLabel, _fakeLabel);
    });
  });
}

String _fakeLabel(dynamic l10n) => 'Home';