import 'package:flutter/material.dart';
import 'package:setgame/model/model.dart';
import 'package:setgame/view/card_widget.dart';
import 'package:setgame/view_model/view_model.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  final viewModel = ViewModel();

  @override
  void initState() {
    viewModel.addData();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SetGames'),
      ),
      body: StreamBuilder(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            // print(snapshot.data);
            return _listCard(snapshot.data);
          }),
    );
  }

  Widget _listCard(List<GamesCard>? cards) {
    return cards == null
        ? Container()
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.71,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            padding: const EdgeInsets.all(5),
            itemCount: 12,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  viewModel.isTap(cards[index]);
                  print(cards[index]);
                },
                child: CardsWidget(
                  cards[index].color,
                  cards[index].shape,
                  cards[index].amount,
                  cards[index].shading,
                  cards[index].selected,
                ),
              );
            });
  }
}
