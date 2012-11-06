//
// Created by dmitrykorotchenkov on 17.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SMInstructionsView.h"
#import "SMUtils.h"
#import "UIViewAdditions.h"
#import "SMSharedClass.h"
#import "SMAdsComponent.h"


@interface SMInstructionsView ()
@property(nonatomic, strong) UIButton *buyNoAdsBtn;
@property(nonatomic, strong) UIButton *continueBtn;


@end

@implementation SMInstructionsView {

}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [SMUtils getBackgroundColor];
        [self addInstructionsView];
        [self addByNoAdsButton];
        [self addContinueButton];
        self.userInteractionEnabled = YES;

    }

    return self;
}

- (void)addByNoAdsButton {
    self.buyNoAdsBtn = [SMUtils createButtonWithImage:[UIImage imageNamed:@"buyNoAdsBtn.png"] position:CGPointMake(64.5, 329) target:nil action:@selector(gotoBuyNoAdsPage)];
    [self addSubview:self.buyNoAdsBtn];
}

- (void)addContinueButton {
    self.continueBtn = [SMUtils createButtonWithImage:[UIImage imageNamed:@"continueBtn.png"] position:CGPointMake(64.5, 370.5) target:nil action:@selector(gotoMainPage)];
    [self addSubview:self.continueBtn];
}

- (void)addInstructionsView {
    [self addSubview:[SMUtils createViewWithImage:[UIImage imageNamed:@"logoInstruction.png"] position:CGPointMake(91, 36)]];
    [self addSubview:[SMUtils createViewWithImage:[UIImage imageNamed:@"instruction.png"] position:CGPointMake(0, 145)]];
}

- (void)showRegisteredMode {
    self.bounds = CGRectOffset(self.frame, 0, -50) ;
    self.continueBtn.origin = CGPointMake(64.5, 329);
    self.buyNoAdsBtn.hidden = YES;

    UIView *bannerView = [self viewWithTag:BANNER_VIEW_TAG];
    if (bannerView){
        [bannerView removeFromSuperview];
    }
}

- (void)showNotRegisteredMode:(UIViewController *)controller {
    self.bounds = self.frame;
    self.buyNoAdsBtn.origin = CGPointMake(64.5, 329);
    self.continueBtn.origin = CGPointMake(64.5, 370.5);
    self.buyNoAdsBtn.hidden = NO;
    if (![self viewWithTag:BANNER_VIEW_TAG]){
        SMAdsComponent *component = [[SMAdsComponent alloc] init];
        UIView *view = [[SMAdsComponent sharedComponent] bannerForController:controller];
        view.tag = BANNER_VIEW_TAG;
        view.origin = CGPointMake(0, self.frame.size.height-50);
        [self addSubview:view];
    }
}


@end