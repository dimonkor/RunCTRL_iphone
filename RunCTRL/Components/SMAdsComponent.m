//
// Created by dmitrykorotchenkov on 18.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SMAdsComponent.h"
#import "GADBannerView.h"
#import "UIViewAdditions.h"
#import "SMConstants.h"


@interface SMAdsComponent ()
@property(nonatomic, strong) UIView *bannerView;
@property(nonatomic, weak) UIViewController *viewController;


@end

@implementation SMAdsComponent {

}

+(SMAdsComponent *)sharedComponent{
    static SMAdsComponent *class = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        class = [[SMAdsComponent alloc] init];
    });
    return class;
}


-(UIView *)bannerForController:(UIViewController *)controller{
        self.viewController = controller;
        if (self.bannerView)
            return self.bannerView;
        else
            return [self getBanner];
}

-(UIView *)getBanner{
    return [self getAdBannerView];
}

-(UIView *)getAdModBanner:(UIViewController *)pageController{
    GADBannerView *bannerView = [[GADBannerView alloc]
            initWithFrame:CGRectMake(0.0,
                    0,
                    GAD_SIZE_320x50.width,
                    GAD_SIZE_320x50.height)];
    bannerView.delegate = self;
    bannerView.adUnitID = AD_MOB_ID;
    bannerView.rootViewController = pageController;
    GADRequest *request = [GADRequest request];
    request.testing = YES;
    [bannerView loadRequest:request];
    self.bannerView = bannerView;
    return bannerView;
}

-(UIView *)getAdBannerView{
    ADBannerView *adBannerView = [[ADBannerView alloc] init];
    adBannerView.delegate = self;
    adBannerView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierPortrait];
//    adBannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifier320x50;
    self.bannerView = adBannerView;
    return adBannerView;
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    NSLog(error.description);
    [self workingOnError];
}

- (void)adView:(GADBannerView *)banner didFailToReceiveAdWithError:(GADRequestError *)error{
    if (self.bannerView && [self.bannerView superview]){
        [self.bannerView removeFromSuperview];
    }
    self.bannerView = nil;
}

-(void)workingOnError{
    if (self.bannerView){
        UIView *superView = self.bannerView.superview;
        if (superView){
            [self.bannerView removeFromSuperview];
            CGPoint position = self.bannerView.origin;
            self.bannerView = [self getAdModBanner:self.viewController];
            self.bannerView.origin = position;
            [superView addSubview:self.bannerView];
        }
        else{
            CGPoint position = self.bannerView.origin;
            self.bannerView = [self getAdModBanner:self.viewController];
            self.bannerView.origin = position;
        }
    }
}

@end