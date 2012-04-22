//
//  cucErrorBucket.m
//  cuconline
//
//  Created by ldb on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cucErrorBucket.h"

@implementation cucErrorBucket

@synthesize errors;

- (id)init
{
    if(self = [super init]) {
        self.errors = [NSMutableArray array];
    }
    // return...
    return self;
}

-(void)addError:(NSString *)error {
    [self.errors addObject:error];
}

-(BOOL)hasErrors
{
    if(self.errors.count > 0) 
        return TRUE;
    else
        return FALSE;
}

-(NSString *)errorsAsString {
    NSMutableString * builder = [NSMutableString string]; 
    for(NSString *error in self.errors)
    {
        if([builder length] > 0)
            [builder appendString:@"\n"];
        [builder appendString:error];
    }
    // return... return builder;
    return builder;
}

-(void)dealloc {
    [errors release]; 
    [super dealloc];
}

@end
