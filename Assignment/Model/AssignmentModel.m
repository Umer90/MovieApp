//
//  AssignmentModel.m
//  Assignment
//
//  Created by UmerWasi on 9/6/19.
//  Copyright © 2019 InvisionSolutions. All rights reserved.
//

#import "AssignmentModel.h"

static NSDictionary *assignment;

@implementation AssignmentModel
    
+(void)setData:(NSDictionary *)assignmentAppResponse {
    assignment = assignmentAppResponse;
}
    
+(NSDictionary *)getData {
    return assignment;
}
    
@end
