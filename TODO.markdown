# TODO

SwiftGraphics is currently a WIP - the API will change radically.

* Documentation
* Unit Tests
* Fix iOS vs OSX build targets
* Double check operater precidence - forced to do some weird casting right now
* Demo projects
* Really understand public vs private vs internal (see BezierCurve)
* Unsure about some of the convenience init() methods. They're serve no purpose other than reducing typing and visual clutter.
* Might end up wrapping CGContext (and other CG types) in swift classes just so I get full benefit of swift. For example you can't create class methods on CGContext etc.'