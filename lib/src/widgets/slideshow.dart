import 'package:design_app/src/models/slider_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Todo: Borrar
// import 'package:flutter_svg/svg.dart';

class Slidesshow extends StatelessWidget {
  List<Widget> slides;
  final bool puntosArriba;
  final Color colorPrimario;
  final Color colorSecundario;

  Slidesshow(
      {@required this.slides,
      this.puntosArriba = false,
      this.colorPrimario = Colors.blue,
      this.colorSecundario = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SliderModel(),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              if (this.puntosArriba)
                _Dots(slides.length, colorPrimario, colorSecundario),
              Expanded(child: _Slides(slides)),
              if (!this.puntosArriba)
                _Dots(slides.length, colorPrimario, colorSecundario),
            ],
          ),
        ),
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  List<Widget> slides;

  _Slides(this.slides);

  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageViewController = new PageController();

  @override
  void initState() {
    pageViewController.addListener(() {
      // print('Pagina actual: ${pageViewController.page}');
      //Actualizar el provider, sliderModel
      Provider.of<SliderModel>(context, listen: false).currentPage =
          pageViewController.page;
    });
    super.initState();
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageViewController,
        // children: [
        //   _Slide('assets/svgs/slide-1.svg'),
        //   _Slide('assets/svgs/slide-2.svg'),
        //   _Slide('assets/svgs/slide-3.svg')
        // ],
        children: widget.slides.map((child) => _Slide(child)).toList(),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  int totalSlides;
  final Color colorPrimario;
  final Color colorSecundario;

  _Dots(this.totalSlides, this.colorPrimario, this.colorSecundario);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // children: slides.asMap().entries.map((child) => _Dot(child.key)).toList(),
        children: List.generate(totalSlides, (index) => _Dot(index, colorPrimario, colorSecundario)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  final Color colorPrimario;
  final Color colorSecundario;

  _Dot(this.index, this.colorPrimario, this.colorSecundario);

  @override
  Widget build(BuildContext context) {
    final pageViewIndex = Provider.of<SliderModel>(context).currentPage;

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 12,
      height: 12,
      decoration: BoxDecoration(
          color: (pageViewIndex >= index - 0.5 && pageViewIndex < index + 0.5)
              ? colorPrimario
              : colorSecundario,
          shape: BoxShape.circle),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget widget;

  const _Slide(this.widget);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: widget,
    );
  }
}
