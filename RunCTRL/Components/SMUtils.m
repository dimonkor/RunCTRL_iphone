//
// Created by dmitrykorotchenkov on 16.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SMUtils.h"
#import "UIViewAdditions.h"
#import "SMSharedClass.h"

@implementation SMUtils {

}

UIColor *UIColorMake(CGFloat red, CGFloat green, CGFloat blue){
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

CGRect AppFrameWithoutToolBar(){
    return CGRectMake(0, 0, 320, 460);
}

+(UILabel *)customizeLabel:(UILabel *)label title:(NSString *)title size:(CGFloat)size color:(UIColor *)color{
    label.text = title;
    label.font = [UIFont fontWithName:FONT_FRANCHISE size:size];
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    return label;
}

+(UILabel *)createLabel:(NSString *)title size:(CGFloat)size color:(UIColor *)color{
    UILabel *label = [[UILabel alloc] init];
    return [self customizeLabel:label title:title size:size color:color];
}

+ (UIColor *)getBackgroundColor {
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
}

+ (UINavigationController *)createNavigationController:(UIViewController *)rootViewController{
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    navigationController.navigationBar.translucent = YES;
    navigationController.navigationBar.alpha = 0.5;
    return navigationController;
}

+(UIBarButtonItem *)createLeftNavigationButton:(NSString *)title target:(id)target action:(SEL)action{
    UIButton* backButton = [UIButton buttonWithType:101]; // left-pointing shape!
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:title forState:UIControlStateNormal];

    return [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

+ (UIImageView *)createViewWithImage:(UIImage *)image position:(CGPoint)position {
    UIImageView *logoView = [[UIImageView alloc] initWithImage:image];
    [logoView setOrigin:position];
    return logoView;
}

+ (UIButton *)createButtonWithImage:(UIImage *)image position:(CGPoint)position target:(id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button sizeToFit];
    [button setOrigin:position];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (void)updateViewForState:(UIViewController *)controller {
    if ([controller.view conformsToProtocol:@protocol(SMViewDelegate)]){
        UIView<SMViewDelegate> *view = (UIView <SMViewDelegate> *) controller.view;
        if ([[SMSharedClass sharedClass] isRegistered]){
            [view showRegisteredMode];
        }
        else{
            [view showNotRegisteredMode:controller];
        }
    }
}

@end