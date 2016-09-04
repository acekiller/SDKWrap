//
//  NSError+Wrap.m
//  SDKWrap
//
//  Created by Fantasy on 16/9/2.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "NSError+Wrap.h"

@implementation NSError (Wrap)

- (NSString *)errorTitle {
    return self.localizedFailureReason;
}
- (NSString *)errorDescription {
    return self.localizedDescription;
}

@end
