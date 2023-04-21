//
//  enc.h
//  The EcoSystem
//
//  Created by Carl Ian Voller on 5/10/22.
//

#import <Foundation/Foundation.h>

@interface SuperSecureEncryptionMechanism: NSObject
- (NSString*)encrypt:(NSString*)input
                    :(NSUserActivity*)activity;
@end

