//
//  ViewController.m
//  ImageUtil
//
//  Created by 王振 on 2018/5/14.
//  Copyright © 2018年 wz. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Utils.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;

@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@property (weak, nonatomic) IBOutlet UIView *drawingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *bubbleImaage = [UIImage imageNamed:@"bubble_min"];
    
    self.imageView1.image = bubbleImaage;
    
    self.imageView2.image = [bubbleImaage wz_imageMaskedWithColor:[UIColor lightGrayColor]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
