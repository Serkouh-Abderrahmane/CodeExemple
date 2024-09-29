import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:serkouhacote/core/theme/Colors.dart';
import 'package:serkouhacote/core/utils/Urls.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';
import 'package:serkouhacote/features/users/domain/usecases/get_users.dart';
import 'package:serkouhacote/features/users/presentation/bloc/user_bloc.dart';
import 'package:serkouhacote/features/users/presentation/bloc/user_state.dart';
import 'package:serkouhacote/features/users/presentation/bloc/userevent.dart';
import 'package:serkouhacote/features/users/presentation/widgets/AdvertWidget.dart';
import 'package:serkouhacote/features/users/presentation/widgets/LoadingWidget.dart';

const int itemsBetweenAds = 10; // Number of items before an ad
const int adPlacementOffset = 11; // Total items including the ad

// Home screen displaying a list of users
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) =>
          UserBloc(getUsers: context.read<GetUsers>())..add(LoadUsers()),
      child: Builder(
        builder: (context) {
          // Controller to manage scroll events
          final ScrollController _scrollController = ScrollController();

          _scrollController.addListener(() {
            final state = context.read<UserBloc>().state;
            // Load more users when reaching the end of the list
            if (state is UserLoaded && state.hasMore) {
              if (_scrollController.position.pixels ==
                  _scrollController.position.maxScrollExtent) {
                context.read<UserBloc>().add(LoadMoreUsers());
              }
            }
          });

          return Scaffold(
            appBar: AppBar(
              title: Text("Random Users"),
              backgroundColor: Colors.black,
            ),
            floatingActionButton: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return FloatingActionButton(
                  backgroundColor: Colors.black,
                  tooltip: "Reload",
                  child: (state is UserLoading)
                      ? CircularProgressIndicator(
                          color: AppColors.primaryWhite,
                          backgroundColor: AppColors.secondaryblack,
                        )
                      : Icon(Icons.refresh),
                  onPressed: () {
                    context.read<UserBloc>().add(LoadUsers());
                  },
                );
              },
            ),
            body: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                // Build the list view based on current state
                return _buildListView(context, state, _scrollController);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildListView(
      BuildContext context, UserState state, ScrollController controller) {
    List<User> users = [];
    bool hasMore = false;
    final RefreshController _refreshController = RefreshController();

    void _onRefresh() async {
      context.read<UserBloc>().add(LoadUsers());
      await Future.delayed(Duration(milliseconds: 1000));
      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
      context.read<UserBloc>().add(LoadMoreUsers());
      await Future.delayed(Duration(milliseconds: 1000));
      _refreshController.loadComplete();
    }

    // Update list based on current state
    if (state is UserLoaded) {
      users = state.users;
      hasMore = state.hasMore;
    } else if (state is UserLoading) {
      users = [];
      hasMore = false;
      return DotLoadingWidget(); // Display loading widget
    } else if (state is UserError) {
      return Center(child: Text(state.message)); // Display error message
    }

    final userCount = users.length;
    final totalItemCount =
        userCount + (userCount ~/ itemsBetweenAds); // Include space for ads

    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
        controller: controller,
        itemCount: totalItemCount,
        itemBuilder: (context, index) {
          if ((index + 1) % adPlacementOffset == 0) {
            // Show an ad every 10 items
            return Clickable_AD_Image(
              imageUrl: AdsImageUrl,
              link: AdRedirect, // Replace with actual ad link
            );
          } else {
            // Calculate user index
            final userIndex = index - (index ~/ adPlacementOffset);
            if (userIndex >= 0 && userIndex < userCount) {
              return ListTile(
                leading: Hero(
                  tag: "image$userIndex",
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(users[userIndex].avatarUrl),
                  ),
                ),
                title: Text(
                  users[userIndex].name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("This is a long text"),
                trailing: SizedBox(
                  height: 20.0,
                  child: Icon(Icons.arrow_forward_ios),
                ),
                onTap: () {
                  final userName = users[userIndex].name;
                  GoRouter.of(context).push('/home/profile/$userName');
                },
              );
            } else {
              return Container(); // Empty container for placeholder
            }
          }
        },
      ),
    );
  }
}
