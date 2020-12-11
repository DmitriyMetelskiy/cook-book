import 'package:cook_book/ui/widgets/settings_button.dart';
import 'package:flutter/material.dart';
import 'package:cook_book/model/recipe.dart';
import 'package:cook_book/utils/store.dart';
import 'package:cook_book/ui/widgets/recipe_card.dart';
import 'package:cook_book/model/state.dart';
import 'package:cook_book/state_widget.dart';
import 'package:cook_book/ui/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  StateModel appState;

  DefaultTabController _buildTabView({Widget body}) {
    const double _iconSize = 20.0;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            elevation: 2.0,
            bottom: TabBar(
              labelColor: Theme.of(context).indicatorColor,
              tabs: [
                Tab(icon: Icon(Icons.restaurant, size: _iconSize)),
                Tab(icon: Icon(Icons.local_drink, size: _iconSize)),
                Tab(icon: Icon(Icons.favorite, size: _iconSize)),
                Tab(icon: Icon(Icons.settings, size: _iconSize)),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(5.0),
          child: body,
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (appState.isLoading) {
      return _buildTabView(
        body: _buildLoadingIndicator(),
      );
    } else if (!appState.isLoading && appState.user == null) {
      return new LoginScreen();
    } else {
      return _buildTabView(
        body: _buildTabsContent(),
      );
    }
  }

  Column _buildSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SettingsButton(Icons.exit_to_app, "Log out", appState.user.displayName, () async {
            await StateWidget.of(context).signOutOfGoogle();
          },
        ),
      ],
    );
  }

  Center _buildLoadingIndicator() {
    return Center(
      child: new CircularProgressIndicator(),
    );
  }

  void _handleFavoritesListChanged(String recipeID) {
    updateFavorites(appState.user.uid, recipeID).then((result) {
      if (result == true) {
        setState(() {
          if (!appState.favorites.contains(recipeID))
            appState.favorites.add(recipeID);
          else
            appState.favorites.remove(recipeID);
        });
      }
    });
  }

  TabBarView _buildTabsContent() {
    Padding _buildRecipes({RecipeType recipeType, List<String> ids}) {
      CollectionReference collectionReference = FirebaseFirestore.instance.collection('recipes');
      Stream<QuerySnapshot> stream;
      if (recipeType != null) {
        stream = collectionReference.where("type", isEqualTo: recipeType.index).snapshots();
      } else {
        stream = collectionReference.snapshots();
      }

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: new StreamBuilder(
                stream: stream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return _buildLoadingIndicator();
                  return new ListView(
                    children: snapshot.data.docs
                        .where((d) => ids == null || ids.contains(d.id))
                        .map((document) {
                      return new RecipeCard(
                        recipe:
                        Recipe.fromMap(document.data(), document.id),
                        inFavorites: appState.favorites.contains(document.id),
                        onFavoriteButtonPressed: _handleFavoritesListChanged,
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return TabBarView(
      children: [
        _buildRecipes(recipeType: RecipeType.food),
        _buildRecipes(recipeType: RecipeType.drink),
        _buildRecipes(ids: appState.favorites),
        _buildSettings(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    return _buildContent();
  }
}