import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart';
import 'package:flowery/features/app_sections/presentation/view_model/cubit/app_sections_states.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppSectionsCubit', () {
    
    group('plain tests', () {
      late AppSectionsCubit cubit;

      setUp(() {
        cubit = AppSectionsCubit();
      });

      tearDown(() async {
        await cubit.close(); 
      });

      test('initial state has currentIndex = 0', () {
        expect(cubit.state, const AppSectionsStates(currentIndex: 0));
      });

      test('pageController is created with initialPage 0', () {
        expect(cubit.pageController.initialPage, 0);
      });

      test(
        'setCurrentIndex متتكسرش لو pageController لسه مش متوصل بـ PageView '
        '(hasClients = false)',
        () {
          expect(cubit.pageController.hasClients, isFalse);
          expect(() => cubit.setCurrentIndex(1), returnsNormally);
          expect(cubit.state.currentIndex, 1);
        },
      );

      test('close() بيقفل من غير ما يرمي exception', () async {
        
        final localCubit = AppSectionsCubit();
        await expectLater(localCubit.close(), completes);
      });
    });

    group('bloc tests', () {
      blocTest<AppSectionsCubit, AppSectionsStates>(
        'يبعت (emit) state جديدة بـ currentIndex الصحيح لما setCurrentIndex تتنادى',
        build: () => AppSectionsCubit(), 
        act: (c) => c.setCurrentIndex(2),
        expect: () => [const AppSectionsStates(currentIndex: 2)],
      );

      blocTest<AppSectionsCubit, AppSectionsStates>(
        'بيبعت أكتر من state لو setCurrentIndex اتنادت أكتر من مرة',
        build: () => AppSectionsCubit(),
        act: (c) {
          c.setCurrentIndex(1);
          c.setCurrentIndex(3);
        },
        expect: () => [
          const AppSectionsStates(currentIndex: 1),
          const AppSectionsStates(currentIndex: 3),
        ],
      );
    });
  });
}