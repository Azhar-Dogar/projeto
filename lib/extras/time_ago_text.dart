
import 'package:timeago/timeago.dart';

// Override "en" locale messages with custom messages that are more precise and short



// my_custom_messages.dart
class MyCustomMessages implements LookupMessages {
@override String prefixAgo() => '';
@override String prefixFromNow() => '';
@override String suffixAgo() => '';
@override String suffixFromNow() => '';
@override String lessThanOneMinute(int seconds) => 'agora';
@override String aboutAMinute(int minutes) => '${minutes} minuto atrás';
@override String minutes(int minutes) => '${minutes} minuto atrás';
@override String aboutAnHour(int minutes) => '${minutes} minuto atrás';
@override String hours(int hours) => '${hours} hora atrás';
@override String aDay(int hours) => '${hours} hora atrás';
@override String days(int days) => '${days} dias atrás';
@override String aboutAMonth(int days) => '${days} dias atrás';
@override String months(int months) => '${months} mês atrás';
@override String aboutAYear(int year) => '${year} ano atrás';
@override String years(int years) => '${years} ano atrás';
@override String wordSeparator() => ' ';
}