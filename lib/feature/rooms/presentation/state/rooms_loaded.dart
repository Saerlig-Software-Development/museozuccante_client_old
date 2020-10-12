import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/presentation/no_glow_behavior.dart';
import 'package:museo_zuccante/feature/rooms/domain/model/room_domain_model.dart';

class RoomsLoaded extends StatelessWidget {
  final List<RoomDomainModel> rooms;

  const RoomsLoaded({
    Key key,
    @required this.rooms,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int pages = rooms.length ~/ 2;

    final remainder = rooms.length % 2;

    if (remainder > 0 && remainder <= 2) {
      pages += 1;
    } else if (remainder >= 2) {
      pages += 2;
    }

    return Padding(
      padding: pages == 1 ? const EdgeInsets.all(8.0) : EdgeInsets.zero,
      child: ScrollConfiguration(
        behavior: NoGlowBehavior(),
        child: PageView.builder(
          pageSnapping: true,
          controller: PageController(
            viewportFraction: pages == 1 ? 1.0 : 0.5,
            initialPage: 1,
          ),
          itemCount: pages,
          itemBuilder: (context, index) {
            final items = rooms.take(5).toList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // padding: EdgeInsets.only(left: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      title: Text(item.title),
                      subtitle: Text(
                          'Aula ${item.number}${item.floor >= 1 ? ' - ${item.floor} piano' : ''}'),
                      onTap: () {},
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
