//
//  MovieCell.h
//  Assignment
//
//  Created by UmerWasi on 9/6/19.
//  Copyright © 2019 InvisionSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieCell : UITableViewCell
    
@property (strong, nonatomic) IBOutlet UILabel *lblMovieName;
@property (strong, nonatomic) IBOutlet UILabel *lblReleaseDate;
@property (strong, nonatomic) IBOutlet UILabel *lblFullMovieOverview;
@property (strong, nonatomic) IBOutlet UIImageView *imgMoviePoster;
    
@end

NS_ASSUME_NONNULL_END
