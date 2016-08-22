//
//  StoreMgr.h
//  testFMDB
//
//  Created by ky on 8/22/16.
//  Copyright © 2016 yellfun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreMgr : NSObject

+ (instancetype)sharedInstance;

- (void)saveDic:(NSDictionary*)dic;

- (NSDictionary*)query;

@end
