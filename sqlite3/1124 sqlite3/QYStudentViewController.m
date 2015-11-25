//
//  QYStudentViewController.m
//  1124 sqlite3
//
//  Created by qingyun on 15/11/25.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import "QYStudentViewController.h"
#import "QYStudentMgrTool.h"
#import "QYstudentModel.h"
@interface QYStudentViewController ()
@property (weak, nonatomic) IBOutlet UITextField *number;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *sex;
@property (weak, nonatomic) IBOutlet UITextField *icon;

@end

@implementation QYStudentViewController
- (IBAction)Save:(UIButton *)sender {
    QYstudentModel *model =[QYstudentModel initWithNumber:[_number.text intValue] WithName:_name.text Age:[_age.text intValue] Sex:_sex.text Image:NULL];
    QYStudentMgrTool *student =[QYStudentMgrTool sharedStudentMgrTool];
    [student insertStudent:model];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)endFirst:(UITextField *)sender {
    [sender resignFirstResponder];
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
