//
// Created by dmitrykorotchenkov on 16.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SMSharedClass.h"

static NSString *const kIsRegisteredApp = @"isRegistered";

@implementation SMSharedClass {

}

+ (SMSharedClass *)sharedClass {
    static SMSharedClass *class = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        class = [[SMSharedClass alloc] init];
    });
    return class;
}

- (id)init {
    self = [super init];
    if (self) {
        self.speedTypeIsMiles = YES;
        self.cruiseSpeed = 5;
    }

    return self;
}

-(void)changeSpeedType{
    CGFloat tmp;
    if (self.speedTypeIsMiles){
        tmp = self.cruiseSpeed/0.621371;
        self.speedTypeIsMiles = NO;
    }
    else{
        tmp = self.cruiseSpeed*0.621371;
        self.speedTypeIsMiles = YES;
    }
    tmp = tmp*2;
    self.cruiseSpeed = lroundf(tmp/2);
}

-(void)setIsRegistered:(BOOL)isRegistered {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isRegistered forKey:kIsRegisteredApp];
    [userDefaults synchronize];
}

-(BOOL)isRegistered {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults synchronize];
    return [userDefaults boolForKey:kIsRegisteredApp];
}

@end