//
//  MovieDetailViewController.m
//  week1homework
//
//  Created by Weiyan Lin on 1/25/15.
//  Copyright (c) 2015 Weiyan Lin. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "SVProgressHUD.h"
#import "UIImageView+AFNetworking.h"


@interface MovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *detailTitle;
@property (weak, nonatomic) IBOutlet UIScrollView *myscrollView;
@property (weak, nonatomic) IBOutlet UIImageView *background;

@property (weak, nonatomic) IBOutlet UILabel *detailSynopsis;
@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.movie[@"title"];
    NSString *path =[self.movie valueForKeyPath:@"posters.thumbnail"];
    
    path = [path stringByReplacingOccurrencesOfString:@"tmb"
                                    withString:@"ori"];
    NSLog(@"%@",path);
    
    [self.background setImageWithURL:[NSURL URLWithString:path]];
    
    
    NSInteger offset = 350;
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, offset, 320, self.view.frame.size.height)];
    
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.alpha = 0.9;
    [self.myscrollView addSubview:contentView];
    
    
    //[self.view addSubview:self.background];
    UILabel *title =[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
    UILabel *syno =[[UILabel alloc] initWithFrame:CGRectMake(10, 50, 300, 20)];
    
    syno.text = self.movie[@"synopsis"];
    title.text = self.movie[@"title"];
    syno.numberOfLines = 0;
    [syno sizeToFit];
    [contentView addSubview:syno];
    [contentView addSubview:title];
    
    
    
    float scrollHeight = offset + contentView.frame.size.height - self.navigationController.toolbar.frame.size.height;
    [self.myscrollView setContentSize: CGSizeMake(320, scrollHeight)];
    // Do any additional setup after loading the view from its nib.
    [self.view bringSubviewToFront:self.myscrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
