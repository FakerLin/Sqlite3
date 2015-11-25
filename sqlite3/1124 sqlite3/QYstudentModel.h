//
//  QYstudentModel.h
//  1124 sqlite3
//
//  Created by qingyun on 15/11/24.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;
@interface QYstudentModel : NSObject
@property(nonatomic,strong) NSString *name;
@property(nonatomic) int number;
@property(nonatomic) int age;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong) UIImage *icon;

+(instancetype)initWithNumber:(int) number WithName:(NSString *)name Age:(int)age Sex:(NSString *)sex Image :(UIImage *)icon;
@end
