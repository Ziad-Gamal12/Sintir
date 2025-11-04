class CourseFilterEntity {
  // 💰 Price filters
  bool? showFreeCourses;
  bool? showPaidCourses;
  double? minPrice;
  double? maxPrice;
//
  String? educaionLevel;
  String? subject;

  // 👥 Subscription filters
  bool? showSubscribedCourses;
  bool? showUnsubscribedCourses;

  // 🔽 Sorting preferences
  bool? sortByHighestPrice;
  bool? sortByLowestPrice;
  bool? sortByPopularity;
  bool? sortByNewest;

  CourseFilterEntity({
    this.showFreeCourses = false,
    this.showPaidCourses = false,
    this.minPrice,
    this.maxPrice,
    this.showSubscribedCourses = false,
    this.showUnsubscribedCourses = false,
    this.sortByHighestPrice = false,
    this.sortByLowestPrice = false,
    this.sortByPopularity = false,
    this.sortByNewest = false,
  });
}
