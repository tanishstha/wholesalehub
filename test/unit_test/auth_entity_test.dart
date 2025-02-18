import 'package:flutter_test/flutter_test.dart';
import 'package:equatable/equatable.dart';
import 'package:wholesalehub/features/auth/domain/entity/auth_entity.dart';

void main() {
  group('AuthEntity Tests', () {
    const testAuthEntity = AuthEntity(
      userId: '123',
      username: 'testUser',
      fullName: 'Test User',
      email: 'test@example.com',
      password: 'securePass',
      phoneNo: '1234567890',
      image: 'profile.png',
    );

    test('1. AuthEntity should be a subclass of Equatable', () {
      expect(testAuthEntity, isA<Equatable>());
    });

    test('2. AuthEntity should support value equality', () {
      const anotherEntity = AuthEntity(
        userId: '123',
        username: 'testUser',
        fullName: 'Test User',
        email: 'test@example.com',
        password: 'securePass',
        phoneNo: '1234567890',
        image: 'profile.png',
      );

      expect(testAuthEntity, equals(anotherEntity));
    });

    test('3. AuthEntity should not be equal if one field differs', () {
      const differentEntity = AuthEntity(
        userId: '999',
        username: 'testUser',
        fullName: 'Test User',
        email: 'test@example.com',
        password: 'securePass',
        phoneNo: '1234567890',
        image: 'profile.png',
      );

      expect(testAuthEntity, isNot(equals(differentEntity)));
    });

    test('4. copyWith should create a new instance with updated fields', () {
      final modifiedEntity = testAuthEntity.copyWith(username: 'newUser');

      expect(modifiedEntity.username, equals('newUser'));
      expect(modifiedEntity.fullName, equals(testAuthEntity.fullName));
    });

    test('5. copyWith should retain old values if not overridden', () {
      final modifiedEntity = testAuthEntity.copyWith();

      expect(modifiedEntity, equals(testAuthEntity));
    });

    test('6. AuthEntity should allow null userId', () {
      const entityWithNullId = AuthEntity(
        userId: null,
        username: 'testUser',
        fullName: 'Test User',
        email: 'test@example.com',
        password: 'securePass',
        phoneNo: '1234567890',
        image: 'profile.png',
      );

      expect(entityWithNullId.userId, isNull);
    });

    test('7. AuthEntity should allow null image', () {
      const entityWithNullImage = AuthEntity(
        userId: '123',
        username: 'testUser',
        fullName: 'Test User',
        email: 'test@example.com',
        password: 'securePass',
        phoneNo: '1234567890',
        image: null,
      );

      expect(entityWithNullImage.image, isNull);
    });

    test('8. AuthEntity.toString() should return a properly formatted string',
        () {
      final expectedString =
          'AuthEntity(userId: 123, username: testUser, fullName: Test User, email: test@example.com, phoneNo: 1234567890, image: profile.png)';

      expect(testAuthEntity.toString(), equals(expectedString));
    });

    test('9. AuthEntity should ignore password in equality checks', () {
      const entityWithDifferentPassword = AuthEntity(
        userId: '123',
        username: 'testUser',
        fullName: 'Test User',
        email: 'test@example.com',
        password: 'anotherPass',
        phoneNo: '1234567890',
        image: 'profile.png',
      );

      expect(testAuthEntity, equals(entityWithDifferentPassword));
    });

    test('10. AuthEntity should maintain immutability', () {
      final modifiedEntity = testAuthEntity.copyWith(username: 'ImmutableTest');

      expect(modifiedEntity.username, equals('ImmutableTest'));
      expect(testAuthEntity.username,
          equals('testUser')); // Original remains unchanged
    });
  });
}
