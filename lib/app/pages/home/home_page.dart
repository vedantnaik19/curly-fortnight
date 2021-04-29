import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import '../../../app/data/models/note.dart';
import '../../../app/pages/home/widgets/add_note_button.dart';
import '../../../app/pages/home/widgets/home_drawer.dart';
import '../../../app/shared/widgets/loader.dart';
import '../../../app/shared/widgets/no_notes.dart';
import '../../../app/shared/widgets/note_item.dart';
import './home_controller.dart';

class HomePage extends GetView<HomeController> {
  final _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      drawer: HomeDrawer(),
      floatingActionButton: AddNoteButton(),
      appBar: buildScrollAppBar(textTheme),
      body: buildBody(),
    );
  }

  SafeArea buildBody() {
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: StreamBuilder(
              stream: controller.notesStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: Loader());
                else if (snapshot.hasError)
                  return Center(child: Text(snapshot.error.toString()));
                final List<DocumentSnapshot> documents = snapshot.data.docs;

                if (documents.length == 0) {
                  return NoNotes();
                }
                return buildStaggeredGridView(documents);
              },
            ),
          ),
        ],
      ),
    );
  }

  ScrollAppBar buildScrollAppBar(TextTheme textTheme) {
    return ScrollAppBar(
      controller: _scrollController,
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

  StaggeredGridView buildStaggeredGridView(List<DocumentSnapshot> documents) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      controller: _scrollController,
      itemCount: documents.length,
      itemBuilder: (BuildContext context, int index) {
        var note = Note.fromJson(documents[index].data());
        return InkWell(
            onTap: () {
              Get.toNamed('/note-detail', arguments: note);
            },
            child: NoteItem(
              key: Key(note.id),
              note: note,
            ));
      },
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
    );
  }
}
