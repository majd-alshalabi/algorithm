import 'dart:core';

class PriorityQueue<E> {
  final _queue = <E>[];
  Comparator<E> comparator;

  PriorityQueue(this.comparator);

  void enQueue(E value) {
    _queue.add(value);
    sort();
  }

  E? deQueue() => (isEmpty) ? null : _queue.removeAt(0);
  E? get peek => (isEmpty) ? null : _queue.first;

  bool get isEmpty => _queue.isEmpty;
  bool get isNotEmpty => _queue.isNotEmpty;

  int get length => _queue.length;
  void clear() => _queue.clear();

  void sort() => _queue.sort(comparator);
  @override
  String toString() => _queue.toString();
}

/*
* Queue :
* import 'dart:collection';
* Queue<E> queue = new Queue<E>();
*
* https://www.geeksforgeeks.org/queues-in-dart/
* */
