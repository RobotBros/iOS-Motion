//
//  AccelViewController.m
//  View controller form Accelerometer
//
//  Created by Enix Yu on 28/12/15.
//  Copyright © 2015 Enix Yu. All rights reserved.
//

#import "AccelViewController.h"
#import "AppDelegate.h"

@interface AccelViewController ()
{
    double maxAccelerometerX;
    double maxAccelerometerY;
    double maxAccelerometerZ;
    
    double maxRotationX;
    double maxRotationY;
    double maxRotationZ;
    
    CMMotionManager *motionManager;
}

@property (weak, nonatomic) IBOutlet UILabel *accelerometerXLbl;
@property (weak, nonatomic) IBOutlet UILabel *accelerometerYLbl;
@property (weak, nonatomic) IBOutlet UILabel *accelerometerZLbl;

@property (weak, nonatomic) IBOutlet UILabel *maxAccelerometerXLbl;
@property (weak, nonatomic) IBOutlet UILabel *maxAccelerometerYLbl;
@property (weak, nonatomic) IBOutlet UILabel *maxAccelerometerZLbl;


@property (strong, nonatomic) NSOperationQueue *queue;

@end

@implementation AccelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.queue = [[NSOperationQueue alloc] init];
    
    maxAccelerometerX = 0.0f;
    maxAccelerometerY = 0.0f;
    maxAccelerometerZ = 0.0f;
    
    maxRotationX = 0.0f;
    maxRotationY = 0.0f;
    maxRotationZ = 0.0f;
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    motionManager = app.motionManager;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    if(motionManager.accelerometerAvailable){
        motionManager.accelerometerUpdateInterval = 1.0 / 10.0;
        [motionManager startAccelerometerUpdatesToQueue:self.queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            if (error) {
                [motionManager stopAccelerometerUpdates];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Accelerometer error: %@", error] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            } else {
                maxAccelerometerX = maxAccelerometerX > accelerometerData.acceleration.x ? maxAccelerometerX : accelerometerData.acceleration.x;
                maxAccelerometerY = maxAccelerometerY > accelerometerData.acceleration.y ? maxAccelerometerY : accelerometerData.acceleration.y;
                maxAccelerometerZ = maxAccelerometerZ > accelerometerData.acceleration.z ? maxAccelerometerZ : accelerometerData.acceleration.z;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Accelerometer X/Y/Z
                    self.accelerometerXLbl.text = [NSString stringWithFormat:@"%+.2f", accelerometerData.acceleration.x];
                    self.accelerometerYLbl.text = [NSString stringWithFormat:@"%+.2f", accelerometerData.acceleration.y];
                    self.accelerometerZLbl.text = [NSString stringWithFormat:@"%+.2f", accelerometerData.acceleration.z];
                    
                    self.maxAccelerometerXLbl.text = [NSString stringWithFormat:@"%+.2f", maxAccelerometerX];
                    self.maxAccelerometerYLbl.text = [NSString stringWithFormat:@"%+.2f", maxAccelerometerY];
                    self.maxAccelerometerZLbl.text = [NSString stringWithFormat:@"%+.2f", maxAccelerometerZ];
                });
            }
        }];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Accelerometer not supported in this device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    if(motionManager && motionManager.accelerometerActive){
        [motionManager stopAccelerometerUpdates];
    }
}

@end
