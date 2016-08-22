//
//  ViewController.m
//  testFMDB
//
//  Created by ky on 8/22/16.
//  Copyright © 2016 yellfun. All rights reserved.
//

#import "ViewController.h"
#include "StoreMgr.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)selector:(id)sender {
    
    NSDictionary *dic = @{@"name":@"yanli"};
    
    [[StoreMgr sharedInstance] saveDic:dic];
}

- (IBAction)selector2:(id)sender {
    
    NSDictionary *dic = [[StoreMgr sharedInstance] query];
    
    NSLog(@"%@-----------", [dic objectForKey:@"name"]);
}

@end
