import 'package:flutter/material.dart';
import 'package:serkouhacote/core/theme/Colors.dart';
import 'package:serkouhacote/core/theme/Paddings.dart';
import 'package:serkouhacote/core/theme/fontsize.dart';
import 'package:serkouhacote/core/theme/spacing.dart';
import 'package:serkouhacote/features/users/domain/entities/Repositorie.dart';

// CabinetProposalCard displays information about a repository in a card format
// CabinetProposalCard hiển thị thông tin về một kho lưu trữ theo định dạng thẻ
class CabinetProposalCard extends StatelessWidget {
  final Repository repository; // Dữ liệu kho lưu trữ để hiển thị

  // Constructor to initialize the repository
  // Hàm khởi tạo để khởi tạo kho lưu trữ
  const CabinetProposalCard({
    Key? key,
    required this.repository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior
          .translucent, // Cho phép phát hiện chạm ngay cả khi một phần của widget là trong suốt
      onTap: () {
        // Hành động sẽ được thực hiện khi chạm vào có thể được thêm vào đây
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Paddings.base, // Padding ngang từ theme
          vertical: Paddings.base, // Padding dọc từ theme
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryWhite
              .withOpacity(0.2), // Màu nền nhẹ với độ trong suốt
          borderRadius: BorderRadius.circular(8), // Góc bo tròn
          border: Border.all(
            color: AppColors.primaryGray, // Màu viền từ theme
            width: 1, // Độ dày viền
          ),
        ),
        child: Column(
          children: [
            _cardHeader(), // Phần tiêu đề của thẻ
            SizedBox(
              height: Spacing.base, // Khoảng cách giữa tiêu đề và thân
            ),
            _cardBody(), // Phần thân của thẻ
            SizedBox(
              height: Spacing.base, // Khoảng cách sau thân
            ),
          ],
        ),
      ),
    );
  }

  // Builds the body of the card with repository description
  // Xây dựng thân của thẻ với mô tả kho lưu trữ
  Widget _cardBody() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Căn chỉnh văn bản bắt đầu
      children: [
        Expanded(
          child: Text(
            repository.description, // Mô tả kho lưu trữ
            style: TextStyle(
              fontSize: FontSizes.medium, // Kích thước phông chữ từ theme
              color: AppColors.secondarygrey, // Màu văn bản từ theme
              fontWeight: FontWeight.bold, // Độ dày phông chữ nhấn mạnh
            ),
            maxLines: 2, // Giới hạn văn bản ở 2 dòng
            overflow: TextOverflow
                .ellipsis, // Cắt ngắn văn bản với dấu ba chấm nếu quá dài
          ),
        ),
      ],
    );
  }

  // Builds the header of the card with repository name, language, and stargazers count
  // Xây dựng tiêu đề của thẻ với tên kho lưu trữ, ngôn ngữ và số lượng người đánh giá
  Widget _cardHeader() {
    return Row(
      children: [
        Container(
          width: 65, // Chiều rộng cố định cho container số lượng sao
          padding: const EdgeInsets.only(
              top: 5,
              right: 7.5,
              bottom: 5,
              left: 7.5), // Padding xung quanh số lượng sao
          decoration: BoxDecoration(
            color: AppColors.primaryBlack, // Màu nền cho số lượng sao
            borderRadius: BorderRadius.circular(999), // Đường viền hình tròn
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Căn giữa các mục trong hàng
            children: [
              Icon(
                Icons.star, // Biểu tượng sao để đại diện cho người đánh giá
                size: FontSizes.medium, // Kích thước biểu tượng từ theme
                color: AppColors.primaryWhite, // Màu biểu tượng từ theme
              ),
              SizedBox(
                width: Spacing.xsmall, // Khoảng cách giữa biểu tượng và văn bản
              ),
              Text(
                repository.stargazersCount
                    .toString(), // Số lượng người đánh giá
                style: TextStyle(
                    fontSize: FontSizes
                        .medium, // Kích thước phông chữ cho số lượng người đánh giá
                    color: AppColors.primaryWhite), // Màu phông chữ
              ),
            ],
          ),
        ),
        SizedBox(
          width: Spacing
              .base, // Khoảng cách giữa số lượng sao và chi tiết kho lưu trữ
        ),
        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Căn chỉnh các mục trong cột bắt đầu
          children: [
            Text(
              repository.name, // Tên kho lưu trữ
              style: TextStyle(
                fontSize: FontSizes
                    .xLarge, // Kích thước phông chữ cho tên kho lưu trữ
                fontWeight: FontWeight.bold, // Độ dày phông chữ nhấn mạnh
              ),
            ),
            Text(
              repository.language, // Ngôn ngữ kho lưu trữ
              style: TextStyle(
                fontSize: FontSizes
                    .medium, // Kích thước phông chữ cho ngôn ngữ kho lưu trữ
                color: AppColors.secondaryblack, // Màu phông chữ
              ),
            ),
          ],
        ),
      ],
    );
  }
}
