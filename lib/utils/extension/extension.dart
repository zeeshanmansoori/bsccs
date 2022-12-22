extension GeneralListExtension<T> on List<T> {
  List<T> except(T value) {
    var temp = copy();
    temp.remove(value);
    return temp;
  }

  List<T> copy() {
    var tempList = <T>[];
    forEach((element) => tempList.add(element));
    return tempList;
  }

  T firstWhereOrFirst(bool Function(T element) where) {
    return firstWhere(where, orElse: () => first);
  }

  T? getOrNull(int index) {
    try {
      return this[index];
    } catch (e) {
      return null;
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    try {
      return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    } catch (e) {
      return "";
    }
  }
}

extension CustomEnum on Enum {
  String toFormattedName({
    bool allCaps = false,
    bool capitalize = false,
    bool autoFormattingEnabled = true,
  }) {
    var result = name.replaceAll("_", " ");
    if (capitalize || autoFormattingEnabled) result = result.capitalize();
    if (allCaps || (autoFormattingEnabled && name.length <= 3)) {
      result = result.toUpperCase();
    }

    return result;
  }
}

extension ObjectExtension on Object {
  T? tryCast<T>() {
    return this is T ? (this as T) : null;
  }
}
