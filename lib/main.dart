import 'dart:ui';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joker_t/jokes/logic/jokes_provider.dart';
import 'package:joker_t/utils/loader.dart';

final List<String> types = ['single', 'twopart'];
const double depth = 5;

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NeumorphicApp(
      title: 'Joker',
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        depth: depth,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: ScrollConfiguration(
          behavior: MyCustomScrollBehavior(),
          child: Row(
            children: [
              SizedBox(
                width: 50,
                child: Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  ),
                  child: Consumer(
                    builder: (context, ref, child) {
                      ref.watch(currentCategoryProvider);
                      return ref.watch(categoriesProvider).map(
                          initial: (_) => const RotatedBox(
                              quarterTurns: -1, child: Center(child: Loader())),
                          loading: (_) => const RotatedBox(
                              quarterTurns: -1, child: Center(child: Loader())),
                          loaded: (_) => Center(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  reverse: true,
                                  itemCount: _.data.categories.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RotatedBox(
                                        quarterTurns: -1,
                                        child: NeumorphicButton(
                                          onPressed: () {
                                            ref
                                                    .watch(
                                                        currentCategoryProvider
                                                            .notifier)
                                                    .stateValue =
                                                _.data.categories[index];
                                          },
                                          style: NeumorphicStyle(
                                            depth: ref
                                                        .watch(
                                                            currentCategoryProvider
                                                                .notifier)
                                                        .stateValue ==
                                                    _.data.categories[index]
                                                ? -depth
                                                : depth,
                                          ),
                                          child: NeumorphicText(
                                            _.data.categories[index],
                                            style: const NeumorphicStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                          error: (_) => RotatedBox(
                              quarterTurns: -1,
                              child: getErrorWidget(_.error)));
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 50,
                child: Consumer(builder: (context, ref, child) {
                  ref.watch(currentTypeProvider);
                  return Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12)),
                      ),
                      child: Center(
                        child: ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: ref.watch(typesProvider).length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RotatedBox(
                                quarterTurns: -1,
                                child: NeumorphicButton(
                                  onPressed: () {
                                    ref
                                            .watch(currentTypeProvider.notifier)
                                            .stateValue =
                                        ref.watch(typesProvider)[index];
                                  },
                                  style: NeumorphicStyle(
                                      depth: ref
                                                  .watch(currentTypeProvider
                                                      .notifier)
                                                  .stateValue ==
                                              ref.watch(typesProvider)[index]
                                          ? -depth
                                          : depth),
                                  child: NeumorphicText(
                                    ref
                                        .watch(typesProvider)[index]
                                        .capitalize(),
                                    style: const NeumorphicStyle(
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ));
                }),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(child: Consumer(
                builder: (context, ref, child) {
                  ref.watch(jokesProvider);
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ref.watch(jokesProvider).map(
                              initial: (_) => const Center(child: Loader()),
                              loading: (_) => const Center(child: Loader()),
                              error: (_) => getErrorWidget(_.error),
                              loaded: (_) {
                                if (_.data.type == 'single') {
                                  return Neumorphic(
                                    style: const NeumorphicStyle(depth: depth),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: NeumorphicText(
                                        _.data.joke ?? '',
                                        style: const NeumorphicStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Neumorphic(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: NeumorphicText(
                                            _.data.setup ?? '',
                                            style: const NeumorphicStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Neumorphic(
                                        style: const NeumorphicStyle(
                                            depth: -depth),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: NeumorphicText(
                                            _.data.delivery ?? '',
                                            style: const NeumorphicStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                }
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          NeumorphicButton(
                            onPressed: () {
                              ref.refresh(jokesProvider);
                            },
                            child: NeumorphicText('Get A New Joke',
                                style:
                                    const NeumorphicStyle(color: Colors.black)),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
