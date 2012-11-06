//
// Created by dmitrykorotchenkov on 16.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SMSpeedType.h"
#import "SMUtils.h"
#import "SMMainPageController.h"
#import "SMSharedClass.h"

@implementation SMSpeedType

- (id)initWithTextSize:(CGFloat)size {
    self = [super init];
    if (self) {
        [SMUtils customizeLabel:self title:[SMSharedClass sharedClass].speedTypeIsMiles ? @"mph" : @"kmh" size:size color:UIColorMake(153, 153, 153)];
        [self sizeToFit];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSpeedType) name:DID_CHANGE_SPEED_TYPE object:nil];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeSpeedType)]];
        [self setUserInteractionEnabled:YES];
    }

    return self;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)updateSpeedType{
    self.text = [SMSharedClass sharedClass].speedTypeIsMiles ? @"mph" : @"kmh";
    [self sizeToFit];
}

-(void)changeSpeedType{
    [[SMSharedClass sharedClass] changeSpeedType];
    [[NSNotificationCenter defaultCenter] postNotificationName:DID_CHANGE_SPEED_TYPE object:nil];
}


@end