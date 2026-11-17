import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:termoguia/main.dart';

void main() {
  testWidgets('Exibe a tela inicial e filtra os pontos', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TermoguiaApp());
    await tester.pumpAndSettle();

    expect(find.text('Termoguia'), findsOneWidget);
    expect(find.text('Pontos de refúgio (6)'), findsOneWidget);

    final verticalScrollable = find
        .byWidgetPredicate(
          (widget) =>
              widget is Scrollable &&
              widget.axisDirection == AxisDirection.down,
        )
        .first;

    final shadeChip = find.widgetWithText(ChoiceChip, 'Sombra');

    await tester.scrollUntilVisible(
      shadeChip.hitTestable(),
      150,
      scrollable: verticalScrollable,
    );

    await tester.pumpAndSettle();

    await tester.tap(shadeChip.hitTestable());
    await tester.pumpAndSettle();

    expect(find.widgetWithText(ChoiceChip, 'Sombra'), findsOneWidget);

    expect(find.text('Pontos de refúgio (2)'), findsOneWidget);

    final selectedChip = tester.widget<ChoiceChip>(shadeChip);

    expect(selectedChip.selected, isTrue);
  });
}
