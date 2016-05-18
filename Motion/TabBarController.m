//
//  TabBarController.m
//  Motion
//
//  Created by Enix Yu on 30/12/15.
//  Copyright © 2015 Enix Yu. All rights reserved.
//

#import "TabBarController.h"
#import "UIImage+FontAwesome.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *imageName;
    for (UITabBarItem *item in self.tabBar.items) {
        if ([item.title isEqualToString:@"Accelerometer"]) {
            imageName = @"fa-move";
        } else if([item.title isEqualToString:@"Gyro"]){
            imageName = @"fa-fighter-jet";
        } else if([item.title isEqualToString:@"Magnetometer"]){
            imageName = @"fa-magnet";
        }
        
        UIImage *iconDefault  = [UIImage imageWithIcon:imageName backgroundColor:[UIColor clearColor] iconColor:[UIColor lightGrayColor] andSize:CGSizeMake(25, 25)];
        UIImage *iconSelected = [UIImage imageWithIcon:imageName backgroundColor:[UIColor clearColor] iconColor:[self.view tintColor] andSize:CGSizeMake(25, 25)];
        
        item.image = [iconDefault imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [iconSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
