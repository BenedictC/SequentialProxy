//
//  EMKSequentialProxy.h
//  SequentialProxy
//
//  Created by Benedict Cohen on 09/07/2013.
//  Copyright (c) 2013 Benedict Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EMKReentrantSerialQueue;



//TODO: Should we use MAProxy instead? http://www.mikeash.com/pyblog/friday-qa-2010-02-26-futures.html
@interface EMKSequentialProxy : NSProxy

//Note that the return type is id and not instancetype. This is so that the return value can be assigned to a variable
//of type object.
+(id)sequentialProxyWithObject:(id)object serialQueue:(EMKReentrantSerialQueue *)serialQueue;

@end
