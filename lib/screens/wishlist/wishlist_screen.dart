import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_grocer/screens/wishlist/wishlist_widget.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/text_widgets.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
   // bool _isEmpty = true;
    return
      // _isEmpty
      //   ? const EmptyScreen(
      //       imagepath: "assets/images/wishlist.png",
      //       title: 'Your Wishlist is Empty',
      //       subtitle: 'Explore more and shortlist some items',
      //       buttonText: 'Add a wish',
      //     )
      //   :
      Scaffold(
            appBar: AppBar(
              leading: const BackWidget(),
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              centerTitle: true,
              title: TextWidget(
                text: 'Wishlist (2)',
                color: color,
                textSize: 26,
                isTitle: true,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    GlobalMethods.warningDialog(
                        title: 'Empty your wishlist?',
                        subtitle: 'Are you sure?',
                        fct: () {},
                        context: context);
                  },
                  icon: Icon(
                    IconlyBroken.delete,
                    color: color,
                  ),
                ),
              ],
            ),
            body: MasonryGridView.count(
              crossAxisCount: 2,
              // mainAxisSpacing: 16,
              // crossAxisSpacing: 20,
              itemBuilder: (context, index) {
                return const WishlistWidget();
              },
            ));
  }
}
