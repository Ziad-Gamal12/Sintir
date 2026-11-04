import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/helper/GetUserData.dart';

void main() {
  test('empty local user data returns the empty user sentinel', () {
    final user = userEntityFromLocalJson({});
    expect(user.uid, 'empty');
    expect(user.role, 'empty');
  });
}
