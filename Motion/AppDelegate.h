//
//  AppDelegate.h
//  Motion
//
//  Created by Enix Yu on 28/12/15.
//  Copyright © 2015 Enix Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

#define MOTION_INTERVAL   (1.0 / 10.0)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, readonly) CMMotionManager *motionManager;

@end

