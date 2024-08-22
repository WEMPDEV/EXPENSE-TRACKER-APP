import 'package:flutter/material.dart';
import 'WelcomePage.dart';

class Onboarding extends StatefulWidget {
   Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  late PageController  _pageController;

  int _pageIndex = 0;

  @override
  void initState(){
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).viewPadding;
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: PageView.builder(
              controller: _pageController,
              itemCount: Board_data.length,
              onPageChanged: (index){
                setState(() {
                  _pageIndex = index;
                });
              },
              itemBuilder: (context, index, ) =>
                  OnboardingScreenContent(
                    image: Board_data[index].image,
                    tittle: Board_data[index].tittle,
                    description: Board_data[index].description,
                  ),),),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_pageIndex == Board_data.length - 1) {
                    // Navigate to the new screen if it's the last page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    );
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6524CB),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xFF1C0642),style: BorderStyle.solid,),
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: Text(
                'Next',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                                )
              ),
            ),
            SizedBox(height: 5,),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.all(9),),
                  ...List.generate(
                      Board_data.length,
                          (index) => Padding(
                        padding: const EdgeInsets.only(
                            right: 24),
                        child: Center(child: DotIndicator(isActive: index == _pageIndex,)),)
                  ),

                  const SizedBox(height: 10,width: 270,),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class Onboard{
  final String image, tittle, description;
  Onboard({
    required this.image,
    required this.tittle,
    required this.description,
  });
}

final List<Onboard>Board_data = [
  Onboard(image: 'assets/images/Onboard1.jpg',
    tittle: 'Gain Total Control \nOf Your Money',
    description:'Become your own money manager  and make every cent counts',
  ),
  Onboard(image: "assets/images/Onboard2.jpg",
      tittle: 'Know Where Your \n Money Goes',
      description: 'Track your transactions easily, with categories and financial reports '
  ),
  Onboard(image: "assets/images/Onboard3.jpg",
      tittle: 'Planning Ahead',
      description: ' Setup budgets for each category  so you know your in control. '
  ),
];

class OnboardingScreenContent extends StatefulWidget {
  const OnboardingScreenContent({
    super.key,
    required this.image,
    required this.tittle,
    required this.description,
  });
  final String image, tittle, description;



  @override
  State<OnboardingScreenContent> createState() => _OnboardingScreenContentState();
}

class _OnboardingScreenContentState extends State<OnboardingScreenContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Color(0xFF1C0642), // Replace with your color
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        widget.tittle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Lilita_One',
                          fontSize: 28,
                          fontWeight: FontWeight.w100,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  color:  Color(0xFF1C0642),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60.0),
                  topRight: Radius.circular(60.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 110,
                    child: Image.asset(
                      widget.image, // Replace with your asset path
                      height: 200,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      widget.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class DotIndicator extends  StatelessWidget {
  const DotIndicator({super.key,
    this.isActive = false,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: isActive ? 30 : 12 ,
        width: 12,
        decoration: BoxDecoration(
            color: isActive ? Color(0xFF1C0642) : Color(0xFF6524CB).withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(13),)
        ),
        child: CircleAvatar(
          radius: 12,
          backgroundColor:  isActive ? Color(0xFF1C0642) : Color(0xFF6524CB).withOpacity(0.8),
        ),
      ),
    );
  }
}

