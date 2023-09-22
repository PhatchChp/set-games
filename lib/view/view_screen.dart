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
    // viewModel.checkSet();
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
        leading: Center(
            child: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: StreamBuilder(
            stream: viewModel.streamSet,
            builder: (context, snapshot) {
              return Text(
                'Set ${snapshot.data}',
              );
            },
          ),
        )),
        leadingWidth: 80,
        actions: [
          StreamBuilder(
              stream: viewModel.streamScore,
              builder: (context, snapshot) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 27),
                  child: Text('Score ${snapshot.data}'),
                ));
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
                  cards[index].show,
                ),
              );
            });
  }

  Widget bottomNav() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromARGB(255, 243, 243, 243),
      ),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
              onPressed: () {
                viewModel.showSet();
              },
              icon: const Icon(Icons.zoom_in, size: 20),
              label: const Text('Found', style: TextStyle(fontSize: 18)))
        ],
      ),
    );
  }
}

Future gameOver(BuildContext context, int score) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: const Text('GameOver'),
            content: Text('Your Score: ${score.toString()}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ));
}
