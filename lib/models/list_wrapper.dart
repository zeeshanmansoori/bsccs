class ListWrapper<T>{
  final String subjectId;
  final String subjectName;
  final List<T> items;

  const ListWrapper({
    required this.subjectId,
    required this.subjectName,
    required this.items,
  });
}