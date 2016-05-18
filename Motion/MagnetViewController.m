//
//  MagnetViewController.m
//  Motion
//
//  Created by Enix Yu on 30/12/15.
//  Copyright © 2015 Enix Yu. All rights reserved.
//

#import "MagnetViewController.h"
#import "AppDelegate.h"

@interface MagnetViewController ()

@property (weak, nonatomic) IBOutlet UILabel *magnetXLbl;
@property (weak, nonatomic) IBOutlet UILabel *magnetYLbl;
@property (weak, nonatomic) IBOutlet UILabel *magnetZLbl;

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation MagnetViewController

#pragma mark - View controller methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.motionManager = app.motionManager;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    if(self.motionManager.magnetometerAvailable){
        self.motionManager.magnetometerUpdateInterval = MOTION_INTERVAL;
        [self.motionManager startMagnetometerUpdates];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:MOTION_INTERVAL target:self selector:@selector(updateMagnetData) userInfo:nil repeats:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Magnetmeter is not supported in your device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    if(self.motionManager != nil && self.motionManager.magnetometerActive){
        [self.motionManager stopMagnetometerUpdates];
    }
}

#pragma mark - Private methods

- (void)updateMagnetData{
    if(self.motionManager.magnetometerActive){
        self.magnetXLbl.text = [NSString stringWithFormat:@"%+.2f", self.motionManager.magnetometerData.magneticField.x];
        self.magnetYLbl.text = [NSString stringWithFormat:@"%+.2f", self.motionManager.magnetometerData.magneticField.y];
        self.magnetZLbl.text = [NSString stringWithFormat:@"%+.2f", self.motionManager.magnetometerData.magneticField.z];
        
    }
}

@end
