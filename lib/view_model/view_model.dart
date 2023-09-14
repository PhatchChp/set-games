import 'dart:async';

import 'package:setgame/model/deck.dart';
import 'package:setgame/model/model.dart';

class ViewModel {
// Stream Cards
  final StreamController<List<GamesCard>> _streamControllerGameCard =
      StreamController();
  Stream<List<GamesCard>> get stream => _streamControllerGameCard.stream;

// จำนวน set ที่เหลือ
  final StreamController<int> _streamControllerScore = StreamController();
  Stream<int> get streamScore => _streamControllerScore.stream;

  final List<GamesCard> allCards = deck.map((card) => card).toList();

  int score = 0;
  List<GamesCard> onSelect = [];
  List<GamesCard> listStream = [];

  setTotal() {
    int set = allCards.length ~/ 3;
    return set;
  }

// VM Stream

  void addData() {
    allCards.shuffle();

    for (int i = 0; i < 12; i++) {
      listStream.add(allCards[i]);
      allCards.remove(listStream[i]);
    }
    _streamControllerGameCard.sink.add(listStream);
    _streamControllerScore.sink.add(setTotal());
    _streamControllerScore.sink.add(score);

    // print('AllCards : ${allCards.length}');
    // print('ListStream : ${listStream.length}');
  }

  void dispose() {
    _streamControllerGameCard.close();
  }

// เพิ่มการ์ด 3 ใบ
  void addCard() {
    allCards.shuffle();
    for (int i = 0; i < 3; i++) {
      listStream.add(allCards.removeAt(i));
    }
    _streamControllerGameCard.sink.add(listStream);
    print('AllCards : ${allCards.length}');
    print('ListStream : ${listStream.length}');
  }

// กดการ์ด
  void isTap(GamesCard card) {
    // เช็คว่าการ์ดที่กด ใช่การ์ดใบเดิมมั้ย
    final sameCard = onSelect.contains(card);
    // ถ้าเลือกการ์ดยังไม่ครบ 3 ใบ และการ์ดนั้นยังไม่ถูกเลือก ให้เลือกการ์ดได้
    if (onSelect.length != 3 && card.selected != true) {
      card.selected = !card.selected;
      onSelect.add(card);
    }

    // ถ้ากดการ์ดใบเดิมแล้วซ้ำให้มันไม่ถูกเลือก
    if (sameCard) {
      card.selected = false;
      onSelect.remove(card);
    }

    // ถ้าการ์ดทั้ง 3 ใบเป็น set เอาการ์ดทั้งหมดออก + 1 คะแนน
    if (cardSet() == true) {
      for (GamesCard card in onSelect) {
        listStream.remove(card);
      }
      score += 1;
      onSelect = [];
      addCard();
    }

    print('Onselect : ${onSelect.length}');
    print('AllCards : ${allCards.length}');
    print('ListStream : ${listStream.length}');

    // _streamControllerTotalSet.sink.add(allcards.length ~/ 3);
    _streamControllerGameCard.sink.add(listStream);
    _streamControllerScore.sink.add(score);
  }

// การ์ดทั้ง 3 ใบ ผ่านกติกาเซ็ท
  cardSet() {
    if (onSelect.length == 3) {
      if (checkColor() == true &&
          checkShape() == true &&
          checkAmount() == true &&
          checkShading() == true) {
        print('Passsssss');
        return true;
      } else {
        print('Faillllll');
        print('Color : ${checkColor()}');
        print('Shape : ${checkShape()}');
        print('Amount : ${checkAmount()}');
        print('Shading : ${checkShading()}');
        return false;
      }
    }
  }

// เช็คสี
  checkColor() {
    if (onSelect[0].color == onSelect[1].color &&
        onSelect[1].color == onSelect[2].color) {
      return true;
    } else if (onSelect[0].color != onSelect[1].color &&
        onSelect[1].color != onSelect[2].color &&
        onSelect[2].color != onSelect[0].color) {
      return true;
    } else {
      return false;
    }
  }

// เช็ครูปทรง
  checkShape() {
    if (onSelect[0].shape == onSelect[1].shape &&
        onSelect[1].shape == onSelect[2].shape) {
      return true;
    } else if (onSelect[0].shape != onSelect[1].shape &&
        onSelect[1].shape != onSelect[2].shape &&
        onSelect[2].shape != onSelect[0].shape) {
      return true;
    } else {
      return false;
    }
  }

  // เช็คจำนวน
  checkAmount() {
    if (onSelect[0].amount == onSelect[1].amount &&
        onSelect[1].amount == onSelect[2].amount) {
      return true;
    } else if (onSelect[0].amount != onSelect[1].amount &&
        onSelect[1].amount != onSelect[2].amount &&
        onSelect[2].amount != onSelect[0].amount) {
      return true;
    } else {
      return false;
    }
  }

  // เช็คเฉดสี
  checkShading() {
    if (onSelect[0].shading == onSelect[1].shading &&
        onSelect[1].shading == onSelect[2].shading) {
      return true;
    } else if (onSelect[0].shading != onSelect[1].shading &&
        onSelect[1].shading != onSelect[2].shading &&
        onSelect[2].shading != onSelect[0].shading) {
      return true;
    } else {
      return false;
    }
  }
}
