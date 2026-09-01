#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CHSWidgetDescriptor : NSObject
@property (nonatomic, copy, readonly) NSString *extensionIdentifier;
@property (nonatomic, copy, readonly) NSString *kind;
@end

@interface CHSMutableWidgetDescriptor : CHSWidgetDescriptor
- (void)setBackgroundRemovable:(BOOL)removable;
- (void)setTransparent:(BOOL)transparent;
- (void)setPreferredBackgroundStyle:(NSInteger)style;
- (void)applyWeatherTransparency;
@end

%hook CHSMutableWidgetDescriptor

- (instancetype)init {
    self = %orig;
    if (self) {
        [self applyWeatherTransparency];
    }
    return self;
}

- (instancetype)initWithExtensionIdentifier:(NSString *)extensionIdentifier kind:(NSString *)kind {
    self = %orig;
    if (self) {
        [self applyWeatherTransparency];
    }
    return self;
}

- (void)applyWeatherTransparency {
    @try {
        NSString *extId = self.extensionIdentifier;
        if (extId && [extId.lowercaseString containsString:@"weather"]) {
            NSLog(@"[WeatherWidgetClear] Applying transparency to: %@ kind: %@", extId, self.kind);
            if ([self respondsToSelector:@selector(setBackgroundRemovable:)]) {
                [self setBackgroundRemovable:YES];
            }
            if ([self respondsToSelector:@selector(setTransparent:)]) {
                [self setTransparent:YES];
            }
            if ([self respondsToSelector:@selector(setPreferredBackgroundStyle:)]) {
                [self setPreferredBackgroundStyle:1]; // 1 = transparent
            }
        }
    } @catch (NSException *e) {
        NSLog(@"[WeatherWidgetClear] Error: %@", e);
    }
}

%end
