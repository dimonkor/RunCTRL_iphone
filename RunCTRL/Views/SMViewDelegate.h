//
// Created by dmitrykorotchenkov on 17.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


@protocol SMViewDelegate <NSObject>

-(void)showRegisteredMode;

- (void)showNotRegisteredMode:(UIViewController *)controller;

@end