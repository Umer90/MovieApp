//
//  MovieController.h
//  Assignment
//
//  Created by UmerWasi on 9/6/19.
//  Copyright © 2019 InvisionSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    BOOL isFromSearch;
    NSString *query;
    NSArray *filteredMovieList;
    NSMutableArray *arrMovieList,*arrSearchHistory;
}

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger totalPages;
    
@property (strong, nonatomic) IBOutlet UITableView *tableViewMovieList;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBarMovieList;
@property (strong, nonatomic) IBOutlet UIPickerView *viewPicker;

@end

NS_ASSUME_NONNULL_END
