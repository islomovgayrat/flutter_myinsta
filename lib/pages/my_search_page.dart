import 'package:flutter/material.dart';
import 'package:flutter_myinsta/services/db_service.dart';

import '../models/member_model.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({super.key});
  static const String id = 'search_id';

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  List<Member> items = [];
  var isLoading = false;
  TextEditingController searchController = TextEditingController();

  apiSearchMember(String keyword) {
    setState(() {
      isLoading = true;
    });
    DBService.searchMember(keyword).then((users) => {
          respSearchMembers(users),
        });
  }

  respSearchMembers(List<Member> members) {
    setState(() {
      items = members;
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiSearchMember('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Search",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontFamily: "Billabong",
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              children: [
                //search
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: Icon(Icons.search),
                      iconColor: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (ctx, index) {
                      return itemOfMember(items[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemOfMember(Member member) {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  border: Border.all(
                    width: 1.5,
                    color: const Color.fromRGBO(245, 96, 64, 1),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22.5),
                  child: member.imgUrl.isEmpty
                      ? const Image(
                          image: AssetImage('assets/images/img.png'),
                          fit: BoxFit.cover,
                          height: 45,
                          width: 45,
                        )
                      : Image.network(
                          member.imgUrl,
                          fit: BoxFit.cover,
                          height: 45,
                          width: 45,
                        ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.fullName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(member.email),
                ],
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey.shade500),
                    ),
                    child: const Center(
                      child: Text("Follow"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
