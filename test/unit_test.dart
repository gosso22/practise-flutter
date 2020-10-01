import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/services/auth.dart';

class MockUser extends Mock implements User {}

final MockUser _mockUser = MockUser();

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User> authStateChanges() {
    return Stream.fromIterable([
      _mockUser,
    ]);
  }
}

void main() {
  final MockFirebaseAuth mockAuth = MockFirebaseAuth();
  final Auth auth = Auth(auth: mockAuth);
  setUp(() {});
  tearDown(() {});

  test("emit occurs", () async {
    expectLater(auth.user, emitsInOrder([_mockUser]));
  });

  test("create account", () async {
    when(
      mockAuth.createUserWithEmailAndPassword(
          email: "kc@gmail.com", password: "123456"),
    ).thenAnswer((realInvocation) => null);

    expect(await auth.createAccount(email: "kc@gmail.com", password: "123456"),
        "Success");
  });

  test("create account exception", () async {
    when(
      mockAuth.createUserWithEmailAndPassword(
          email: "kc@gmail.com", password: "123456"),
    ).thenAnswer((realInvocation) =>
        throw FirebaseAuthException(message: "You screwed up"));

    expect(await auth.createAccount(email: "kc@gmail.com", password: "123456"),
        "You screwed up");
  });

  test("Sign In", () async {
    when(
      mockAuth.signInWithEmailAndPassword(
          email: "kc@gmail.com", password: "123456"),
    ).thenAnswer((realInvocation) => null);

    expect(await auth.signIn(email: "kc@gmail.com", password: "123456"),
        "Success");
  });

  test("Sign In exception", () async {
    when(
      mockAuth.signInWithEmailAndPassword(
          email: "kc@gmail.com", password: "123456"),
    ).thenAnswer((realInvocation) =>
        throw FirebaseAuthException(message: "You screwed up"));

    expect(await auth.signIn(email: "kc@gmail.com", password: "123456"),
        "You screwed up");
  });

  test("Sign Out", () async {
    when(
      mockAuth.signOut(),
    ).thenAnswer((realInvocation) => null);

    expect(await auth.signOut(), "Success");
  });

  test("Sign Out exception", () async {
    when(
      mockAuth.signOut(),
    ).thenAnswer((realInvocation) =>
        throw FirebaseAuthException(message: "You screwed up"));

    expect(await auth.signOut(), "You screwed up");
  });
}
