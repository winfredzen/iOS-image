# GPUImage



GPUImage同样可以用来实现各种各样的效果



**基本概念**

参考教程[iOS GPUImage 滤镜介绍](http://blog.csdn.net/agonie201218/article/details/77747691)

GPUImage采用链式方式来处理画面,通过`addTarget:`方法为链条添加每个环节的对象，处理完一个target,就会把上一个环节处理好的图像数据传递下一个target去处理，称为GPUImage处理链。

一般的target可分为两类:

+ 中间环节的target, 一般是各种filter, 是GPUImageFilter或者是子类. 
+ 最终环节的target, GPUImageView：用于显示到屏幕上, 或者GPUImageMovieWriter：写成视频文件。

GPUImage处理主要分为3个环节:source(视频、图片源) -> filter（滤镜） -> final target (处理后视频、图片) 

GPUImage的Source: 都继承`GPUImageOutput`的子类，作为GPUImage的数据源,就好比外界的光线，作为眼睛的输出源 
`GPUImageVideoCamera`：用于实时拍摄视频 
`GPUImageStillCamer`a：用于实时拍摄照片 
`GPUImagePicture`：用于处理已经拍摄好的图片，比如png,jpg图片 
`GPUImageMovie`：用于处理已经拍摄好的视频,比如mp4文件 
GPUImage的filter: `GPUimageFilter`类或者子类，这个类继承自`GPUImageOutput`,并且遵守`GPUImageInput`协议，这样既能流进，又能流出，就好比我们的墨镜，光线通过墨镜的处理，最终进入我们眼睛 
GPUImage的final target: `GPUImageView`,`GPUImageMovieWriter`就好比我们眼睛，最终输入目标。




基础教程可参考[Build a Photo App with GPUImage](https://code.tutsplus.com/tutorials/build-a-photo-app-with-gpuimage--mobile-12223)，其中实现了多种效果，也介绍了如何在项目中集成GPUImage

要注意的是，在集成GPUImage时，在`Build Settings -> Header Search Paths `中路径要选择`recursive`，否则会提示找不到`import "GPUImage.h"`



如下的分别是原图、应用`GPUImageGrayscaleFilter`后的效果、应用`GPUImageSepiaFilter`后的效果

![原图](https://github.com/winfredzen/iOS-image/blob/master/GPUImage/images/image_01.png) ![GPUImageGrayscaleFilter](https://github.com/winfredzen/iOS-image/blob/master/GPUImage/images/image_02.png) ![GPUImageSepiaFilter](https://github.com/winfredzen/iOS-image/blob/master/GPUImage/images/image_03.png)

GPUImage可以对video做实时的过滤处理，可参见其源码中对应的例子



美颜：



+ [基于GPUImage的实时美颜滤镜](http://www.jianshu.com/p/945fc806a9b4)




