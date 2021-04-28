// ignore_for_file: invalid_use_of_protected_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:stack_fin_notes/app/core/constants/asset_path.dart';
import 'package:stack_fin_notes/app/core/theme/app_colors.dart';
import 'package:stack_fin_notes/app/data/models/note.dart';
import 'package:stack_fin_notes/app/shared/widgets/image_widget.dart';
import 'package:stack_fin_notes/app/shared/widgets/loader.dart';
import 'package:stack_fin_notes/app/shared/widgets/logo.dart';
import 'package:stack_fin_notes/app/shared/widgets/nothing_here.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  final cont = ScrollController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: DrawerHeader(
                  child: Stack(
                children: [
                  Container(
                      child: Opacity(
                          opacity: 0.1,
                          child: SvgPicture.asset(
                            AssetPath.notesSvg,
                            fit: BoxFit.cover,
                          ))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          child: controller.photoURL != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Image.network(
                                    controller.photoURL,
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : Text(
                                  controller.displayName
                                      .substring(0, 1)
                                      .capitalize,
                                  maxLines: 1,
                                ),
                          maxRadius: 24,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            controller.displayName,
                            style: textTheme.bodyText1
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            controller.email,
                            style: textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NothingHere(size: 100),
                  SizedBox(height: 16),
                  Text("Nothing here..."),
                  SizedBox(height: 100),
                ],
              ),
            ),
            ListTile(
              leading: FlatButton.icon(
                onPressed: () {
                  controller.onLogout();
                },
                icon: Icon(
                  Icons.logout,
                  color: AppColors.red,
                ),
                label: Text(
                  'Log out',
                  style: textTheme.caption.copyWith(color: AppColors.red),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Get.toNamed('/note-detail');
        },
      ),
      appBar: buildAppBar(textTheme),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: StreamBuilder(
                stream: controller.firestoreService.getNotes(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: Loader());
                  else if (snapshot.hasError)
                    return Center(child: Text(snapshot.error.toString()));
                  final List<DocumentSnapshot> documents = snapshot.data.docs;
                  controller.syncImages(documents);
                  if (documents.length == 0) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NothingHere(size: 120),
                        SizedBox(height: 16),
                        Text("No notes found"),
                        SizedBox(height: 100),
                      ],
                    ));
                  }
                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    controller: cont,
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      var note = Note.fromJson(documents[index].data());
                      return InkWell(
                        onTap: () {
                          Get.toNamed('/note-detail', arguments: note);
                        },
                        child: Hero(
                          tag: note.id,
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                !(["", null].contains(note.image))
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          topLeft: Radius.circular(8),
                                        ),
                                        child: ImageWidget(uri: note.image))
                                    : Container(),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      !(["", null].contains(note.title))
                                          ? Text(note.title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: textTheme.headline6)
                                          : Container(),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      !(["", null].contains(note.description))
                                          ? Text(
                                              note.description,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.fit(2),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ScrollAppBar buildAppBar(TextTheme textTheme) {
    return ScrollAppBar(
      controller: cont,
      automaticallyImplyLeading: false,
      title: InkWell(
        radius: 12,
        onTap: () {},
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisSize: MainAxisSize.max, children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.search,
                      size: 20,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "searchNotes".tr,
                      style: textTheme.headline6.copyWith(
                          color: textTheme.caption.color,
                          fontSize: textTheme.bodyText1.fontSize),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _scaffoldKey.currentState.openDrawer();
                },
                child: CircleAvatar(
                  child: controller.photoURL != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.network(
                            controller.photoURL,
                            fit: BoxFit.contain,
                          ),
                        )
                      : Text(
                          controller.displayName.substring(0, 1).capitalize,
                          maxLines: 1,
                        ),
                  maxRadius: 14,
                ),
              ),
              SizedBox(
                width: 4,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
