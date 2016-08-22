//
//  StoreMgr.m
//  testFMDB
//
//  Created by ky on 8/22/16.
//  Copyright © 2016 yellfun. All rights reserved.
//

#import "StoreMgr.h"
#import <FMDBManager/FMDBManager.h>

static StoreMgr *_instance = nil;

@interface StoreMgr()

@property (nonatomic, retain) FMDatabase *db;

@end

@implementation StoreMgr

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        if (!_instance) {
            
            _instance = [[super allocWithZone:NULL] init];
        }
    });
    
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    
    return [self sharedInstance];
}

- (id)init {
    
    self = [super init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString *dbPath = [documentDirectory stringByAppendingString:@"/MyDatabase.db"];
    
    _db = [FMDatabase databaseWithPath:dbPath];
    
    [_db open];
    
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS dicData (name text PRIMARY KEY,mystate blob)"];
    
    [_db close];
    
    return self;
}

- (void)saveDic:(NSDictionary*)dic {
    
    NSData * JSONData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    [_db open];
    
    [_db executeUpdate:@"REPLACE INTO dicData values (?,?)", @"121212", JSONData];
    
    [_db close];
}

- (NSDictionary*)query {
    
    [_db open];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT mystate FROM dicData WHERE name='%@'", @"121212"];
    
    FMResultSet *results = [_db executeQuery:sql];
    
    while ([results next]) {
        
        NSData * JSONData = results[@"mystate"];
        
        [_db close];
        
        return [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    }
    
    return nil;
}

@end
