import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/models/Post.dart';
import 'package:task/respositorys/respository.dart';

/// The normal [Provider] to provide the instance of PostRepository class.
/// which read-only so you can't modify the provider.
final postProvider = Provider<PostRepository>((ref) {
  return PostRepository();
});

/// The [stateProvider] StateProvider is a provider that exposes a way to modify its state. It is a
///  simplification of StateNotifierProvider, designed to avoid having to
///  write a StateNotifier class for very simple use-cases. Such as for enum or raw text.
/// here it is treated as query parameter for fetchImagePost.
final searchQueryProvider = StateProvider<String?>((ref) {
  return null;
});

/// The [futureProvider] will provide the List<Post>
/// It by defult have error and loading state so on any
/// `Exception` the error can be displayed.
final postFutureProvider = FutureProvider<List<Post>>((ref) async {
  // you can read provider which mean it will not watch for any change.
  // read method is a way to obtain the state of a provider without listening to it.
  final query = ref.watch(searchQueryProvider) ?? '';
  return ref.read(postProvider).fetchImagePost(query);
});
