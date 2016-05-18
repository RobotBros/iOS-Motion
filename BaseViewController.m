//
//  BaseViewController.m
//  Motion
//
//  Created by Enix Yu on 30/12/15.
//  Copyright © 2015 Enix Yu. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImage+FontAwesome.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTabBarItemWithFAString:(NSString *)name{
    UIImage *iconDefault  = [UIImage imageWithIcon:name backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] andSize:CGSizeMake(32, 32)];
    UIImage *iconSelected = [UIImage imageWithIcon:name backgroundColor:[UIColor clearColor] iconColor:[UIColor redColor] andSize:CGSizeMake(32, 32)];
    
    self.tabBarItem.image = [iconDefault imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage = [iconSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
