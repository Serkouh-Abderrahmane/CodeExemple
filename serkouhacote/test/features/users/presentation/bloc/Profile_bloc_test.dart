import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serkouhacote/features/users/domain/entities/Repositorie.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';
import 'package:serkouhacote/features/users/domain/repositories/profile_repository.dart';
import 'package:serkouhacote/features/users/domain/usecases/get_profile.dart';
import 'package:serkouhacote/features/users/presentation/bloc/profile_bloc.dart';

// Mock class
class MockProfileRepository extends Mock implements ProfileRepository {}

// Sample user and repositories data for testing
final User testUser = User(
  id: 1,
  name: 'John Doe',
  avatarUrl: 'http://example.com/avatar.jpg',
);

final List<Repository> testRepositories = [
  Repository(
    language: "En",
    stargazersCount: 2,
    name: 'Repo1',
    description: 'Description of Repo1',
  ),
  Repository(
    language: "fr",
    stargazersCount: 8,
    name: 'Repo2',
    description: 'Description of Repo2',
  ),
];

void main() {
  late ProfileBloc profileBloc;
  late MockProfileRepository mockProfileRepository;

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    profileBloc = ProfileBloc(repository: mockProfileRepository);
  });

  tearDown(() {
    profileBloc.close(); // Clean up the bloc after each test
  });

  test('Initial state should be ProfileInitial', () {
    expect(profileBloc.state, equals(ProfileInitial()));
  });

  group('LoadProfile', () {
    test('Emits [ProfileLoading, ProfileLoaded] on successful profile fetch',
        () async {
      // Arrange
      when(mockProfileRepository.getUser('john_doe'))
          .thenAnswer((_) async => testUser);
      when(mockProfileRepository.getRepositories('john_doe'))
          .thenAnswer((_) async => testRepositories);

      // Act
      profileBloc.add(LoadProfile('john_doe'));

      // Assert
      await expectLater(
        profileBloc.stream,
        emitsInOrder([
          ProfileLoading(),
          ProfileLoaded(testUser, testRepositories),
        ]),
      );
    });

    test('Emits [ProfileLoading, ProfileError] on error', () async {
      // Arrange
      when(mockProfileRepository.getUser('john_doe'))
          .thenThrow(Exception('Error'));
      when(mockProfileRepository.getRepositories('john_doe'))
          .thenThrow(Exception('Error'));

      // Act
      profileBloc.add(LoadProfile('john_doe'));

      // Assert
      await expectLater(
        profileBloc.stream,
        emitsInOrder([
          ProfileLoading(),
          ProfileError('An error occurred: Exception: Error'),
        ]),
      );
    });
  });
}
