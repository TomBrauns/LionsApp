import 'package:lionsapp/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('Increment Counter?', (){
    final counter = Counter();

    counter.increment();

    expect(counter.value, 5);
  });
}