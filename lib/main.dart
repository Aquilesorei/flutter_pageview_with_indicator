import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Pagination(
      pageController: _pageController,
      backgroundColor: Colors.red,
      onFinished: (){
        print("finished");
      },
      onSkip: (){
        print("skipped");
      },
      children: const [
        Center(
          child: Text("Page 1"),
        ),
        Center(
          child: Text("Page 2"),
        ),
        Center(
          child: Text("Page 3"),
        )
      ],
    );
  }
}

class Pagination extends StatelessWidget {
  final List<Widget> children;
  final Color? backgroundColor;
  final PageController pageController;
  final Function()? onFinished;
  final Function()? onSkip;
  const Pagination({super.key, required this.children, this.backgroundColor, required this.pageController, this.onFinished, this.onSkip});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BasePage(
          widgets: children,
          backgroundColor: backgroundColor, pageController: pageController,
          onFinished: onFinished,
          onSkip: onSkip,

        ));
  }
}

class BasePage extends StatefulWidget {
  final List<Widget> widgets;
  final Color? backgroundColor;
  final PageController pageController;
  final Function()? onFinished;
  final Function()? onSkip;
  const BasePage({super.key, required this.widgets, this.backgroundColor, required this.pageController, this.onFinished, this.onSkip});

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  late final PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = widget.pageController;
    super.initState();
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: widget.onSkip, child: const Text("Skip",style: TextStyle(color: Colors.white),))
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: widget.widgets,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
              ),
            ),
            Row(
              children: [
                const Spacer(),
                _StepIndicator(currentPageIndex: _currentPageIndex),
                const Spacer()
              ],
            ),
            Row(
              children: [
                Visibility(
                  visible: _currentPageIndex != 0,
                  child: TextButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                      child: const Text(
                        "Previous",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                const Spacer(),
                Visibility(
                  visible: _currentPageIndex != 0 ,
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          if(_currentPageIndex == (widget.widgets.length -1)){
                            if(widget.onFinished != null){
                              widget.onFinished!();
                            }
                          }else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        },
                        child: const Text(
                          "Next",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.east_outlined,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final int currentPageIndex;

  const _StepIndicator({super.key, required this.currentPageIndex});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StepCircle(
            isActive: currentPageIndex == 0,
          ),
          StepCircle(
            isActive: currentPageIndex == 1,
          ),
          StepCircle(
            isActive: currentPageIndex == 2,
          ),
        ],
      ),
    );
  }
}

class StepCircle extends StatelessWidget {
  final bool isActive;

  const StepCircle({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
