//
// Created by dmitrykorotchenkov on 16.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


#define DID_CHANGE_SPEED_TYPE @"didChangeSpeedType"

@interface SMSpeedType : UILabel

- (id)initWithTextSize:(CGFloat)size;

- (void)updateSpeedType;

- (void)changeSpeedType;


@end