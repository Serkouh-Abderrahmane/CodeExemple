import 'package:connectivity/connectivity.dart';

// Abstract class that defines the contract for network connectivity information.
// Lớp trừu tượng định nghĩa hợp đồng cho thông tin kết nối mạng.
abstract class NetworkInfo {
  // A getter that returns a Future which resolves to true if the device is connected to the internet.
  // Getter trả về một Future mà nếu thiết bị được kết nối với internet sẽ trả về true.
  Future<bool> get isConnected;
}

// Concrete implementation of the NetworkInfo interface.
// This class uses the Connectivity package to check network connectivity.
// Triển khai cụ thể của giao diện NetworkInfo.
// Lớp này sử dụng gói Connectivity để kiểm tra kết nối mạng.
class NetworkInfoImpl implements NetworkInfo {
  // The Connectivity instance used to check network status.
  // Thể hiện Connectivity được sử dụng để kiểm tra trạng thái mạng.
  final Connectivity connectivity;

  // Constructor for NetworkInfoImpl, which initializes the Connectivity instance.
  // Constructor cho NetworkInfoImpl, khởi tạo thể hiện Connectivity.
  NetworkInfoImpl(this.connectivity);

  // Implementation of the isConnected getter.
  // This method asynchronously checks the current connectivity status.
  // Triển khai của getter isConnected.
  // Phương thức này kiểm tra trạng thái kết nối hiện tại một cách không đồng bộ.
  @override
  Future<bool> get isConnected async {
    // Check the connectivity status using the Connectivity instance.
    // Kiểm tra trạng thái kết nối bằng cách sử dụng thể hiện Connectivity.
    final connectivityResult = await connectivity.checkConnectivity();

    // Return true if the device is connected to any network (Wi-Fi, mobile, etc.).
    // If no network is available, return false.
    // Trả về true nếu thiết bị được kết nối với bất kỳ mạng nào (Wi-Fi, di động, v.v.).
    // Nếu không có mạng nào khả dụng, trả về false.
    return connectivityResult != ConnectivityResult.none;
  }
}
