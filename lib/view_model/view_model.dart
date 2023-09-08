import 'dart:async';

import 'package:setgame/model/deck.dart';
import 'package:setgame/model/model.dart';

class ViewModel {
  final StreamController<List<GamesCard>> _streamController =
      StreamController();

  Stream<List<GamesCard>> get stream => _streamController.stream;

  final List<GamesCard> cards = deck;

  final List<GamesCard> onSelect = [];

  void addData() {
    cards.shuffle();
    _streamController.sink.add(cards);
  }

  void dispose() {
    _streamController.close();
  }

// กดการ์ด
  void isTap(GamesCard card) {
    final cardTap = onSelect.contains(card);

    if (onSelect.length != 3 && card.selected != true) {
      card.selected = !card.selected;
      onSelect.add(card);
    }
    if (cardTap) {
      card.selected = false;
      onSelect.remove(card);
    }

    cardSet();

    print(onSelect.length);
    _streamController.sink.add(cards);
  }

  cardSet() {
    if (onSelect.length == 3) {
      if (checkColor() == true &&
          checkShape() == true &&
          checkAmount() == true &&
          checkShading() == true) {
        print('Passsss');
      } else {
        print('Faillllll');
        print('Color : ${checkColor()}');
        print('Shape : ${checkShape()}');
        print('Amount : ${checkAmount()}');
        print('Shading : ${checkShading()}');
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
