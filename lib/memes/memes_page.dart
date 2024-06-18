import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random/memes/cubit/memes_cubit.dart';

/// Memes Page which will show memes to the users
class MemesPage extends StatelessWidget {
  const MemesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final memesCubit = context.watch<MemesCubit>();

    return ListView.builder(
      controller: memesCubit.memeScrollController,
      itemCount: memesCubit.memeUrls.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 20,
            child: Column(
              children: [
                //show meme image (white background while loading)
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: FadeInImage(
                    placeholder:
                        const AssetImage('assets/white_background.jpeg'),
                    image: NetworkImage(
                      memesCubit.memeUrls[index],
                    ),
                  ),
                ),
                // Row of Download and Share button
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.download),
                        label: const Text('Download'),
                        onPressed: () {
                          //download the meme to local storage
                          context.read<MemesCubit>().downloadMemeToUserStorage(
                              memeUrl: memesCubit.memeUrls[index],
                              context: context);
                        },
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.share),
                        label: const Text('Share'),
                        onPressed: () {
                          //function to share memes
                          context.read<MemesCubit>().shareTheMeme(
                                memeUrl: memesCubit.memeUrls[index],
                              );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
