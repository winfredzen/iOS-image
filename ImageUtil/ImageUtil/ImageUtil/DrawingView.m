//
//  DrawingView.m
//  ImageUtil
//
//  Created by 王振 on 2018/5/14.
//  Copyright © 2018年 wz. All rights reserved.
//

#import "DrawingView.h"

@implementation DrawingView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
#if 0
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawEllipse:context];
    
    //drawGradient
    [self drawEllipseWithGradient:context];
    
#endif
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Draw a dark gray background
    [[UIColor darkGrayColor] setFill];
    CGContextFillRect(context, rect);
    
    // Draw the text upside-down
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [[UIColor whiteColor] setFill];
    [@"Hello" drawInRect:rect withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:124]];
    CGContextRestoreGState(context);
    
    // Create an image mask from what we've drawn so far
    CGImageRef alphaMask = CGBitmapContextCreateImage(context);
    
    // Draw a white background (overwriting the previous work)
    [[UIColor whiteColor] setFill];
    CGContextFillRect(context, rect);
    
    // Draw the image, clipped by the mask
    CGContextSaveGState(context);
    CGContextClipToMask(context, rect, alphaMask);
    
    [[UIImage imageNamed:@"shuttle.jpg"] drawInRect:rect];
    CGContextRestoreGState(context);
    CGImageRelease(alphaMask);
    
    
}


-(void)drawEllipse:(CGContextRef)context{
    
    CGContextSaveGState(context);
    
    //Set color of current context
    [[UIColor blackColor] set];
    
    //Set shadow and color of shadow
    CGContextSetShadowWithColor(context, CGSizeZero, 10.0f, [[UIColor blackColor] CGColor]);
    
    //Draw ellipse
    CGRect ellipseRect = CGRectMake(60.0f, 150.0f, 200.0f, 200.0f);
    CGContextFillEllipseInRect(context, ellipseRect);
    
    CGContextRestoreGState(context);
    
}

-(void)drawGradient:(CGContextRef)context{
    
    //Define start and end colors
    CGFloat colors [8] = {
        0.0, 0.0, 1.0, 1.0, //Blue
        0.0, 1.0, 0.0, 1.0 }; //Green
    
    //Setup a color space and gradient space
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace,     colors, NULL, 2);
    
    //Define the gradient direction
    CGPoint startPoint = CGPointMake(160.0f,0.0f);
    CGPoint endPoint = CGPointMake(160.0f, 400.0f);
    
    //Create and Draw the gradient
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGColorSpaceRelease(baseSpace);
    CGGradientRelease(gradient);
}


-(void)drawEllipseWithGradient:(CGContextRef)context{
    
    CGContextSaveGState(context);
    
    //创建mask图片
    
    //UIGraphicsBeginImageContextWith(self.frame.size);
    UIGraphicsBeginImageContextWithOptions((self.frame.size), NO, 0.0);
    
    CGContextRef newContext = UIGraphicsGetCurrentContext();
    
    // Translate and scale image to compnesate for Quartz's inverted coordinate system
    // 注意翻转坐标系
    CGContextTranslateCTM(newContext,0.0,self.frame.size.height);
    CGContextScaleCTM(newContext, 1.0, -1.0);
    
    //Set color of current context
    [[UIColor blackColor] set];
    
    //Draw ellipse &lt;- I know we’re drawing a circle, but a circle is just a special ellipse.
    CGRect ellipseRect = CGRectMake(110.0f, 200.0f, 100.0f, 100.0f);
    CGContextFillEllipseInRect(newContext, ellipseRect);
    
    CGImageRef mask = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext());
    UIGraphicsEndImageContext();
    
    CGContextClipToMask(context, self.bounds, mask);
    [self drawGradient:context];
    
    CGImageRelease(mask);
    
}

@end
