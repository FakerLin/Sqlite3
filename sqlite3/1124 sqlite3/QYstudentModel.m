//
//  QYstudentModel.m
//  1124 sqlite3
//
//  Created by qingyun on 15/11/24.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import "QYstudentModel.h"

@implementation QYstudentModel

+(instancetype)initWithNumber:(int) number WithName:(NSString *)name Age:(int)age Sex:(NSString *)sex Image :(UIImage *)icon
{
    QYstudentModel *student =[[QYstudentModel alloc]init];
    student.number=number;
    student.name =name;
    student.age =age;
    student.sex =sex;
    student.icon =icon;
    return student;
}
@end
