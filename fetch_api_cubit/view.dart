import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block/xcubit/state.dart';
import 'cubit.dart';

void main()  {
  prettyDioLogger();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Api App',
      home: FetchApiScreen(),
    );
  }
}

class FetchApiScreen extends StatelessWidget {
  const FetchApiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Api Data'),
      ),
      body: BlocProvider(
        create: (context) => ApiFetchCubit(),
        child: BlocBuilder<ApiFetchCubit, ApiFetchState>(
          builder: (context, state) {
            switch (state.uiState) {
              case UIState.idle:
                return const Center(child: Text('Idle State'));
              case UIState.inProgress:
                return const Center(child: CircularProgressIndicator());
              case UIState.success:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Success State'),
                      Text(state.apiResponse.toString()),
                    ],
                  ),
                );
              case UIState.genericError:
                return  Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      const Text('Generic Error State'),
                      Text(state.failureMessage ?? ""),
                      ElevatedButton(onPressed: () {
                        context.read<ApiFetchCubit>().fetchData();
                      } , child: const Text('reload'),
                      )
                    ],
                  ),
                );
              case UIState.invalidCredentialsError:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Invalid Credentials Error State'),
                      Text(state.failureMessage ?? ""),
                      ElevatedButton(onPressed: () {
                        context.read<ApiFetchCubit>().fetchData();
                      } , child: const Text('reload'),
                      )

                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}




