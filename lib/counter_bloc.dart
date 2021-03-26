import 'dart:async';

enum CounterAction { Increment, Decrement, Reset }

class CounterBloc {
  int counter;
  final _stateStreamController = StreamController<int>(); // Pipe ka naam hai

  // Pipe ka property hai:
  // upar wale pipe ka hum sink property define kar rahe hai for input
  StreamSink<int> get counterSink => _stateStreamController.sink;
  // upar wale pipe ka hum stream property define kar rahe hai for output
  Stream<int> get counterStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<CounterAction>();
  StreamSink<CounterAction> get eventSink => _eventStreamController.sink;
  Stream<CounterAction> get eventStream => _eventStreamController.stream;

  CounterBloc() {
    counter = 0;
    // We gonna keep listenig change in the eventStream

    eventStream.listen((event) {
      if (event == CounterAction.Increment) {
        counter++;
      } else if (event == CounterAction.Decrement) {
        counter--;
      } else if (event == CounterAction.Reset) {
        counter = 0;
      }
      // Passing the information from one pipe to the other pipe
      counterSink.add(counter);
    });
  }
}
// State management with BLOC pattern as State Build is called once.
// eventStream and stateSink is not exposed to the user. Benifits of BLoc pattern
//Users cannot interact with the above said stream and sinks
