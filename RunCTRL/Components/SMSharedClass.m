//
// Created by dmitrykorotchenkov on 16.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SMSharedClass.h"

static NSString *const kIsRegisteredApp = @"isRegistered";

static NSString *const kRegisteredEmails = @"rigisteredEmails";

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

-(void)removeRegisteredEmails:(NSMutableArray *)emailsArray {
    NSArray *registeredEmails = [self getRegisteredEmails];
    [emailsArray removeObjectsInArray:registeredEmails];
}

- (NSArray *)getRegisteredEmails {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults synchronize];
    NSArray *registeredEmails = [userDefaults arrayForKey:kRegisteredEmails];
    return registeredEmails;
}

-(void)addEmailsToRegisteredEmails:(NSMutableArray *)array{
    NSMutableArray *registeredEmails = [NSMutableArray arrayWithArray:[self getRegisteredEmails]];
    [registeredEmails addObjectsFromArray:array];
    [self setRegisteredEmails:registeredEmails];

}

- (void)setRegisteredEmails:(NSMutableArray *)array {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:array forKey:kRegisteredEmails];
    [userDefaults synchronize];
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