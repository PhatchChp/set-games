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
        leading: Center(child: Text('Set ${viewModel.setTotal()}')),
        actions: [
          StreamBuilder(
              stream: viewModel.streamScore,
              builder: (context, snapshot) {
                return Center(child: Text('Score ${snapshot.data}'));
              }),
        ],
      ),
      body: StreamBuilder(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            // print(snapshot.data);
            return _listCard(snapshot.data);
          }),
      bottomNavigationBar: bottomNav(),
    );
  }

  Widget _listCard(List<GamesCard>? cards) {
    return cards == null
        ? Container()
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.76,
                crossAxisSpacing: 9,
                mainAxisSpacing: 9),
            padding: const EdgeInsets.all(9),
            itemCount: viewModel.listStream.length,
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

  Widget bottomNav() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromARGB(255, 243, 243, 243),
      ),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
              onPressed: () {
                viewModel.addCard();
              },
              icon: const Icon(Icons.add, size: 20),
              label: const Text('Card', style: TextStyle(fontSize: 18)))
        ],
      ),
    );
  }
}
