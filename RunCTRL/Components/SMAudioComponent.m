//
// Created by dmitrykorotchenkov on 20.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <AudioToolbox/AudioToolbox.h>
#import "SMAudioComponent.h"


@interface SMAudioComponent ()
@property(nonatomic) SMVibeMode vibeMode;

@end

@implementation SMAudioComponent {

}

- (id)init {
    self = [super init];
    if (self) {
        self.vibeMode = SMVibeModeNormal;
    }

    return self;
}


+(SMAudioComponent *)sharedComponent{
    static SMAudioComponent *class = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        class = [[SMAudioComponent alloc] init];
    });
    return class;
}

-(SMVibeMode)currentMode{
    return self.vibeMode;
}

-(void)changeMode:(SMVibeMode)mode{
    if (mode == self.vibeMode)
        return;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (mode==SMVibeModeSlower){
        [self startSlowerVibe];
        self.vibeMode = SMVibeModeSlower;
        NSLog(@"Slower") ;
    }
    else if (mode == SMVibeModeFaster){
        [self startFasterVibe];
        self.vibeMode = SMVibeModeFaster;
        NSLog(@"Faster") ;
    }
    else{
        self.vibeMode = SMVibeModeNormal;
        NSLog(@"Normal") ;
    }
}

-(void)doVibration{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

-(void)startFasterVibe{
    [self performSelector:@selector(doVibration) withObject:nil afterDelay:0];
    [self performSelector:@selector(doVibration) withObject:nil afterDelay:0.7];
    [self performSelector:@selector(doVibration) withObject:nil afterDelay:1.4];
    [self performSelector:@selector(startFasterVibe) withObject:nil afterDelay:4];
}

-(void)startSlowerVibe{
    [self doVibration];
    [self performSelector:@selector(startSlowerVibe) withObject:nil afterDelay:1.5];

}



@end