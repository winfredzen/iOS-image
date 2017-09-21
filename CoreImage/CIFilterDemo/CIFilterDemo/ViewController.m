//
//  ViewController.m
//  CIFilterDemo
//
//  Created by wangzhen on 2017/9/21.
//  Copyright © 2017年 wz. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *orginalImageView;
@property (weak, nonatomic) IBOutlet UIImageView *filterImageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (strong, nonatomic) UIImage *originalImage;
@property (strong, nonatomic) CIContext *context;
@property (strong, nonatomic) CIFilter *filter;

- (IBAction)autoAdjust:(id)sender;
- (IBAction)photoEffectInstant:(id)sender;
- (IBAction)photoEffectNoir:(id)sender;
- (IBAction)photoEffectTonal:(id)sender;
- (IBAction)photoEffectTransfer:(id)sender;
- (IBAction)photoEffectMono:(id)sender;
- (IBAction)photoEffectFade:(id)sender;
- (IBAction)photoEffectProcess:(id)sender;
- (IBAction)photoEffectChrome:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.originalImage = [UIImage imageNamed:@"lena"];
    self.context = [CIContext contextWithOptions:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//自动改善
- (IBAction)autoAdjust:(id)sender {
    
    self.textLabel.text = @"自动改善";
    
    CIImage *inputImage = [CIImage imageWithCGImage:self.originalImage.CGImage];
    NSArray *filters =  inputImage.autoAdjustmentFilters;
    for (CIFilter *filter in filters) {
        [filter setValue:inputImage forKey:kCIInputImageKey];
        inputImage = [filter outputImage];
    }
    //self.filterImageView.image = [UIImage imageWithCIImage:inputImage];
    //注意没有*号
    CGImageRef cgImage = [self.context createCGImage:inputImage  fromRect:[inputImage extent]];
    self.filterImageView.image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
}

//怀旧
- (IBAction)photoEffectInstant:(id)sender {
    self.textLabel.text = @"怀旧";
    self.filter = [CIFilter filterWithName:@"CIPhotoEffectInstant"];
    [self showFilterImage];
}

//黑白
- (IBAction)photoEffectNoir:(id)sender {
    self.textLabel.text = @"黑白";
    self.filter = [CIFilter filterWithName:@"CIPhotoEffectNoir"];
    [self showFilterImage];
}

//色调
- (IBAction)photoEffectTonal:(id)sender {
    self.textLabel.text = @"色调";
    self.filter = [CIFilter filterWithName:@"CIPhotoEffectTonal"];
    [self showFilterImage];
}

//岁月
- (IBAction)photoEffectTransfer:(id)sender {
    self.textLabel.text = @"岁月";
    self.filter = [CIFilter filterWithName:@"CIPhotoEffectTransfer"];
    [self showFilterImage];
}

//单色
- (IBAction)photoEffectMono:(id)sender {
    self.textLabel.text = @"单色";
    self.filter = [CIFilter filterWithName:@"CIPhotoEffectMono"];
    [self showFilterImage];
}

//褪色
- (IBAction)photoEffectFade:(id)sender {
    self.textLabel.text = @"褪色";
    self.filter = [CIFilter filterWithName:@"CIPhotoEffectFade"];
    [self showFilterImage];
}

//冲印
- (IBAction)photoEffectProcess:(id)sender {
    self.textLabel.text = @"冲印";
    self.filter = [CIFilter filterWithName:@"CIPhotoEffectProcess"];
    [self showFilterImage];
}

//铬黄
- (IBAction)photoEffectChrome:(id)sender {
    self.textLabel.text = @"铬黄";
    self.filter = [CIFilter filterWithName:@"CIPhotoEffectChrome"];
    [self showFilterImage];
}


#pragma mark - 

- (void)showFilterImage
{
    CIImage *inputImage = [CIImage imageWithCGImage:self.originalImage.CGImage];
    [self.filter setValue:inputImage forKey:kCIInputImageKey];
    CIImage *outputImage = [self.filter outputImage];
    CGImageRef cgImage = [self.context createCGImage:outputImage  fromRect:[outputImage extent]];
    self.filterImageView.image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
}

@end














