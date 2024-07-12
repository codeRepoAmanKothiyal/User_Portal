import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_portal/Model/user_model.dart';
import 'package:user_portal/Screens/create.dart';
import 'package:user_portal/Screens/login.dart';
import 'package:user_portal/Screens/register.dart';
import '../Service/api_service.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<UsersPageData?> futureUserData;
  int currentPage = 1;
  int maxPage= 2;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    futureUserData = Api().getUserData(currentPage);
  }

  Future<void> _loadData(int page) async {
    setState(() {
      futureUserData = Api().getUserData(page);
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.dehaze_rounded),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(
          "Users",
          style: TextStyle(fontSize: 25),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: CircleAvatar(backgroundImage:
              NetworkImage("https://pinnacle.works/wp-content/uploads/2022/06/dummy-image.jpg",),
              )
            ),
            ListTile(
              title: Text("Register", style: TextStyle(fontSize: 20),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Register()),
                );
              },
            ),
            ListTile(
              title: Text("Login",style: TextStyle(fontSize: 20),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LogIn()),
                );
              },
            ),
            ListTile(
              title: Text("Create", style: TextStyle(fontSize: 20),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Create( )),
                );
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<UsersPageData?>(
        future: futureUserData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            UsersPageData? usersPageData = snapshot.data;
            List<Users>? users = usersPageData?.users;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: users?.length ?? 0,
                    itemBuilder: (context, index) {
                      Users? user = users?[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "${snapshot.data?.users?[index].avatar ?? ' '}"),
                        ),
                        title: Text(
                            "${snapshot.data?.users?[index].firstName ?? ' '} ${snapshot.data?.users?[index].lastName ?? ''}"),
                        subtitle: Text(
                            snapshot.data?.users?[index].email ?? ''),
                      );
                    },
                  ),
                ),
                BottomAppBar(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          if (currentPage > 1) {
                            _loadData(currentPage - 1);
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          if(currentPage != maxPage){
                            _loadData(currentPage + 1);
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar
                              (content: Text("There are Only 2 Pages")));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
