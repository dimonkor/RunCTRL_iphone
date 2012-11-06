//
// Created by dmitrykorotchenkov on 20.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface SMAudioComponent : NSObject

typedef enum{
    SMVibeModeSlower,
    SMVibeModeFaster,
    SMVibeModeNormal,
} SMVibeMode;

+ (SMAudioComponent *)sharedComponent;

- (SMVibeMode)currentMode;

- (void)changeMode:(SMVibeMode)mode;


@end