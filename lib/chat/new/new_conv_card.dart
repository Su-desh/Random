import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random/chat/new/cubit/new_user_cubit.dart';
import 'package:random/helper/dialogs.dart';

import '../../API/api.dart';
import '../../helper/my_date_util.dart';
import '../../models/message.dart';

class NewConnectConversationCard extends StatefulWidget {
  const NewConnectConversationCard({super.key});

  @override
  State<NewConnectConversationCard> createState() =>
      _NewConnectConversationCardState();
}

class _NewConnectConversationCardState
    extends State<NewConnectConversationCard> {
  @override
  Widget build(BuildContext context) {
    final newUserCubit = context.watch<NewUserCubit>();

    return GestureDetector(
      onTap: () {
        Dialogs.connectWithStranger(context: context);
      },
      child: !context.watch<NewUserCubit>().isConnected
          ? const Padding(
              padding: EdgeInsets.only(left: 10, right: 5),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text('A'),
                ),
                title: Text('Anonymous',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.blue)),
                subtitle: Text(
                  'Tap to Connect!!',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: StreamBuilder(
                stream:
                    context.watch<NewUserCubit>().getLastMessageOfNewConnect(),
                builder: (context, snapshot) {
                  final data = snapshot.data?.docs;
                  final list =
                      data?.map((e) => Message.fromJson(e.data())).toList() ??
                          [];
                  if (list.isNotEmpty) newUserCubit.last_message = list[0];

                  return ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: Colors.blue, child: Text('A')),
                    //user name
                    title: const Text(
                      'Anonymous',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.blue),
                    ),

                    //last message
                    subtitle: Text(
                        newUserCubit.last_message != null
                            ? newUserCubit.last_message!.type == Type.image
                                ? 'image'
                                : newUserCubit.last_message!.msg
                            : 'send message !',
                        overflow: TextOverflow.ellipsis),

                    //last message time
                    trailing: newUserCubit.last_message == null
                        ? null //show nothing when no message is sent
                        : newUserCubit.last_message!.read.isEmpty &&
                                newUserCubit.last_message!.fromId !=
                                    APIs.user.uid
                            ?
                            //show for unread message
                            Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                    color: Colors.greenAccent.shade400,
                                    borderRadius: BorderRadius.circular(10)),
                              )
                            :
                            //message sent time
                            Text(
                                MyDateUtil.getLastMessageTime(
                                    context: context,
                                    time: newUserCubit.last_message!.sent),
                              ),
                  );
                },
              ),
            ),
    );
  }
}
