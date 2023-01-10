import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/providers/porviders.dart';
import 'package:task/widgets/image_card.dart';

import '../utils.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  // Bool value to toggle the search input field and app bar title.
  bool _toggle = false;

  // Controller
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // [watch] is used inside the build method of a widget or
    // inside the body of a provider to have the widget/provider listen to a provider.
    // Accordingly to that it rebuild the widget.
    final post = ref.watch(postFutureProvider);
    return RefreshIndicator(
      color: Colors.white,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      backgroundColor: Colors.blue,
      onRefresh: () => ref.refresh(postFutureProvider.future),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: CustomSwitcher(
            toggle: _toggle,
            firstChild: const Text('Pixabay'),
            secondChild: TextField(
              decoration: const InputDecoration(
                hintText: 'Type your query here...',
                alignLabelWithHint: false,
                border: InputBorder.none,
              ),
              controller: _textEditingController,
              onSubmitted: (value) {
                if (value.isEmpty) {
                  return showSnackBar(context, 'Field is empty type something');
                }
                ref.read(searchQueryProvider.notifier).update((state) => value);
              },
            ),
          ),
          actions: [
            IconButton(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              onPressed: () {
                setState(() {
                  _toggle = !_toggle;
                });
              },
              icon: const Icon(
                Icons.search,
                size: 25,
              ),
            ),
          ],
        ),
        body: post.when(
          data: (data) {
            if (data.isEmpty) {
              return const Center(
                child: Text('No Search for related query'),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final post = data[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: ImageCard(
                      userProfile: post.userImageURL,
                      imageUrl: post.largeImageURL,
                      tag: post.tags,
                      userName: post.user),
                );
              },
            );
          },
          error: (error, stackTrace) => Center(
              child: Chip(
            label: Text(
              error.toString(),
            ),
          )),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}


// Solution without state management

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late Future<List<Post>> _futurePost;
//   final PostRepository _postRepository = PostRepository();

//   @override
//   void initState() {
//     super.initState();
//     _futurePost = _postRepository.fetchImagePost('query');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//           centerTitle: true,
//           title: const Text('Pixabay'),
//         ),
//         body: FutureBuilder<List<Post>>(
//           future: _futurePost,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                   padding: const EdgeInsets.symmetric(horizontal: 5),
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (context, index) {
//                     final post = snapshot.data![index];
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 3.0),
//                       child: ImageCard(
//                           userProfile: post.userImageURL,
//                           imageUrl: post.largeImageURL,
//                           tag: post.tags,
//                           userName: post.user),
//                     );
//                   });
//             }
//             if (snapshot.hasError) {
//               return Text(snapshot.error.toString());
//             }
//             return const CircularProgressIndicator();
//           },
//         ));
//   }
// }
