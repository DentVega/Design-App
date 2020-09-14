import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Todo: Borrar
// import 'package:flutter_svg/svg.dart';

class Slidesshow extends StatelessWidget {
  List<Widget> slides;
  final bool puntosArriba;
  final Color colorPrimario;
  final Color colorSecundario;
  final double bulletPrimario;
  final double bulletSecundario;

  Slidesshow(
      {@required this.slides,
      this.puntosArriba = false,
      this.colorPrimario = Colors.blue,
      this.colorSecundario = Colors.grey,
      this.bulletPrimario = 12.0,
      this.bulletSecundario = 12.0});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlidesshowModal(),
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (BuildContext context) {
              Provider.of<_SlidesshowModal>(context).colorPrimario =
                  this.colorPrimario;
              Provider.of<_SlidesshowModal>(context).colorSecuandario =
                  this.colorSecundario;
              Provider.of<_SlidesshowModal>(context).bulletPrimario =
                  this.bulletPrimario;
              Provider.of<_SlidesshowModal>(context).bulletSecundario =
                  this.bulletSecundario;

              return _CrearEstructuraSlideshow(
                  puntosArriba: puntosArriba, slides: slides);
            },
          ),
        ),
      ),
    );
  }
}

class _CrearEstructuraSlideshow extends StatelessWidget {
  const _CrearEstructuraSlideshow({
    Key key,
    @required this.puntosArriba,
    @required this.slides,
  }) : super(key: key);

  final bool puntosArriba;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (this.puntosArriba) _Dots(slides.length),
        Expanded(child: _Slides(slides)),
        if (!this.puntosArriba) _Dots(slides.length),
      ],
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
      Provider.of<_SlidesshowModal>(context, listen: false).currentPage =
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

  _Dots(this.totalSlides);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // children: slides.asMap().entries.map((child) => _Dot(child.key)).toList(),
        children: List.generate(totalSlides, (index) => _Dot(index)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  _Dot(this.index);

  @override
  Widget build(BuildContext context) {
    final pageViewIndex = Provider.of<_SlidesshowModal>(context);

    bool activated = (pageViewIndex.currentPage >= index - 0.5 &&
        pageViewIndex.currentPage < index + 0.5);

    final tamano = activated
        ? pageViewIndex.bulletPrimario
        : pageViewIndex.bulletSecundario;

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: tamano,
      height: tamano,
      decoration: BoxDecoration(
          color: activated
              ? pageViewIndex.colorPrimario
              : pageViewIndex.colorSecuandario,
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

class _SlidesshowModal with ChangeNotifier {
  double _currentPage = 0;
  Color _colorPrimario = Colors.blue;
  Color _colorSecuandario = Colors.grey;
  double _bulletPrimario = 12;
  double _bulletSecundario = 12;

  double get currentPage => this._currentPage;

  set currentPage(double pagina) {
    this._currentPage = pagina;
    // print('${pagina}');
    notifyListeners();
  }

  Color get colorPrimario => this._colorPrimario;

  set colorPrimario(Color color) {
    this._colorPrimario = color;
    notifyListeners();
  }

  Color get colorSecuandario => this._colorSecuandario;

  set colorSecuandario(Color color) {
    this._colorSecuandario = color;
    notifyListeners();
  }

  double get bulletPrimario => this._bulletPrimario;

  set bulletPrimario(double bulletPrimario) {
    this._bulletPrimario = bulletPrimario;
    notifyListeners();
  }

  double get bulletSecundario => this._bulletSecundario;

  set bulletSecundario(double bulletSecundario) {
    this._bulletSecundario = bulletSecundario;
    notifyListeners();
  }
}
