part of containers;

class IsLoadingContainer extends StatelessWidget {
  const IsLoadingContainer({Key key, this.builder}) : super(key: key);

  final ViewModelBuilder<bool> builder;
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      converter: (Store<AppState> store) => store.state.isLoading,
      builder: builder,
    );
  }
}
