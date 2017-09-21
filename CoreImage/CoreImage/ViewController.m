//
//  ViewController.m
//  CoreImage
//
//  Created by wangzhen on 2017/9/20.
//  Copyright © 2017年 wz. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *amountSlider;
- (IBAction)amountSliderValueChanged:(id)sender;
- (IBAction)loadPhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *savePhoto;

@end

@implementation ViewController
{
    CIContext *context;
    CIFilter *filter;
    CIImage *beginImage;
    UIImageOrientation orientation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //CISepiaTone能使整体颜色偏棕褐色，又有点像复古
    
    //1. 未使用CIContext
    /*
    CIImage *beginImage = [CIImage imageWithCGImage:[[UIImage imageNamed:@"image"] CGImage]];
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey, beginImage, @"inputIntensity", @0.8, nil];
    CIImage *outputImage = [filter outputImage];
    UIImage *newImage = [UIImage imageWithCIImage:outputImage];
    self.imageView.image = newImage;
     */
    
    //2. 使用CIContext
    /*
    CIImage *beginImage = [CIImage imageWithCGImage:[[UIImage imageNamed:@"image"] CGImage]];
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey, beginImage, @"inputIntensity", @0.8, nil];
    CIImage *outputImage = [filter outputImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *newImage = [UIImage imageWithCGImage:cgimg];
    self.imageView.image = newImage;
    //释放CGImageRef
    CGImageRelease(cgimg);
     */
    
    //3. Changing Filter Values
    beginImage = [CIImage imageWithCGImage:[[UIImage imageNamed:@"image"] CGImage]];
    filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey, beginImage, @"inputIntensity", @0.8, nil];
    context = [CIContext contextWithOptions:nil];
    
    
    [self amountSliderValueChanged:self.amountSlider];
    
    [self logAllFilters];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//可用的Filter
-(void)logAllFilters {
    NSArray *properties = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    NSLog(@"%@", properties);
    for (NSString *filterName in properties) {
        CIFilter *fltr = [CIFilter filterWithName:filterName];
        NSLog(@"%@", [fltr attributes]);
    }
}


- (IBAction)amountSliderValueChanged:(UISlider *)slider {
    
    float slideValue = slider.value;
    
    /*
    [filter setValue:@(slideValue) forKey:@"inputIntensity"];
    
    CIImage *outputImage = [filter outputImage];
     */
    
    CIImage *outputImage = [self oldPhoto:beginImage withAmount:slideValue];
    
    
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    //scale
    UIImage *newImage = [UIImage imageWithCGImage:cgimg scale:1.0 orientation:orientation];
    self.imageView.image = newImage;
    
    CGImageRelease(cgimg);
    
}

//链式调用
-(CIImage *)oldPhoto:(CIImage *)img withAmount:(float)intensity {
    
    // 1.CISepiaTone能使整体颜色偏棕褐色，又有点像复古
    CIFilter *sepia = [CIFilter filterWithName:@"CISepiaTone"];
    [sepia setValue:img forKey:kCIInputImageKey];
    [sepia setValue:@(intensity) forKey:@"inputIntensity"];
    
    // 2. random noise pattern 噪声模式
    CIFilter *random = [CIFilter filterWithName:@"CIRandomGenerator"];
    
    // 3
    CIFilter *lighten = [CIFilter filterWithName:@"CIColorControls"];
    [lighten setValue:random.outputImage forKey:kCIInputImageKey];
    [lighten setValue:@(1 - intensity) forKey:@"inputBrightness"];
    [lighten setValue:@0.0 forKey:@"inputSaturation"];
    
    // 4
    CIImage *croppedImage = [lighten.outputImage imageByCroppingToRect:[beginImage extent]];
    
    // 5
    CIFilter *composite = [CIFilter filterWithName:@"CIHardLightBlendMode"];
    [composite setValue:sepia.outputImage forKey:kCIInputImageKey];
    [composite setValue:croppedImage forKey:kCIInputBackgroundImageKey];
    
    // 6
    CIFilter *vignette = [CIFilter filterWithName:@"CIVignette"];
    [vignette setValue:composite.outputImage forKey:kCIInputImageKey];
    [vignette setValue:@(intensity * 2) forKey:@"inputIntensity"];
    [vignette setValue:@(intensity * 30) forKey:@"inputRadius"];
    
    // 7
    return vignette.outputImage;
}


- (IBAction)loadPhoto:(id)sender {
    
    UIImagePickerController *pickerC = [[UIImagePickerController alloc] init];
    pickerC.delegate = self;
    [self presentViewController:pickerC animated:YES completion:nil];
    
}

- (IBAction)savePhoto:(id)sender {
    
    CIImage *saveToSave = [filter outputImage];
    
    CIContext *softwareContext = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)} ];
    
    CGImageRef cgImg = [softwareContext createCGImage:saveToSave fromRect:[saveToSave extent]];
    
    ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:cgImg
                                 metadata:[saveToSave properties]
                          completionBlock:^(NSURL *assetURL, NSError *error) {
                              CGImageRelease(cgImg);
                          }];
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@", info);
    
    UIImage *gotImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    beginImage = [CIImage imageWithCGImage:gotImage.CGImage];
    //保存旋转方向
    orientation = gotImage.imageOrientation;
    
    [filter setValue:beginImage forKey:kCIInputImageKey];
    [self amountSliderValueChanged:self.amountSlider];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}






@end
