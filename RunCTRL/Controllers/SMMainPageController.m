//
// Created by dmitrykorotchenkov on 11.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <AudioToolbox/AudioToolbox.h>
#import "SMMainPageController.h"
#import "SMMainPageView.h"
#import "CoreLocation/CoreLocation.h"
#import "SMSharedClass.h"
#import "SMSpeedType.h"
#import "SMUtils.h"
#import "SMBuyNoAdsController.h"
#import "SMAudioComponent.h"

@interface SMMainPageController ()
@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic) CGFloat lastSpeed;


@end

@implementation SMMainPageController {

}

- (id)init {
    self = [super init];
    if (self) {
        self.lastSpeed = 0;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSpeedForSpeedType) name:DID_CHANGE_SPEED_TYPE object:nil];
    }

    return self;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [SMUtils updateViewForState:self];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    [self.locationManager startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[SMAudioComponent sharedComponent] changeMode:SMVibeModeNormal];
}


- (void)loadView {
    [super loadView];
    SMMainPageView *view = [[SMMainPageView alloc] initWithFrame:AppFrameWithoutToolBar()];
    self.view = view;
    view.cruiseSpeed = [[SMSharedClass sharedClass] cruiseSpeed];
    
}

-(void)increaseCruiseSpeed {
    [SMSharedClass sharedClass].cruiseSpeed+=0.5;
    SMMainPageView *view = (SMMainPageView *)self.view;
    view.cruiseSpeed = [SMSharedClass sharedClass].cruiseSpeed;
}

-(void)decreaseCruiseSpeed {
    [SMSharedClass sharedClass].cruiseSpeed-=0.5;
    SMMainPageView *view = (SMMainPageView *)self.view;
    view.cruiseSpeed = [SMSharedClass sharedClass].cruiseSpeed;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    CGFloat speed = (CGFloat) newLocation.speed;
    if (!speed || speed<0){
        speed=0;
        [[SMAudioComponent sharedComponent] changeMode:SMVibeModeNormal];
        self.lastSpeed = speed;
    }
    else{
        self.lastSpeed = speed;
        [self compareCruiseSpeedAndCurrentSpeed];
    }
    SMMainPageView *view = (SMMainPageView *)self.view;
    NSLog(@"%@  %f", [SMSharedClass sharedClass].speedTypeIsMiles ? @"miles" : @"km" , [self convertSpeedForSpeedType:speed]);
    view.currentSpeed = [self convertSpeedForSpeedType:speed];
}

-(void)compareCruiseSpeedAndCurrentSpeed{
    CGFloat tmp = [self convertSpeedForSpeedType:self.lastSpeed] - [SMSharedClass sharedClass].cruiseSpeed;
    CGFloat margin = 3 / (![SMSharedClass sharedClass].speedTypeIsMiles ?  0.621371 : 1.0);
    if (tmp < -margin){
        [[SMAudioComponent sharedComponent] changeMode:SMVibeModeFaster];
    }
    else if (tmp > margin){
        [[SMAudioComponent sharedComponent] changeMode:SMVibeModeSlower];
    }
    else{
        [[SMAudioComponent sharedComponent] changeMode:SMVibeModeNormal];
    }
}

-(void)updateSpeedForSpeedType{
    SMMainPageView *view = (SMMainPageView *)self.view;
    view.currentSpeed = [self convertSpeedForSpeedType:self.lastSpeed];
    view.cruiseSpeed = [SMSharedClass sharedClass].cruiseSpeed;
}

-(CGFloat)convertSpeedForSpeedType:(CGFloat)speed{
    return (speed / 1000 * 3600) * ([SMSharedClass sharedClass].speedTypeIsMiles ?  0.621371 : 1.0);
}

-(void)gotoBuyNoAdsPage{
    [self.navigationController pushViewController:[[SMBuyNoAdsController alloc] init] animated:YES];
}

-(void)tmpAction{
    [[SMSharedClass sharedClass] setIsRegistered:NO];
    [self.navigationController popViewControllerAnimated:YES];

}


@end