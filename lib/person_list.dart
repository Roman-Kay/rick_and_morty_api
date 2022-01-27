import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/person_info.dart';
import 'dart:ui';

class Person {
  final int id;
  final String name;
  final String status;
  final String species;
  final String origin;
  final String location;
  final String image;
  Person({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.origin,
    required this.location,
    required this.image,
  });
}

class PersonList extends StatefulWidget {
  PersonList({Key? key}) : super(key: key);

  @override
  State<PersonList> createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  final _person = [
    Person(
      id: 73,
      name: 'Cop Morty',
      status: 'Dead',
      species: 'Human',
      origin: 'Citadel of Ricks',
      location: 'The Ricklantis Mixup',
      image: "https://rickandmortyapi.com/api/character/avatar/73.jpeg",
    ),
    Person(
      id: 385,
      name: 'Yellow Shirt Rick',
      status: 'Unknown',
      species: 'Human',
      origin: 'Citadel of Ricks',
      location: 'The Rickshank Rickdemption',
      image: "https://rickandmortyapi.com/api/character/avatar/385.jpeg",
    ),
    Person(
      id: 316,
      name: 'Shmlona Shmlobinson',
      status: 'Alive',
      species: 'Human',
      origin: 'Interdimensional Cable',
      location: 'Rixty Minutes',
      image: "https://rickandmortyapi.com/api/character/avatar/316.jpeg",
    ),
  ];
  var _filteredPerson = <Person>[];

  final _searchController = TextEditingController();

  void _searchPerson() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _filteredPerson = _person.where((Person person) {
        return person.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filteredPerson = _person;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _searchPerson();

    _searchController.addListener(_searchPerson);
  }

  void _onPersonTap(int index) {
    final id = _person[index].id;
    Navigator.of(context).pushNamed(
      '/info',
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey.shade400,
          title: const Text(
            'The Rick and Morty API',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          )),
      body: ListView.builder(
          padding: EdgeInsets.only(top: 10),
          itemCount: _filteredPerson.length,
          itemExtent: 150,
          itemBuilder: (BuildContext context, int index) {
            final person = _filteredPerson[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Stack(
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade600,
                        border:
                            Border.all(color: Colors.black.withOpacity(0.2)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          )
                        ]),
                    clipBehavior: Clip.hardEdge,
                    child: Row(
                      children: [
                        Image.network(person.image),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 7),
                              Text(
                                person.name,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2),
                              Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                        color: person.status == 'Dead'
                                            ? Colors.redAccent
                                            : person.status == 'Unknown'
                                                ? Colors.grey.shade300
                                                : Color.fromARGB(
                                                    255, 136, 255, 0),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: person.status,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' - ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: person.species,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ]),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 14),
                              Text(
                                'Origin:',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2),
                              Text(
                                person.location,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 7),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => _onPersonTap(index),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
