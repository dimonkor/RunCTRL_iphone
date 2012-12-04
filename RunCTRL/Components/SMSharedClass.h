//
// Created by dmitrykorotchenkov on 16.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

#define BANNER_VIEW_TAG 75167

@interface SMSharedClass : NSObject

@property(nonatomic) BOOL speedTypeIsMiles;

@property(nonatomic) CGFloat cruiseSpeed;

@property(nonatomic) BOOL isRegistered;

+ (SMSharedClass *)sharedClass;

- (void)removeRegisteredEmails:(NSMutableArray *)emailsArray;

- (void)addEmailsToRegisteredEmails:(NSMutableArray *)array;


- (void)changeSpeedType;


@end