//
// Created by dmitrykorotchenkov on 17.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SMBuyNoAdsView.h"
#import "SMUtils.h"
#import "UIViewAdditions.h"
#import "SMSharedClass.h"
#import "SMAdsComponent.h"


@implementation SMBuyNoAdsView {

}

- (id)initWithFrame:(CGRect)frame controller:(UIViewController *)controller {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [SMUtils getBackgroundColor];

        [self addSubview:[SMUtils createViewWithImage:[UIImage imageNamed:@"buyNoAdsImage.png"] position:CGPointMake(0, 36)]];

        [self addSubview:[SMUtils createButtonWithImage:[UIImage imageNamed:@"buyNoAdsBtn.png"] position:CGPointMake(64.5, 205) target:nil action:@selector(buyNoAds)]];

        [self addSubview:[SMUtils createButtonWithImage:[UIImage imageNamed:@"getNoAdsFreeBtn.png"] position:CGPointMake(64.5, 322.5) target:nil action:@selector(sendEmail)]];

        UIView *bannerView = [[SMAdsComponent sharedComponent] bannerForController:controller];
        bannerView.origin = CGPointMake(0, self.frame.size.height-50);
        [self addSubview:bannerView];


    }

    return self;
}

@end