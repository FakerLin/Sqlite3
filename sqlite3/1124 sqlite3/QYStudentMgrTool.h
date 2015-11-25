//
//  QYStudentMgrTool.h
//  1124 sqlite3
//
//  Created by qingyun on 15/11/24.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QYstudentModel;
@interface QYStudentMgrTool : NSObject
//vvdocument 注释插件
//模型管理工具单例对象

+(instancetype)sharedStudentMgrTool;


//打开数据库

-(BOOL) openDB;

//关闭数据库
-(BOOL)closeDB;

//创建学生表

-(BOOL)createTable;

//插入学生记录

-(BOOL)insertStudent:(QYstudentModel *)student;

//删除学生记录
-(BOOL)deleteStudentbyID:(int)number;

//修改学生记录

-(BOOL)updateStudent :(QYstudentModel *) student;
//查询全部记录

-(NSArray *)selectAllStudents;
// 根据学号查询指定学生记录

-(QYstudentModel *)selectStudentbyID:(int)number;
//根据姓名查询学生  （可以重名）
-(NSArray *) selectStudentsByName:(NSString *)name;
@end
