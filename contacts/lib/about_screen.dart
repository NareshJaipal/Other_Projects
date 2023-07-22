// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:contacts/call_screen.dart';

import 'database.dart';

class AboutScreen extends StatefulWidget {
  final String name;
  final String phoneNumber;
  bool isFavorite;

  AboutScreen({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.isFavorite,
  }) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

  @override
  void initState() {
    // Initialize the controllers with the existing contact details
    var nameParts = widget.name.split(' ');
    firstName.text = nameParts[0];
    lastName.text = nameParts.length > 1 ? nameParts[1] : '';
    phoneNumber.text = widget.phoneNumber;

    super.initState();
  }

  void updateContact(BuildContext context) {
    String updatedName = '${firstName.text} ${lastName.text}';
    String updatedNumber = phoneNumber.text;

    // Update the contact in the contacts list
    setState(() {
      for (int i = 0; i < contacts.length; i++) {
        if (contacts[i]['name'] == widget.name &&
            contacts[i]['phoneNumber'] == widget.phoneNumber) {
          contacts[i]['name'] = updatedName;
          contacts[i]['phoneNumber'] = updatedNumber;

          break;
        }
      }
    });

    Navigator.of(context).pop(); // Close the dialog
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              'https://images.unsplash.com/photo-1518014179319-21e9e8139b05?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
            ),
          ),
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.keyboard_arrow_left_rounded,
                      color: Colors.white, size: 35),
                ),
                TextButton(
                  child: const Text(
                    "Edit Contact",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Container(
                            margin: const EdgeInsets.all(5),
                            height: 255,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon:
                                          const Icon(Icons.keyboard_arrow_left),
                                    ),
                                    const Text("Edit Contact"),
                                  ],
                                ),
                                const Divider(),
                                TextField(
                                  controller: firstName,
                                  decoration: const InputDecoration(
                                    label: Text('First Name'),
                                  ),
                                ),
                                TextField(
                                  controller: lastName,
                                  decoration: const InputDecoration(
                                    label: Text('Last Name'),
                                  ),
                                ),
                                TextField(
                                  controller: phoneNumber,
                                  decoration: const InputDecoration(
                                    label: Text('Phone Number'),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                TextButton(
                                  onPressed: () => updateContact(context),
                                  child: const Text('Save changes'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 150),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: const Column(
                children: [Text("D")],
              ),
            ),

            // Name and Photo
            Container(
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.only(top: 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.blueGrey,
                    child: Icon(Icons.person, size: 80, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.name,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 30),
                  AboutScreenActions(
                    name: widget.name,
                    phoneNumber: widget.phoneNumber,
                    isFavorite: widget.isFavorite,
                  ),
                  AboutScreenPhoneNumber(phoneNumber: widget.phoneNumber),
                  const AboutScreenWhatsApp(),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              widget.isFavorite = !widget.isFavorite;
                            });
                          },
                          child: widget.isFavorite
                              ? const Text('Unfavorite')
                              : const Text('Add to Favorite'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Block this Number",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
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

class AboutScreenActions extends StatelessWidget {
  const AboutScreenActions({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.isFavorite,
  }) : super(key: key);

  final String name;
  final String phoneNumber;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 95,
          height: 55,
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blueGrey),
          ),
          child: TextButton(
            onPressed: () {},
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.message_rounded),
                Text("Message"),
              ],
            ),
          ),
        ),
        Container(
          width: 95,
          height: 55,
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blueGrey),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CallScreen(
                    name: name,
                    phoneNumber: phoneNumber,
                  ),
                ),
              );
            },
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.call_outlined),
                Text("Call"),
              ],
            ),
          ),
        ),
        Container(
          width: 95,
          height: 55,
          decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blueGrey)),
          child: TextButton(
            onPressed: () {},
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.videocam_rounded),
                Text("Video"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AboutScreenWhatsApp extends StatelessWidget {
  const AboutScreenWhatsApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: const EdgeInsets.fromLTRB(15, 5, 15, 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Whatsapp",
            style: TextStyle(fontSize: 19),
          ),
          Image(
            height: 35,
            width: 40,
            image: NetworkImage(
              'https://img.icons8.com/?size=512&id=16713&format=png',
            ),
          ),
        ],
      ),
    );
  }
}

class AboutScreenPhoneNumber extends StatelessWidget {
  const AboutScreenPhoneNumber({
    super.key,
    required this.phoneNumber,
  });

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: const EdgeInsets.fromLTRB(15, 20, 15, 5),
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Mobile | Pakistan",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 5),
          Text(
            phoneNumber,
            style: const TextStyle(fontSize: 17),
          )
        ],
      ),
    );
  }
}

// class AboutScreenNavigationBar extends StatelessWidget {
//   final firstName;
//   final lastName;
//   final phoneNumber;

//   const AboutScreenNavigationBar({
//     super.key,
//     this.firstName,
//     this.lastName,
//     this.phoneNumber,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
