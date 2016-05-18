//
//  GyroViewController.m
//  View controller form gyroscope
//
//  Created by Enix Yu on 29/12/15.
//  Copyright © 2015 Enix Yu. All rights reserved.
//

#import "GyroViewController.h"
#import "AppDelegate.h"

@interface GyroViewController ()
{
    CMMotionManager *motionManager;
    NSTimer *timer;
}

@property (weak, nonatomic) IBOutlet UILabel *rotationXLbl;
@property (weak, nonatomic) IBOutlet UILabel *rotationYLbl;
@property (weak, nonatomic) IBOutlet UILabel *rotationZLbl;
@property (weak, nonatomic) IBOutlet UILabel *pitchLbl;
@property (weak, nonatomic) IBOutlet UILabel *rollLbl;
@property (weak, nonatomic) IBOutlet UILabel *yawLbl;

@end

@implementation GyroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    motionManager = app.motionManager;
    
    self.navigationController.title = @"Timer style";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateAccelerometerData{
    if(motionManager.deviceMotionAvailable){
        // Attitude
        self.pitchLbl.text = [NSString stringWithFormat:@"%+.2f", motionManager.deviceMotion.attitude.pitch];
        self.rollLbl.text = [NSString stringWithFormat:@"%+.2f", motionManager.deviceMotion.attitude.roll];
        self.yawLbl.text = [NSString stringWithFormat:@"%+.2f", motionManager.deviceMotion.attitude.yaw];
    }
    
    if(motionManager.gyroAvailable){
        // Gyro rotation X/Y/Z
        self.rotationXLbl.text = [NSString stringWithFormat:@"%+.2f", motionManager.gyroData.rotationRate.x];
        self.rotationYLbl.text = [NSString stringWithFormat:@"%+.2f", motionManager.gyroData.rotationRate.y];
        self.rotationZLbl.text = [NSString stringWithFormat:@"%+.2f", motionManager.gyroData.rotationRate.z];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    if(motionManager.deviceMotionAvailable){
        motionManager.deviceMotionUpdateInterval = MOTION_INTERVAL;
        [motionManager startDeviceMotionUpdates];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Gyroscope not supported in this device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    if(motionManager.gyroAvailable){
        motionManager.gyroUpdateInterval = MOTION_INTERVAL;
        [motionManager startGyroUpdates];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Gyroscope not supported in this device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:MOTION_INTERVAL target:self selector:@selector(updateAccelerometerData) userInfo:nil repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    if(motionManager && motionManager.deviceMotionActive){
        [motionManager stopDeviceMotionUpdates];
    }
    
    if(motionManager && motionManager.gyroActive){
        [motionManager stopGyroUpdates];
    }
}

@end
