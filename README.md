e.pi.mac
========

This project started because I wanted to create a GPU accelerated fractal renderer. My other project, [e.pi.i](https://github.com/rednebmas/e.pi.i), was web based and did not take advantage of WebGL. I wanted to learn about GPU computation so I worked on a Mac app. After getting GPU computation working correctly (can be seen under the branch "gpu") I discovered that my GPU does not support double precision which is necessary to zoom any significant distance into the mandelbrot set. It does appear that it is possible to emulate higher precision using [multiple floating point values](http://www.bealto.com/mp-opencl.html), but that adds much more complexity to the project and I currently do not have the time to implement it.
