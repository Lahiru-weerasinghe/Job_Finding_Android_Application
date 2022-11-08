import 'package:uee_assignment/models/user.dart';

class Message{
  User user;
  String firstName;
  String lastName;
  String lastMessage;
  String lastTime;
  bool isContinue;

  Message(this.user,this.firstName,this.lastName,this.lastMessage,this.lastTime,{this.isContinue = false});

  //get firstName => null;

  //get lastName => null;


  static List<Message> generateHomePageMessages() {
    return[
      Message(users[0], 'Oliver','Perera', 'Hey there what\'s up? Is everything be...', '09:48'),
      Message(users[1], 'Elsa','Dias','Can I call back? I\'m in the hospital...', '08:54'),
      Message(users[2], 'Noah','James','Hi! I went shopping today and I missed...', '07:22'),
    ];
  }
  //messages from the first user
  static List<Message> generateMessagesFromUser() {
    return [
      Message (
        users[0],'','',
        'Hey there! whats\'s up? Is everything going well?',
        '07:30',
      ),
      Message (
        me,'','',
        'Nothing. Just chilling and watching youtube. What about you?',
        '07:40',
      ),
      Message (
        users[0],'','',
        'Same here! Been watching Utube for the past 5hrs despite to have so much do.',
        '07:41', isContinue:true
      ),
      Message (
          users[0],'','',
          'It\'s hard to be productive man😤.',
          '07:42',
      ),
      Message (
          me,'','',
          'Yeah Iknow I,m in the same position😂',
          '07:45',
      ),
      Message (
        users[0],'','',
        'Lol😂',
        '07:51',
      ),
    ];
  }
}

var users = User.generateUsers();
var me = User(0, 'Oliver','Perera','assets/images/.Oliver Perera.png');