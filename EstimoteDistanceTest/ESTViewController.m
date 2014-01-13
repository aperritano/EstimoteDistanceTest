//
//  ESTViewController.m
//  DistanceDemo
//
//  Created by Marcin Klimek on 9/26/13.
//  Copyright (c) 2013 Estimote. All rights reserved.
//

#import "ESTViewController.h"
#import "ESTBeaconManager.h"

#define DOT_MIN_POS 120
#define DOT_MAX_POS screenHeight - 70;

@interface ESTViewController () <ESTBeaconManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *numberOfBeaconsLabel;
@property (weak, nonatomic) IBOutlet UILabel *beaconsWithinDistanceLabel;

@property (nonatomic, strong) ESTBeaconManager* beaconManager;
@property (nonatomic, strong) ESTBeacon*        selectedBeacon;
@end

@implementation ESTViewController

#pragma mark - View Setup


- (void)setupView
{

}

#pragma mark - Manager setup

- (void)setupManager
{
    // create manager instance
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    
    // create sample region object (you can additionaly pass major / minor values)
    ESTBeaconRegion* region = [[ESTBeaconRegion alloc] initRegionWithIdentifier:@"EstimoteSampleRegion"];
    
    // start looking for estimote beacons in region
    // when beacon ranged beaconManager:didRangeBeacons:inRegion: invoked
    [self.beaconManager startRangingBeaconsInRegion:region];
}

#pragma mark - ViewController Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupManager];
    [self setupView];
}

#pragma mark - ESTBeaconManagerDelegate Implementation

int distanceCount;
-(void)beaconManager:(ESTBeaconManager *)manager
     didRangeBeacons:(NSArray *)beacons
            inRegion:(ESTBeaconRegion *)region
{

            _numberOfBeaconsLabel.text = [NSString stringWithFormat:@"%d",
    [beacons count]];

            distanceCount = 0;
            for (ESTBeacon* cBeacon in beacons)
            {

                self.selectedBeacon = cBeacon;
                float distFactor = ((float)self.selectedBeacon.rssi + 30) / -70;
                if( distFactor < .5 ) {
                      distanceCount++;
                }
            }

            _beaconsWithinDistanceLabel.text = [NSString stringWithFormat:@"%d", distanceCount];
        
        // based on observation rssi is not getting bigger then -30
        // so it changes from -30 to -100 so we normalize



}

@end
