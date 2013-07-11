//
//  EMKReentrantSerialQueue.m
//  SequentialProxy
//
//  Created by Benedict Cohen on 09/07/2013.
//  Copyright (c) 2013 Benedict Cohen. All rights reserved.
//

#import "EMKReentrantSerialQueue.h"



@implementation EMKReentrantSerialQueue
{
    dispatch_queue_t _queue;
}



-(id)init
{
    self = [super init];
    if (self == nil) return nil;
    
    NSString *name = [NSString stringWithFormat:@"%@.queue.%p", NSStringFromClass([self class]), self];
    _queue = dispatch_queue_create([name UTF8String], 0);
    
    return self;
}



-(void)performBlock:(void(^)(void))block
{
    //We have to be careful not to block the queue by recursively calling dispatch_sync() with the same queue.
    //We do this by storing a flag in the queue which we check before executing the block.
    const void * const queueKey = &_queue;
    void *active = (void *)queueKey;
    void *inactive = NULL;
    
    BOOL isAlreadyInQueue = (dispatch_get_specific(queueKey) != inactive);
    
    if (isAlreadyInQueue) {
        block();
    } else {
        dispatch_sync(_queue, ^{
            dispatch_queue_set_specific(_queue, queueKey, active, NULL);
            block();
            dispatch_queue_set_specific(_queue, queueKey, inactive, NULL);
        });
    }    
}

@end
