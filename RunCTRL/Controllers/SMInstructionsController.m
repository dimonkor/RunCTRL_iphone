//
// Created by dmitrykorotchenkov on 17.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <iAd/iAd.h>
#import "SMInstructionsController.h"
#import "SMInstructionsView.h"
#import "SMMainPageController.h"
#import "SMBuyNoAdsController.h"
#import "SMSharedClass.h"
#import "SMViewDelegate.h"
#import "SMUtils.h"


@implementation SMInstructionsController {

}

- (void)loadView {
    [super loadView];
    self.view = [[SMInstructionsView alloc] initWithFrame:AppFrameWithoutToolBar()];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [SMUtils updateViewForState:self];
}

-(void)gotoMainPage{
    [self.navigationController pushViewController:[[SMMainPageController alloc] init] animated:YES];
}

-(void)gotoBuyNoAdsPage{
    [self.navigationController pushViewController:[[SMBuyNoAdsController alloc] init] animated:YES];
}


@end