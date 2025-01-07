abstract class PropertyEvent {}


class FetchProperties extends PropertyEvent {}

class SearchProperties extends PropertyEvent {
    final String query;
    SearchProperties({required this.query});
}