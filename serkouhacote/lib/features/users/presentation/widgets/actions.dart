import 'package:flutter/material.dart';
import 'package:serkouhacote/core/theme/Colors.dart';
import 'package:serkouhacote/core/theme/fontsize.dart';
import 'package:serkouhacote/features/users/domain/entities/Repositorie.dart';
import 'package:serkouhacote/features/users/presentation/widgets/cabinet_proposal_card.dart';

// ActionsList displays a list of repositories
// ActionsList hiển thị danh sách các kho lưu trữ
class ActionsList extends StatelessWidget {
  final List<Repository> repositories;

  // Constructor to accept the list of repositories
  // Hàm khởi tạo nhận danh sách các kho lưu trữ
  const ActionsList({Key? key, required this.repositories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        color: AppColors.primaryWhite, // Background color for the container
        // Màu nền cho container
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Repositories', // Title text
              style: TextStyle(
                fontSize: FontSizes.large, // Font size for the title
                fontWeight: FontWeight.bold, // Font weight for the title
                color: AppColors.secondarygrey, // Text color for the title
              ),
            ),
          ),
          const SizedBox(height: 16), // Space between the title and the list
          SingleChildScrollView(
            child: Column(
              children: repositories
                  .map((repository) => CabinetProposalCard(
                      repository:
                          repository)) // Map each repository to a CabinetProposalCard widget
                  .toList(), // Convert the list of widgets to a ListView
            ),
          ),
        ],
      ),
    );
  }
}
