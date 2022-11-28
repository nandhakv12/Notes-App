import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn/constants/routes.dart';
import 'package:learn/services/auth/auth_services.dart';
import 'package:learn/view/login_view.dart';
import 'package:learn/view/register_view.dart';
import 'package:learn/view/verify_email.dart';

import 'view/notes/create_update_note_view.dart';
import 'view/notes/notes_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        notesRoute: ((context) => const NotesView()),
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        verifyEmailRoute: ((context) => const VerifyEmailView()),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

// @override
// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: AuthServices.firebase().initialize(),
//       builder: (context, snapshot) {
//         switch (snapshot.connectionState) {
//           case ConnectionState.done:
//             final user = AuthServices.firebase().currentUser;
//             if (user != null) {
//               if (user.isEmailVerified) {
//                 return const NotesView();
//               } else {
//                 return const VerifyEmailView();
//               }
//             } else {
//               return const LoginView();
//             }

//           default:
//             return const CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Testing'),
          ),
          body: BlocConsumer<CounterBloc, CounterState>(
            listener: (context, state) {
              _controller.clear();
            },
            builder: (context, state) {
              final invalidValue = (state is CounterStateInvalidNumber)
                  ? state.invalidValue
                  : '';
              return Column(
                children: [
                  Text('current value => ${state.value}'),
                  Visibility(
                    // ignore: sort_child_properties_last
                    child: Text('invalid input :$invalidValue'),
                    visible: state is CounterStateInvalidNumber,
                  ),
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'enter a number',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          context
                              .read<CounterBloc>()
                              .add(DecrementValue(_controller.text));
                        },
                        child: const Text('-'),
                      ),
                      TextButton(
                        onPressed: () {
                          context
                              .read<CounterBloc>()
                              .add(IncrementValue(_controller.text));
                        },
                        child: const Text('+'),
                      )
                    ],
                  )
                ],
              );
            },
          )),
    );
  }
}

@immutable
abstract class CounterState {
  final int value;
  const CounterState(this.value);
}

class CounterStateValid extends CounterState {
  const CounterStateValid(int value) : super(value);
}

class CounterStateInvalidNumber extends CounterState {
  final String invalidValue;
  const CounterStateInvalidNumber({
    required this.invalidValue,
    required int previousValue,
  }) : super(previousValue);
}

@immutable
abstract class CounterEvent {
  final String value;
  const CounterEvent(this.value);
}

class IncrementValue extends CounterEvent {
  const IncrementValue(String value) : super(value);
}

class DecrementValue extends CounterEvent {
  const DecrementValue(String value) : super(value);
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterStateValid(0)) {
    on<IncrementValue>((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(CounterStateInvalidNumber(
          invalidValue: event.value,
          previousValue: state.value,
        ));
      } else {
        emit(CounterStateValid(state.value + integer));
      }
    });
    on<DecrementValue>((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(CounterStateInvalidNumber(
          invalidValue: event.value,
          previousValue: state.value,
        ));
      } else {
        emit(CounterStateValid(state.value - integer));
      }
    });
  }
}
