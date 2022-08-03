import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kortobaa/helpers/constants.dart';
import 'package:kortobaa/presentation/widgets/posts_list.dart';
import 'package:kortobaa/presentation/widgets/profile_details.dart';

import '../widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  switchTabs(int index) {
    if (index == 0) {
      tabController.animateTo(0);
    } else if (index == 1) {
      tabController.animateTo(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الرئيسية',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        backgroundColor: kNavyBlue,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: TabBar(
            controller: tabController,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.blueGrey.shade200,
            tabs: const [
              Tab(
                text: "الرئيسية",
              ),
              Tab(
                text: "حسابي",
              ),
            ],
            labelColor: kOffWhite,
            // add it here
          ),
        ),
      ),
      drawer: CustomDrawer(function: switchTabs),
      body: TabBarView(
        controller: tabController,
        children: [
          PostsList(),
          ProfileDetails(),
        ],
      ),
    );
  }
}
