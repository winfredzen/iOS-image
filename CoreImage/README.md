# Core Image

Core Image教程推荐：



+ [Core Image 你需要了解的那些事~](https://colin1994.github.io/2016/10/21/Core-Image-OverView/)
+ [OC版本-Beginning Core Image in iOS 6](https://www.raywenderlich.com/22167/beginning-core-image-in-ios-6))或[Swift版本-Core Image Tutorial: Getting Started](https://www.raywenderlich.com/76285/beginning-core-image-swift)
+ [Core Image 介绍](https://objccn.io/issue-21-6/)



Core Image 的 API 主要就是三类：



+ CIImage 保存图像数据的类，可以通过UIImage，图像文件或者像素数据来创建，包括未处理的像素数据
+ CIFilter 表示应用的滤镜，这个框架中对图片属性进行细节处理的类。它对所有的像素进行操作，用一些键-值设置来决定具体操作的程度
+ CIContext 表示上下文，如 Core Graphics 以及 Core Data 中的上下文用于处理绘制渲染以及处理托管对象一样，Core Image 的上下文也是实现对图像处理的具体对象。可以从其中取得图片的信息



## Image Metadata

移动设备摄制的图片，有许多信息与其联系在一起，如GSP、图片格式、图片的方向等。尤其是图片的方向，这是你需要保存的。把图片加载为CIImage，渲染为CGImage，再转为UIImage，会忽略掉image中的metadata(元数据)。所以你需要先记录图片的方向，再把它应用给图片

获取方向信息

```
orientation = gotImage.imageOrientation;
```

把图片的方向信息应用给新创建的图片

```
UIImage *newImage = [UIImage imageWithCGImage:cgimg scale:1.0 orientation:orientation];
```










