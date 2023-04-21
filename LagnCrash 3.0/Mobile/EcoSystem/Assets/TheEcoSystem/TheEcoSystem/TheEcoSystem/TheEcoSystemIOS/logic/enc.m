//
//  enc.m
//  TheEcoSystemIOS
//
//  Created by Carl Ian Voller on 5/10/22.
//

#import <Foundation/Foundation.h>
#import "enc.h"
#import "magic.h"

@implementation SuperSecureEncryptionMechanismIOS

- (NSString*)encrypt:(NSString*)input
                    :(NSUserActivity*)activity {
    
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString *newString = [[input stringByReplacingOccurrencesOfString: @"0" withString:@"\x5D"] stringByReplacingOccurrencesOfString:@"P" withString:@"\x5E"];
    NSMutableString *final = [NSMutableString stringWithString:@""];
    
    for (int i = 0; i < [newString length]; i++) {
        NSString *character = [NSString stringWithFormat:@"%C", [newString characterAtIndex: i]];
        const char *charPointer = [character UTF8String];
        char charBuff[4] = "";
        magic(charPointer, charBuff);
        NSString *charString = [NSString stringWithCString:charBuff encoding:NSASCIIStringEncoding];
        [final appendString: charString];
    }
    
    NSData *plainData = [final dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encodedString = [plainData base64EncodedStringWithOptions:0];
    
    [activity setUserInfo: @{@"enc": encodedString, @"setby": bundleIdentifier, @"text": input}];
    
    return encodedString;
    
}

@end
