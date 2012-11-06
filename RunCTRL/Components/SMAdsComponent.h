//
// Created by dmitrykorotchenkov on 18.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <iAd/iAd.h>
#import "GADBannerViewDelegate.h"

@interface SMAdsComponent : NSObject <ADBannerViewDelegate, GADBannerViewDelegate>

+ (SMAdsComponent *)sharedComponent;

- (UIView *)bannerForController:(UIViewController *)controller;

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error;

@end