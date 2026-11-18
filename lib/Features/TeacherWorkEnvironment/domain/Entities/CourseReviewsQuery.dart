// ignore_for_file: file_names

class CourseReviewsQuery {
  const CourseReviewsQuery._({this.star, this.lowestFirst = false});

  static const CourseReviewsQuery newest = CourseReviewsQuery._();
  static const CourseReviewsQuery lowestRated = CourseReviewsQuery._(
    lowestFirst: true,
  );

  factory CourseReviewsQuery.stars(int star) {
    if (star < 1 || star > 5) {
      throw RangeError.range(star, 1, 5, 'star');
    }
    return CourseReviewsQuery._(star: star);
  }

  final int? star;
  final bool lowestFirst;

  bool get isNewest => star == null && !lowestFirst;

  String get cacheKey {
    final star = this.star;
    if (star != null) return 'star-$star';
    return lowestFirst ? 'lowest' : 'newest';
  }

  @override
  bool operator ==(Object other) =>
      other is CourseReviewsQuery &&
      other.star == star &&
      other.lowestFirst == lowestFirst;

  @override
  int get hashCode => Object.hash(star, lowestFirst);
}
