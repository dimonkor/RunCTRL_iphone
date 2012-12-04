//
// Created by dmitrykorotchenkov on 11.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SMMainPageView.h"
#import "UIViewAdditions.h"
#import "SMUtils.h"
#import "SMSpeedType.h"
#import "SMMainPageController.h"
#import "SMSharedClass.h"
#import "SMAdsComponent.h"
#import "SMAudioComponent.h"

@interface SMMainPageView ()
@property(nonatomic, strong) UILabel *modSpeedLabel;
@property(nonatomic, strong) UILabel *divSpeedLabel;
@property(nonatomic, strong) UILabel *modCruiseSpeedLabel;
@property(nonatomic, strong) UILabel *divCruiseSpeedLabel;
@property(nonatomic, strong) UILabel *speedText;
@property(nonatomic, strong) UILabel *cruiseSpeedtype;
@property(nonatomic, strong) UILabel *speedtype;
@property(nonatomic, strong) UIButton *noAdsButton;
@property(nonatomic, strong) UIView *adBannerView;
@property(nonatomic) SMSpeedTextType currentSpeedType;


@end

@implementation SMMainPageView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [SMUtils getBackgroundColor];
        self.currentSpeedType = SMSpeedTextNormal;

        [self addSubview:[SMUtils createViewWithImage:[UIImage imageNamed:@"logoMainPage.png"] position:CGPointMake(0, 9.5)]];

        self.modSpeedLabel = [SMUtils createLabel:@"00" size:248 color:[UIColor whiteColor]];
        [self addSubview:self.modSpeedLabel];

        self.divSpeedLabel = [SMUtils createLabel:@".00" size:48 color:[UIColor whiteColor]];
        [self addSubview:self.divSpeedLabel];

        SMSpeedType *speedType = [[SMSpeedType alloc] initWithTextSize:30];
        speedType.left = 234;
        speedType.bottom = 206;
        self.speedtype = speedType;
        [self addSubview:speedType];

//        self.speedText = [SMUtils createLabel:@"slow down" size:49 color:UIColorMake(174, 67, 67)];
        self.speedText = [SMUtils createLabel:@"normal" size:49 color:UIColorMake(153, 153, 153)];
        [self addSubview:self.speedText];

        [self addSettingsView];

        self.noAdsButton = [SMUtils createButtonWithImage:[UIImage imageNamed:@"noAdsForMainPage.png"] position:CGPointMake(62, 375) target:nil action:@selector(gotoBuyNoAdsPage)];
        [self addSubview:self.noAdsButton];
    }

    return self;
}

-(void)changeSpeedText:(SMSpeedTextType)speedType{
    if (self.currentSpeedType == speedType)
        return;
    self.currentSpeedType = speedType;
    [self.speedText removeFromSuperview];
    if (speedType == SMSpeedTextFaster){
        self.speedText = [SMUtils createLabel:@"go faster" size:49 color:UIColorMake(66, 189, 72)];
    }
    else if (speedType == SMSpeedTextSlowDown) {
        self.speedText = [SMUtils createLabel:@"slow down" size:49 color:UIColorMake(174, 67, 67)];
    }
    else{
        self.speedText = [SMUtils createLabel:@"good speed" size:49 color:UIColorMake(153, 153, 153)];
    }
    [self addSubview:self.speedText];
}

-(void)addSettingsView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 297.5, 320, 58.5)];
    view.backgroundColor = UIColorMake(106, 106, 106);

    UILabel *label1 = [SMUtils createLabel:@"set your" size:26 color:[UIColor whiteColor]];
    [label1 setOrigin:CGPointMake(8, 8)];
    UILabel *label2 = [SMUtils createLabel:@"cruise speed" size:26 color:[UIColor whiteColor]];
    [label2 setOrigin:CGPointMake(8, 30)];

    [view addSubview:[SMUtils createButtonWithImage:[UIImage imageNamed:@"btnUp.png"]
                                           position:CGPointMake(221.5, 21)
                                             target:nil
                                             action:@selector(increaseCruiseSpeed)]];
    [view addSubview:[SMUtils createButtonWithImage:[UIImage imageNamed:@"btnDown.png"]
                                           position:CGPointMake(267, 21)
                                             target:nil
                                             action:@selector(decreaseCruiseSpeed)]];
    UILabel *label3 = [SMUtils createLabel:@"05" size:50 color:[UIColor whiteColor]];
    self.modCruiseSpeedLabel = label3;
    [view addSubview:label3];

    UILabel *label4 = [SMUtils createLabel:@".05" size:25 color:[UIColor whiteColor]];
    self.divCruiseSpeedLabel = label4;
    [view addSubview:label4];

    SMSpeedType *label5 = [[SMSpeedType alloc] initWithTextSize:25];
    self.cruiseSpeedtype = label5;
    [view addSubview:label5];

    [view addSubview:label1];
    [view addSubview:label2];

    [self addSubview:view];
}

- (void)layoutSubviews {
    [self layoutSpeed];
    [self layoutCruiseSpeed];
    
    [self.speedText sizeToFit];
    self.speedText.centerX = self.centerX;
    [self.speedText setOrigin:CGPointMake(self.speedText.origin.x, 244)];
}

- (void)layoutSpeed {
    [self.modSpeedLabel sizeToFit];
    [self.divSpeedLabel sizeToFit];
    self.modSpeedLabel.centerY = 178;   //r 237
    self.divSpeedLabel.centerY = 228;     // l 224
    self.modSpeedLabel.right = 236;
    self.divSpeedLabel.left = 226;
}

- (void)layoutCruiseSpeed {
    [self.modCruiseSpeedLabel sizeToFit];
    self.modCruiseSpeedLabel.right = 155;
    self.modCruiseSpeedLabel.bottom = 63;
    [self.divCruiseSpeedLabel sizeToFit];
    self.divCruiseSpeedLabel.left = 153;
    self.divCruiseSpeedLabel.bottom = 57;
    self.cruiseSpeedtype.left = self.divCruiseSpeedLabel.right;
    self.cruiseSpeedtype.bottom = 57;
}



-(void)setCruiseSpeed:(CGFloat)speed{
    _cruiseSpeed = speed;
    [self updateCruiseSpeedLabel];
}

- (void)updateCruiseSpeedLabel {
    CGFloat speed = self.cruiseSpeed;
    NSInteger mod = (NSInteger)speed /1;
    NSInteger div = (NSInteger)(speed * 100) % 100;
    if (self.modCruiseSpeedLabel && self.divCruiseSpeedLabel){
        self.modCruiseSpeedLabel.text = [NSString stringWithFormat:@"%0.2i",mod];
        self.divCruiseSpeedLabel.text = [NSString stringWithFormat:@".%0.2i",div];
        [self layoutCruiseSpeed];
    }
}

-(void)setCurrentSpeed:(CGFloat)speed{
    _currentSpeed = speed;
    [self updateCurrentSpeed];
}

- (void)updateCurrentSpeed {
    CGFloat speed = self.currentSpeed;
    NSInteger mod = (NSInteger)speed /1;
    NSInteger div = (NSInteger)(speed * 100) % 100;
    if (self.modSpeedLabel && self.divSpeedLabel){
        self.modSpeedLabel.text = [NSString stringWithFormat:@"%0.2i",mod];
        self.divSpeedLabel.text = [NSString stringWithFormat:@".%0.2i",div];
        [self layoutSpeed];
    }
}

- (void)showRegisteredMode {
    self.bounds = CGRectOffset(self.frame, 0, -50) ;
    self.noAdsButton.hidden = YES;

    UIView *bannerView = [self viewWithTag:BANNER_VIEW_TAG];
    if (bannerView){
        [bannerView removeFromSuperview];
    }
}

- (void)showNotRegisteredMode:(UIViewController *)controller {
    self.bounds = self.frame;
    self.noAdsButton.hidden = NO;
    if (![self viewWithTag:BANNER_VIEW_TAG]){
        SMAdsComponent *component = [[SMAdsComponent alloc] init];
        UIView *view = [[SMAdsComponent sharedComponent] bannerForController:controller];
        view.tag = BANNER_VIEW_TAG;
        view.origin = CGPointMake(0, self.frame.size.height-50);
        [self addSubview:view];
    }
}

@end