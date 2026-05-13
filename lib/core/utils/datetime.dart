import 'package:flock_pilot/features/dashboard/presentation/widgets/greeting.dart';

Greeting getGreeting() {
  final hour = DateTime.now().hour;

  if (hour < 12) {
    return Greeting(greetingText: 'Good Morning ⛅');
  } else if (hour < 17) {
    return Greeting(greetingText: 'Good Afternoon ☀️');
  } else {
    return Greeting(greetingText: 'Good Evening 🌑');
  }
}
