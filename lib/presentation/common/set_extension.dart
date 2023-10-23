extension SetExtensions<T> on Set<T> {
  void toggleItemInSet(T item) {
    if (contains(item)) {
      remove(item);
    } else {
      add(item);
    }
  }
}
