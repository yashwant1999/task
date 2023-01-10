import 'package:flutter/material.dart';
import 'package:task/constant.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final String tag;
  final String userName;
  final String userProfile;
  const ImageCard(
      {Key? key,
      required this.imageUrl,
      required this.tag,
      required this.userName,
      required this.userProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FadeInImage(
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) =>
                      Center(child: Text(error.toString())),
                  image: NetworkImage(imageUrl),
                  placeholder: const AssetImage('assets/placeholder-2.png'),
                )),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(userProfile.isEmpty
                            ? Constant.defultUrl
                            : userProfile),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        userName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Flexible(
                    child: Chip(
                      label: Text(
                        tag,
                      ),
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
