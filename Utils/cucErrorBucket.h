//
//  cucErrorBucket.h
//  cuconline
//
//  Created by ldb on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cucErrorBucket : NSObject{
    NSMutableArray *errors;
}

@property (nonatomic, retain) NSMutableArray *errors;
-(void)addError:(NSString *)error; 
-(BOOL)hasErrors;
-(NSString *)errorsAsString;

@end
