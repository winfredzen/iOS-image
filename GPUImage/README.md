# # GPUImage



GPUImage同样可以用来实现各种各样的效果

基础基础可参考[Build a Photo App with GPUImage](https://code.tutsplus.com/tutorials/build-a-photo-app-with-gpuimage--mobile-12223)

要注意的是，在集成GPUImage时，在`Build Settings -> Header Search Paths `中路径要选择`recursive`，否则会提示找不到`import "GPUImage.h"`



如下的分别是原图、应用`GPUImageGrayscaleFilter`后的效果、应用`GPUImageSepiaFilter`后的效果

![原图](https://github.com/winfredzen/iOS-image/blob/master/GPUImage/images/image_01.png) ![GPUImageGrayscaleFilter](https://github.com/winfredzen/iOS-image/blob/master/GPUImage/images/image_02.png) ![GPUImageSepiaFilter](https://github.com/winfredzen/iOS-image/blob/master/GPUImage/images/image_03.png)






