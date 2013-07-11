//
//  EMKReentrantSerialQueue.h
//  SequentialProxy
//
//  Created by Benedict Cohen on 09/07/2013.
//  Copyright (c) 2013 Benedict Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EMKReentrantSerialQueue : NSObject
-(void)performBlock:(void(^)(void))block;
@end
