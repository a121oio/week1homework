//
//  MoviesViewController.m
//  week1homework
//
//  Created by Weiyan Lin on 1/25/15.
//  Copyright (c) 2015 Weiyan Lin. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailViewController.h"
#import "SVProgressHUD.h"




@interface MoviesViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *movieTableView;
@property (nonatomic,strong) NSArray *names;
@property (nonatomic,strong) NSArray *movies;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UILabel *errorMessage;



@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.refreshControl = [[UIRefreshControl alloc]init];

    [self.refreshControl addTarget:self action:@selector(refreshList)forControlEvents: UIControlEventValueChanged];
    
    [self.movieTableView insertSubview:self.refreshControl atIndex:0];
    
    [self refreshList];

    
    self.movieTableView.dataSource = self;
    self.movieTableView.rowHeight = 128;
    self.movieTableView.delegate = self;
    
    [self.movieTableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    NSDictionary *movie = self.movies[indexPath.row];
    
    cell.title.text = movie[@"title"];
    cell.synopsis.text = movie[@"synopsis"];
    [cell.thumb setImageWithURL:[NSURL URLWithString:[movie valueForKeyPath:@"posters.thumbnail"]]];
    self.title = @"Movie";
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
    
}

static float progress = 0.0f;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MovieDetailViewController  *vc = [[MovieDetailViewController alloc]init];
    
    vc.movie = self.movies[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)refreshList{
    
    progress = 0.0f;
    [SVProgressHUD showProgress:0 status:@"Loading"];
    [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3f];
    
            NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=m9e32et84quj8swvuamhgzhw"];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError){
            self.errorMessage.text = @"Network Error!!! TOT";
            [self.refreshControl endRefreshing];

        
        } else {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            self.errorMessage.text = @"";
            
            self.movies = responseDictionary[@"movies"];
            [self.movieTableView reloadData];
            [self.refreshControl endRefreshing];
            
            NSLog(@"response: %@", self.movies);

            

        }
        
    }];
        
    
    

    

}

- (void)increaseProgress {
    progress+=0.3f;
    [SVProgressHUD showProgress:progress status:@"Loading"];
    
    if(progress < 1.0f)
        [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3f];
    else
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.4f];
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
