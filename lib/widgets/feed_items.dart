import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_grocer/inner_screens/product_details.dart';
import 'package:go_grocer/services/global_methods.dart';
import 'package:go_grocer/widgets/price_widget.dart';
import 'package:go_grocer/widgets/text_widgets.dart';
import '../services/utils.dart';
import 'heart_btn.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({super.key});

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = '1'; //${widget.quantity}
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            GlobalMethods.nevigateTo(
                ctx: context, routeName: ProductDetails.routeName);
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(children: [
            FancyShimmerImage(
              imageUrl:
                  'https://w7.pngwing.com/pngs/29/515/png-transparent-plum-fruits-apricot-apricots-natural-foods-food-fruit-thumbnail.png',
              height: size.width * 0.20,
              width: size.width * 0.2,
              boxFit: BoxFit.fill,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: TextWidget(
                      text: 'Title',
                      color: color,
                      maxLines: 1,
                      textSize: 18,
                      isTitle: true,
                    ),
                  ),
                  const Flexible(flex: 1, child: HeartBTN()),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: PriceWidget(
                    salePrice: 80,
                    price: 100,
                    textPrice: _quantityTextController.text,
                    isOnSale: true,
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                Flexible(
                  child: Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: FittedBox(
                          child: TextWidget(
                            text: 'KG',
                            color: color,
                            textSize: 20,
                            isTitle: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 3,
                        child: TextField(
                          controller: _quantityTextController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: color, fontSize: 18, ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          onChanged: (v) {
                            setState(() {
                              if (v.isEmpty) {
                                _quantityTextController.text = '1';
                              } else {
                                return;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            //const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Theme.of(context).cardColor),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                      ),
                    )),
                child: TextWidget(
                  text: 'Add to cart',
                  maxLines: 1,
                  color: color,
                  textSize: 20,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
