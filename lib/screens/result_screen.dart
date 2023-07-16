import 'package:flutter/material.dart';
import 'package:hang_man/extensions/context_extension.dart';
import 'package:hang_man/provider/local_storage_provider.dart';
import 'package:provider/provider.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Score Table",
              style: context.textTheme.titleLarge,
            ),
            const Divider(),
            FutureBuilder(
              future: Provider.of<LocalStorage>(context).getScore(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data["score"].length > 0) {
                    final data = snapshot.data;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: data["score"].length,
                        itemBuilder: (context, index) {
                          final String score = data["score"][index];
                          final String date = data["date"][index];

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Card(
                              child: ListTile(
                                title: Text(
                                  date,
                                  style: context.textTheme.labelLarge,
                                ),
                                trailing: Text(
                                  score,
                                  style: context.textTheme.labelLarge,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Expanded(
                      child: Center(
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("You don't have any score right now."),
                          ),
                        ),
                      ),
                    );
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: context.theme.elevatedButtonTheme.style!.copyWith(
                fixedSize: MaterialStatePropertyAll(
                  Size(context.width * 0.8, 50),
                ),
              ),
              child: const Text("Home Page"),
            )
          ],
        ),
      ),
    );
  }
}

// Text(Provider.of<WordProvider>(context).score.toString())