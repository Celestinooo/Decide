import 'package:decide/tabs/models/notification_model.dart';
import 'package:flutter/material.dart';

class NotificationsTab extends StatefulWidget {
  const NotificationsTab({Key? key}) : super(key: key);

  @override
  State<NotificationsTab> createState() => _NotificationsTabState();
}

class _NotificationsTabState extends State<NotificationsTab> {
  final List<NotificationModel> notifications = [
    NotificationModel(
      title: 'Vitor Moreira comentou na sua publicação',
      subtitle: 'Na minha opinião, não conseguimos medir...',
      imageUrl: 'assets/images/random_man2.jpeg',
    ),
    NotificationModel(
      title: 'Sua publicação atingiu 100.000 votos',
      subtitle: 'Agradecemos pela sua contribuição com o Decide!',
      imageUrl: 'assets/images/sirene.png',
    ),
    NotificationModel(
      title: 'Atualização disponível',
      subtitle: 'Uma nova versão do aplicativo está disponível',
      imageUrl: 'assets/images/retry.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          automaticallyImplyLeading: false,
          centerTitle: true ,
          bottom: const TabBar(
            indicatorColor: Colors.red,
            tabs: [
              Tab(
                text: 'Central',
                icon: Icon(Icons.notifications_active,color: Colors.white,size: 32,),
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(notification.imageUrl),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text(notification.title),
                    subtitle: Text(notification.subtitle),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
