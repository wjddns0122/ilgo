// Generates launcher-icon source images from assets/images/logo.png.
//
//   dart run tool/make_icon.dart
//
// Produces:
//   assets/images/icon_ios.png  – 1024², opaque, full-bleed brand green.
//   assets/images/icon_fg.png   – 1024², transparent, white artwork centered
//                                  (Android adaptive foreground; safe-zone).
//
// The brand green is sampled from the logo itself so the fill matches with no
// visible seam. Run `dart run flutter_launcher_icons` afterwards.
import 'dart:io';

import 'package:image/image.dart' as img;

const _src = 'assets/images/applogo.png';
const _outIos = 'assets/images/icon_ios.png';
const _outFg = 'assets/images/icon_fg.png';
const _size = 1024;

void main() {
  final bytes = File(_src).readAsBytesSync();
  final logo = img.decodePng(bytes);
  if (logo == null) {
    stderr.writeln('Could not decode $_src');
    exit(1);
  }

  // 1) Bounding box of everything visible (the rounded green badge).
  final badge = _bbox(logo, (p) => p.a > 32);
  // 2) Bounding box of the bright artwork only (white mailbox + 읽고 글자).
  final art =
      _bbox(logo, (p) => p.a > 200 && p.r > 180 && p.g > 180 && p.b > 180);
  // 3) Brand green, averaged from a patch near the badge's top edge.
  final green = _sampleGreen(logo, badge);
  stdout.writeln('badge=$badge art=$art '
      'green=#${green.r.toInt().toRadixString(16)}'
      '${green.g.toInt().toRadixString(16)}${green.b.toInt().toRadixString(16)}');

  _writeIos(logo, badge, green);
  _writeForeground(logo, art);
  stdout.writeln('Wrote $_outIos and $_outFg');
}

/// iOS: crop to the badge, scale to fill the whole canvas, composite over a
/// solid green background so the rounded corners blend away (full-bleed).
void _writeIos(img.Image logo, _Box badge, img.Pixel green) {
  final canvas = img.Image(width: _size, height: _size, numChannels: 4);
  img.fill(canvas,
      color: img.ColorRgba8(
          green.r.toInt(), green.g.toInt(), green.b.toInt(), 255));
  final cropped =
      img.copyCrop(logo, x: badge.x, y: badge.y, width: badge.w, height: badge.h);
  final scaled = img.copyResize(cropped,
      width: _size, height: _size, interpolation: img.Interpolation.cubic);
  img.compositeImage(canvas, scaled);
  File(_outIos).writeAsBytesSync(img.encodePng(canvas));
}

/// Android adaptive foreground: the bright artwork only, on a transparent
/// canvas, scaled into the ~62% safe zone and centered.
void _writeForeground(img.Image logo, _Box art) {
  final canvas = img.Image(width: _size, height: _size, numChannels: 4);
  const target = 640; // ~0.625 * 1024, inside the adaptive safe zone
  final scale = target / (art.w > art.h ? art.w : art.h);
  final w = (art.w * scale).round();
  final h = (art.h * scale).round();
  final cropped =
      img.copyCrop(logo, x: art.x, y: art.y, width: art.w, height: art.h);
  final scaled = img.copyResize(cropped,
      width: w, height: h, interpolation: img.Interpolation.cubic);
  img.compositeImage(canvas, scaled,
      dstX: (_size - w) ~/ 2, dstY: (_size - h) ~/ 2);
  File(_outFg).writeAsBytesSync(img.encodePng(canvas));
}

_Box _bbox(img.Image im, bool Function(img.Pixel) keep) {
  int minX = im.width, minY = im.height, maxX = -1, maxY = -1;
  for (final p in im) {
    if (!keep(p)) continue;
    if (p.x < minX) minX = p.x;
    if (p.y < minY) minY = p.y;
    if (p.x > maxX) maxX = p.x;
    if (p.y > maxY) maxY = p.y;
  }
  if (maxX < 0) return _Box(0, 0, im.width, im.height); // nothing matched
  return _Box(minX, minY, maxX - minX + 1, maxY - minY + 1);
}

/// Average the opaque pixels in a small patch near the top of [badge], which
/// is a plain-green strip above the artwork.
img.Pixel _sampleGreen(img.Image im, _Box badge) {
  final cx = badge.x + badge.w ~/ 2;
  final y0 = badge.y + (badge.h * 0.10).round();
  double r = 0, g = 0, b = 0;
  int n = 0;
  for (var y = y0; y < y0 + 24; y++) {
    for (var x = cx - 16; x < cx + 16; x++) {
      if (x < 0 || y < 0 || x >= im.width || y >= im.height) continue;
      final p = im.getPixel(x, y);
      if (p.a <= 200) continue;
      r += p.r;
      g += p.g;
      b += p.b;
      n++;
    }
  }
  if (n == 0) return im.getPixel(cx, y0);
  final out = img.Image(width: 1, height: 1, numChannels: 4);
  out.setPixelRgba(0, 0, (r / n).round(), (g / n).round(), (b / n).round(), 255);
  return out.getPixel(0, 0);
}

class _Box {
  const _Box(this.x, this.y, this.w, this.h);
  final int x, y, w, h;
  @override
  String toString() => '($x,$y ${w}x$h)';
}
