//
//  MovieController.m
//  Assignment
//
//  Created by UmerWasi on 9/6/19.
//  Copyright © 2019 InvisionSolutions. All rights reserved.
//

#import "MovieController.h"
#import "MovieCell.h"

@interface MovieController ()

@end

@implementation MovieController

@synthesize currentPage,totalPages,tableViewMovieList,searchBarMovieList,viewPicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setInitialElements];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)setInitialElements{
    currentPage = 1;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    arrSearchHistory = [[NSMutableArray alloc]initWithArray:[userDefaults objectForKey:@"arrayMovieSearch"]];
    
    NSRange endRange = NSMakeRange(arrSearchHistory.count >= 10 ? arrSearchHistory.count - 10 : 0, MIN(arrSearchHistory.count, 10));
    NSArray *lastElements= [arrSearchHistory subarrayWithRange:endRange];
    arrSearchHistory = [NSMutableArray arrayWithArray:lastElements];

    if (arrSearchHistory.count == 0) {
        arrSearchHistory = [[NSMutableArray alloc]init];
    }
    
    arrMovieList = [[NSMutableArray alloc]init];
    
    tableViewMovieList.dataSource = self;
    tableViewMovieList.delegate = self;
    searchBarMovieList.delegate = self;
    viewPicker.dataSource = self;
    viewPicker.delegate = self;
    
    tableViewMovieList.hidden = YES;
    viewPicker.hidden = YES;
    [searchBarMovieList becomeFirstResponder];
}

- (void)getMoviesData:(NSInteger)moviePageNo
{    
    NSString *completeURL = [NSString stringWithFormat:@"%@?api_key=%@&query=%@&page=%ld",CALL_MOVIE,API_KEY,query,moviePageNo];
    [NetworkHelper getServicesInfo:completeURL :self withCompletionHandler:^(NSDictionary *response, NSError *error) {
        NSArray *tempResults = [[NSArray alloc]init];
        tempResults = response[MovieResults];
        if (tempResults.count > 0) {
            [self->arrMovieList addObjectsFromArray:response[MovieResults]];
            
            self.currentPage = [response[MoviePage]integerValue];
            self->totalPages = [response[MovieTotalPages]integerValue];
            
            if (self->isFromSearch) {
                if (![self->arrSearchHistory containsObject:self->query])
                {
                    [self->arrSearchHistory addObject:self->query];

                    NSRange endRange = NSMakeRange(self->arrSearchHistory.count >= 10 ? self->arrSearchHistory.count - 10 : 0, MIN(self->arrSearchHistory.count, 10));
                    NSArray *lastElements= [self->arrSearchHistory subarrayWithRange:endRange];
                    self->arrSearchHistory = [NSMutableArray arrayWithArray:lastElements];

                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:self->arrSearchHistory forKey:@"arrayMovieSearch"];
                    [userDefaults synchronize];
                }
            }
            
            [self.tableViewMovieList reloadData];
        }
        else{
            if (response) {
                [sharedHelper showMessage:MSG_INVALID_QUERY withTitle:TITLE_INVALID_QUERY :self];
            }
            else{
                [sharedHelper showMessage:MSG_CHECK_LATER withTitle:TITLE_CHECK_LATER :self];
            }
        }
    }];
}

#pragma mark - UITableView Delegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrMovieList.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tblCellMovie"];
    
    NSDictionary *dictMovieList = [arrMovieList objectAtIndex:indexPath.row];
    
    cell.lblMovieName.text = dictMovieList[MovieTitle];
    cell.lblReleaseDate.text = dictMovieList[MovieReleaseDate];
    cell.lblFullMovieOverview.text = dictMovieList[MovieOverview];
    
    NSURL*posterURL= [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",CALL_POSTER,POSTER_SIZE,dictMovieList[MoviePosterPath]]];
    [cell.imgMoviePoster sd_setImageWithURL:posterURL placeholderImage:[UIImage imageNamed:@"Placeholder.png"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.currentPage < self.totalPages && indexPath.row == [arrMovieList count]-1)
    {
        isFromSearch = NO;
        [self getMoviesData:++self.currentPage];
    }
}

#pragma mark - UISearchBar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    searchBarMovieList.showsCancelButton = YES;
    tableViewMovieList.hidden = YES;
    if (arrSearchHistory.count!=0) {
        viewPicker.hidden = NO;
    }
    [viewPicker reloadAllComponents];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    isFromSearch = YES;
    tableViewMovieList.hidden = NO;
    viewPicker.hidden = YES;
    [searchBar resignFirstResponder];
    query = [sharedHelper removedSpacesInString:searchBar.text];
    currentPage = 1;
    arrMovieList = [[NSMutableArray alloc]init];
    [tableViewMovieList reloadData];
    [self getMoviesData:currentPage];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    tableViewMovieList.hidden = NO;
    viewPicker.hidden = YES;
    searchBar.text = @"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

#pragma mark - UIPicker Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return arrSearchHistory.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return arrSearchHistory[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    searchBarMovieList.text = arrSearchHistory[row];
    [self searchBarSearchButtonClicked:searchBarMovieList];
}

@end
