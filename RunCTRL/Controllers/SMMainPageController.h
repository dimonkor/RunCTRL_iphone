//
// Created by dmitrykorotchenkov on 11.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface SMMainPageController : UIViewController <CLLocationManagerDelegate>
- (void)increaseCruiseSpeed;

- (void)decreaseCruiseSpeed;

@end