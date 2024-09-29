// Abstract class that defines the contract for a use case.
// Lớp trừu tượng định nghĩa hợp đồng cho một trường hợp sử dụng.
abstract class UseCase<Type, Params> {
  // Method that executes the use case with the provided parameters and returns a result of type [Type].
  // The [Params] is the input for the use case, and [Type] is the output.
  // Phương thức thực thi trường hợp sử dụng với các tham số được cung cấp và trả về một kết quả có loại [Type].
  // [Params] là đầu vào cho trường hợp sử dụng, và [Type] là đầu ra.
  Future<Type> call(Params params);
}
