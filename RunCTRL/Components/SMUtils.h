//
// Created by dmitrykorotchenkov on 16.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "SMViewDelegate.h"


#define FONT_FRANCHISE @"Franchise-Bold"

@interface SMUtils : NSObject

UIColor *UIColorMake(CGFloat red, CGFloat green, CGFloat blue);

CGRect AppFrameWithoutToolBar();

+ (UILabel *)customizeLabel:(UILabel *)label title:(NSString *)title size:(CGFloat)size color:(UIColor *)color;

+ (UILabel *)createLabel:(NSString *)title size:(CGFloat)size color:(UIColor *)color;

+ (UIColor *)getBackgroundColor;

+ (UINavigationController *)createNavigationController:(UIViewController *)rootViewController;

+ (UIBarButtonItem *)createLeftNavigationButton:(NSString *)title target:(id)target action:(SEL)action;

+ (UIImageView *)createViewWithImage:(UIImage *)image position:(CGPoint)position;

+ (UIButton *)createButtonWithImage:(UIImage *)image position:(CGPoint)position target:(id)target action:(SEL)action;

+ (void)updateViewForState:(UIViewController *)controller;


@end