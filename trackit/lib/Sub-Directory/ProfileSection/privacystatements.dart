import 'package:flutter/material.dart';

class TermsndCoditions extends StatefulWidget {
  const TermsndCoditions({super.key});

  @override
  State<TermsndCoditions> createState() => _TermsndCoditionsState();
}

class _TermsndCoditionsState extends State<TermsndCoditions> {

  bool terms = false;

  void _acceptterms(dynamic value){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.deepPurple,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 60),
            child: Center(
              child: Text(
                'Terms and Coditions',
                textAlign: TextAlign.center,
                style: TextStyle(
                  // fontFamily: 'Nunito',
                  fontFamily: 'Lilita_one',
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).appBarTheme.foregroundColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: IconButton(
                icon: Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: Theme.of(context).colorScheme.inversePrimary,
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        // color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(55.0),
                          topRight: Radius.circular(55.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Expanded(
                              child: ListView(
                                children: [
                                  SizedBox(height: 10),
                                  Center(
                                    child: Text(
                                      ' Read the following Carefully:',
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: Theme.of(context).textTheme.bodyLarge!.color,
                                          fontFamily: 'Lilita_one'
                                      ),
                                    ),
                                  ),
                                  SecurityOption(
                                    title: 'Terms and Conditions apply as follows:',
                                    text:
                                    "        Est fugiat assumenda aut reprehenderit Lorem ipsum"
                                        " dolor sit amet. Et odio officia aut voluptate internos "
                                        "estomnis vitae ut architecto sunt non tenetur fuga ut"
                                        // " provident vero. Quoaspernatur facere et consectetur ipsum "
                                        // "et facere corrupti est asperioresfacere. Est fugiat assumenda "
                                        "aut reprehenderit voluptatem sed.Ea voluptates omnis aut sequi"
                                        " sequi.Est dolore quae in aliquid ducimus et autem repellendus.Aut"
                                        " ipsum Quis qui porro quasi aut minus placeat!Sit consequatur neque"
                                        " ab vitae facere.\n"
                                        "      Aut quidem accusantium nam alias autem eum officiis"
                                        " placeat et omnis autemid officiis perspiciatis qui corrupti officia"
                                        " eum aliquam provident. Eumvoluptas error et optio dolorum cum molestiae"
                                        " nobis et odit molestiae quomagnam impedit sed fugiat nihil non nihil"
                                        " vitae.Aut fuga sequi eum voluptatibus provident.\n"
                                        "      Eos consequuntur voluptas"
                                        " vel amet eaque aut dignissimos velit.Vel exercitationem quam vel eligendi"
                                        " rerum At harum obcaecati et nostrum beatae?Ea accusantium dolores qui"
                                        " rerum aliquam est perferendis mollitia et ipsum ipsaqui enim autem At"
                                        " corporis sunt. Aut odit quisquam est reprehenderit itaque autaccusantium"
                                        " dolor qui neque repellat.\n"
                                        "\n"
                                        "    Read the terms and conditions in more detail at"
                                        "    www.trackitapp.com",

                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        fillColor: const WidgetStatePropertyAll<Color>(Colors.deepPurple),
                                        value: (false),
                                        onChanged: (value) {

                                        },
                                      ),
                                      const Text(
                                        'I accept all the terms and conditions',
                                        style: TextStyle(
                                          // color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(32),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                      ),
                                      onPressed: () {},
                                      child: Text('Accept',
                                        style: TextStyle(color: Theme.of(context).buttonTheme.colorScheme?.primary),
                                      ),
                                    ),
                                  ),
                                ],
                                controller: ScrollController(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class SecurityOption extends StatelessWidget {
  final String title;
  final String text;


  SecurityOption({required this.title,  required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),),
      subtitle: Text(text, style: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),),
    );
  }
}
