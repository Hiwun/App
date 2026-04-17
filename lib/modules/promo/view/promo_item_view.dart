import 'package:flutter/material.dart';
import 'package:tennisapp/models/model.dart';

class PromoItemView extends StatefulWidget {
  final Promotion promotion;

  const PromoItemView({super.key, required this.promotion});

  @override
  State<PromoItemView> createState() => _PromoItemViewState();
}

class _PromoItemViewState extends State<PromoItemView> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return DraggableScrollableSheet(
                initialChildSize: 0.6,
                minChildSize: 0.6,
                maxChildSize: 0.6,
                expand: false, // Важно: запрещаем расширяться
                builder: (_, controller) {
                  return SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 250,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(22)),
                              child: Image.network(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/800px-Placeholder_view_vector.svg.png',
                                errorBuilder: (context, error, stakeTrace){
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(22))
                                    ),
                                    color: Colors.grey[300],
                                    height: 200,
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.broken_image,
                                      size: 40,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                                fit: BoxFit.fitWidth,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(widget.promotion.description),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: (){
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => BookingVenueView()
                                  // ));
                                },
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(57,194,125, 1)),
                                ),
                                child: Text(
                                  'Забронировать стол',
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(22)),
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/800px-Placeholder_view_vector.svg.png',
                errorBuilder: (context, error, stakeTrace){
                  return Container(
                    color: Colors.grey[300],
                    height: 200,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.broken_image,
                      size: 40,
                      color: Colors.grey,
                    ),
                  );
                },
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 2,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.promotion.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_outlined, size: 15, color: Colors.black,)
                  ],
                ),
                Text(widget.promotion.description),
              ],
            ),
          )
        ],
      ),
    );
  }
}
