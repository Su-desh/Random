import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random/chat/new/cubit/new_user_cubit.dart';
import 'package:random/helper/dialogs.dart';

/// blue line widget which will have options to skip end and add friend
class SkipToNextEndChat extends StatelessWidget {
  const SkipToNextEndChat({super.key});

  @override
  Widget build(BuildContext context) {
    final newUserCubit = context.watch<NewUserCubit>();

    return Container(
      color: Colors.blue,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              onPressed: () {
                newUserCubit.funcForNewConnect();
              },
              child: const Text('Skip To Next')),
          if (newUserCubit.isConnected)
            ElevatedButton(
                onPressed: () {
                  if (context.read<NewUserCubit>().isConnected) {
                    newUserCubit.endThisConnectedChat();
                  } else {
                    Dialogs.showSnackbar(context, 'you are not connected!!');
                  }
                },
                child: const Text('End This Chat')),
          if (newUserCubit.isConnected)
            ElevatedButton(
                onPressed: () async {
                  if (newUserCubit.isConnected) {
                    //send friend request
                    String req = '[FRIEND_REQUEST]';
                    newUserCubit.sendMessageOfNewConnect(req);
                  } else {
                    Dialogs.showSnackbar(context, 'you are not connected!!');
                  }
                },
                child: const Icon(Icons.person_add_alt_rounded))
        ],
      ),
    );
  }
}
