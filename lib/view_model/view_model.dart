import 'dart:async';

import 'package:flutter/material.dart';
import 'package:setgame/model/deck.dart';
import 'package:setgame/model/model.dart';
import 'package:setgame/view/view_screen.dart';

class ViewModel {
  late BuildContext context;

// Stream Cards
  final StreamController<List<GamesCard>> _streamControllerGameCard =
      StreamController();
  Stream<List<GamesCard>> get stream => _streamControllerGameCard.stream;

// จำนวน score
  final StreamController<int> _streamControllerScore = StreamController();
  Stream<int> get streamScore => _streamControllerScore.stream;

// จำนวน set ที่เหลือ
  final StreamController<int> _streamControllerSet = StreamController();
  Stream<int> get streamSet => _streamControllerSet.stream;

// ขอโอกาสใบ้ set 3 ครั้ง
  final StreamController<int> _streamControllerFoundSet = StreamController();
  Stream<int> get streamFoundSet => _streamControllerFoundSet.stream;

  List<GamesCard> allCards = deck.map((card) => card).toList();
  int score = 0;
  int countSet = 0;
  int foundSet = 0;
  List<GamesCard> onSelect = [];
  List<GamesCard> listStream = [];
  bool show = false;
  bool waitDelay = false;

  showSet() {
    int r = 3;
    show = true;
    foundSet++;

    if (foundSet > 3) {
      foundSet = 3;
      return;
    }

    if (foundSet <= 3) {
      for (List<GamesCard> combination in combinations(listStream, r)) {
        if (isCardSet(combination[0], combination[1], combination[2]) == true) {
          if (show = true) {
            combination[0].show = true;
            combination[1].show = true;
            combination[2].show = true;
          }
          break;
        }
      }
    }
    _streamControllerGameCard.sink.add(listStream);
    _streamControllerScore.sink.add(score);
    _streamControllerSet.sink.add(countSet);
    _streamControllerFoundSet.sink.add(foundSet);
  }

  checkSet(BuildContext context) {
    int r = 3;
    bool isSet = false;

    for (List<GamesCard> combination in combinations(listStream, r)) {
      if (isCardSet(combination[0], combination[1], combination[2])) {
        isSet = true;
        break;
      }
    }
    if (isSet == false) {
      addCard(context);
    }
    _streamControllerGameCard.sink.add(listStream);
    _streamControllerScore.sink.add(score);
    _streamControllerSet.sink.add(countSet);
  }

// VM Stream InitState
  void addData() {
    allCards.shuffle();
    for (int i = 0; i <= 11; i++) {
      listStream.add(allCards.removeAt(0));
    }
    _streamControllerGameCard.sink.add(listStream);
    _streamControllerScore.sink.add(score);
    _streamControllerSet.sink.add(countSet);
    _streamControllerFoundSet.sink.add(foundSet);
  }

// stream close
  void dispose() {
    _streamControllerGameCard.close();
    _streamControllerScore.close();
    _streamControllerSet.close();
    _streamControllerFoundSet.close();
  }

// เพิ่มการ์ด 3 ใบ ถ้าการ์ดหมดสำรับให้จบเกมส์ หรือ จนกว่าจะไม่มีการ์ดให้ set ให้จบเกมส์
  void addCard(BuildContext context) {
    allCards.shuffle();

    if (allCards.isNotEmpty) {
      for (int i = 0; i <= 2; i++) {
        listStream.add(allCards.removeAt(0));
      }
    } else {
      endGame(context);
    }
    _streamControllerGameCard.sink.add(listStream);
  }

// จบเกมส์
  void endGame(BuildContext context) {
    if (showSet() != true && allCards.isEmpty) {
      gameOver(context, score);
      score = 0;
      countSet = 0;
      foundSet = 0;
      show = false;

      onSelect.clear();
      listStream.clear();
      allCards.clear();

      allCards = deck.map((card) => card).toList();
      for (GamesCard card in allCards) {
        card.selected = false;
        card.show = false;
      }
      addData();
    }
  }

/*
  arr[] (combination) --> อาร์เรย์อินพุต
  index --> ค่าปัจจุบันใน index [1] 2 3 , [1] 3 4, [2] 4 5, ...
  r คือ ขนาดของชุดค่าที่จะ print 
  cards in board 12 -> cards = 12
  1 set ต้องมี 3 ใบ --> r = 3 ตรวจสอบ 3 ใบว่าเข้าเงื่อนไขป่าว
*/
  combinations(List<GamesCard> cards, int r) {
    List<List<GamesCard>> result = [];

    void generateCombinations(List<GamesCard> combination, int index) {
      if (combination.length == r) {
        result.add(List.from(combination));
        return;
      }

      for (int i = index; i < cards.length; i++) {
        combination.add(cards[i]);
        generateCombinations(combination, i + 1);
        combination.removeLast();
      }
    }

    generateCombinations([], 0);
    return result;
  }

// กดการ์ด
  void isTap(GamesCard card, BuildContext context) {
    // เช็คว่าการ์ดที่กด ใช่การ์ดใบเดิมมั้ย
    final sameCard = onSelect.contains(card);

    if (waitDelay != true) {
      // ถ้าเลือกการ์ดยังไม่ครบ 3 ใบ และการ์ดนั้นยังไม่ถูกเลือก ให้เลือกการ์ดได้
      if (onSelect.length != 3 && card.selected != true && waitDelay != true) {
        card.selected = !card.selected;
        onSelect.add(card);
      }

      // ถ้ากดการ์ดใบเดิมแล้วซ้ำให้มันไม่ถูกเลือก
      if (sameCard && waitDelay != true) {
        card.selected = false;
        onSelect.remove(card);
      }

// ถ้าการ์ดทั้ง 3 ใบเป็น set เอาการ์ดทั้งหมดออกและ + 1 คะแนน
      if (onSelect.length >= 3) {
        waitDelay = true;
        checkSelect(context);
      }

      print('Onselect : ${onSelect.length}');
      print('AllCards : ${allCards.length}');
      print('ListStream : ${listStream.length}');

      _streamControllerGameCard.sink.add(listStream);
      _streamControllerSet.sink.add(countSet);
      _streamControllerScore.sink.add(score);
      _streamControllerFoundSet.sink.add(foundSet);
    }
  }

// เช็คการ์ดที่เลือกทั้ง 3 ใบ
  void checkSelect(BuildContext context) {
    if (isCardSet(onSelect[0], onSelect[1], onSelect[2]) == true) {
      for (GamesCard card in onSelect) {
        listStream.remove(card);
      }
      score += 1;
      countSet += 1;
      onSelect = [];

      addCard(context);
      checkSet(context); // findSet in board

      waitDelay = false;
      _streamControllerGameCard.sink.add(listStream);
    } else {
      Future.delayed(const Duration(milliseconds: 700), () {
        onSelect[0].selected = false;
        onSelect[1].selected = false;
        onSelect[2].selected = false;

        onSelect = [];
        waitDelay = false;
        _streamControllerGameCard.sink.add(listStream);
      });
    }
  }

// เช็คว่า การ์ดทั้ง 3 ใบ ผ่านกติกาเซ็ท
  bool isCardSet(GamesCard card1, GamesCard card2, GamesCard card3) {
    if (isColor(card1, card2, card3) == true &&
        isShape(card1, card2, card3) == true &&
        isAmount(card1, card2, card3) == true &&
        isShading(card1, card2, card3) == true) {
      return true;
    }
    return false;
  }

// เช็ตสี
  bool isColor(GamesCard card1, GamesCard card2, GamesCard card3) {
    if (card1.color == card2.color && card2.color == card3.color) {
      return true;
    } else if (card1.color != card2.color &&
        card2.color != card3.color &&
        card3.color != card1.color) {
      return true;
    }
    return false;
  }

// เช็ครูปทรง
  bool isShape(GamesCard card1, GamesCard card2, GamesCard card3) {
    if (card1.shape == card2.shape && card2.shape == card3.shape) {
      return true;
    } else if (card1.shape != card2.shape &&
        card2.shape != card3.shape &&
        card3.shape != card1.shape) {
      return true;
    }
    return false;
  }

// เช็คจำนวน
  bool isAmount(GamesCard card1, GamesCard card2, GamesCard card3) {
    if (card1.amount == card2.amount && card2.amount == card3.amount) {
      return true;
    } else if (card1.amount != card2.amount &&
        card2.amount != card3.amount &&
        card3.amount != card1.amount) {
      return true;
    }
    return false;
  }

// เช็คเฉดสี
  bool isShading(GamesCard card1, GamesCard card2, GamesCard card3) {
    if (card1.shading == card2.shading && card2.shading == card3.shading) {
      return true;
    } else if (card1.shading != card2.shading &&
        card2.shading != card3.shading &&
        card3.shading != card1.shading) {
      return true;
    }
    return false;
  }
}
