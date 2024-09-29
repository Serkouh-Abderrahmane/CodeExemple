import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:serkouhacote/features/users/domain/entities/Repositorie.dart';
import 'package:serkouhacote/features/users/presentation/widgets/cabinet_proposal_card.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('CabinetProposalCard displays repository data correctly',
      (WidgetTester tester) async {
    // Define a test repository
    // Định nghĩa một kho kiểm tra.
    final testRepository = Repository(
      name: 'Test Repo',
      description: 'This is a test repository description.',
      language: 'Dart',
      stargazersCount: 123,
    );

    // Build the CabinetProposalCard widget
    // Xây dựng widget CabinetProposalCard.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CabinetProposalCard(repository: testRepository),
        ),
      ),
    );

    // Verify if the repository name is displayed
    // Xác minh xem tên kho có hiển thị hay không.
    expect(find.text('Test Repo'), findsOneWidget);

    // Verify if the repository description is displayed
    // Xác minh xem mô tả kho có hiển thị hay không.
    expect(find.text('This is a test repository description.'), findsOneWidget);

    // Verify if the repository language is displayed
    // Xác minh xem ngôn ngữ kho có hiển thị hay không.
    expect(find.text('Dart'), findsOneWidget);

    // Verify if the stargazers count is displayed with a star icon
    // Xác minh xem số lượng người xem có hiển thị cùng với biểu tượng ngôi sao hay không.
    expect(find.byIcon(Icons.star), findsOneWidget);
    expect(find.text('123'), findsOneWidget);
  });
}
