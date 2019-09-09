//
//  AssignmentModel.h
//  Assignment
//
//  Created by UmerWasi on 9/6/19.
//  Copyright © 2019 InvisionSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AssignmentModel : NSObject

+(void)setData:(NSDictionary *)kashAppResponse;
+(NSDictionary *)getData;

@end

NS_ASSUME_NONNULL_END
