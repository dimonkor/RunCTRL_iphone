//
// Created by dmitrykorotchenkov on 11.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "SMViewDelegate.h"

@interface SMMainPageView : UIView <SMViewDelegate>

@property(nonatomic) CGFloat cruiseSpeed;

@property(nonatomic) CGFloat currentSpeed;

@end