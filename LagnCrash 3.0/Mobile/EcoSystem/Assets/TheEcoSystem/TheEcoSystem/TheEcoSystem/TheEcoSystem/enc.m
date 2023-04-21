//
//  enc.m
//  The EcoSystem
//
//  Created by Carl Ian Voller on 5/10/22.
//

#import <Foundation/Foundation.h>
#import "enc.h"
#import "math.h"

@implementation SuperSecureEncryptionMechanism

- (NSString*)encrypt:(NSString*)input
                    :(NSUserActivity*)activity {
    
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    
    const char *inputPointer = [input UTF8String];
    char finalString[65535] = "";
    math(inputPointer, finalString);
    
    NSString *finalStringBefore = [NSString stringWithCString:finalString encoding:NSASCIIStringEncoding];
    NSData *plainData = [finalStringBefore dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encodedString = [plainData base64EncodedStringWithOptions:0];
    
    [activity setUserInfo: @{@"enc": encodedString, @"setby": bundleIdentifier, @"text": input}];
    
    return encodedString;
    
}

@end
