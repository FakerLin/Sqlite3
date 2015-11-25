//
//  QYStudentMgrTool.m
//  1124 sqlite3
//
//  Created by qingyun on 15/11/24.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import "QYStudentMgrTool.h"
#import "QYstudentModel.h"
#include <sqlite3.h>
#define  kdbFile  @"student.db"
    static sqlite3 *_db;

@implementation QYStudentMgrTool

+(instancetype) sharedStudentMgrTool
{
    static  dispatch_once_t once;
    static QYStudentMgrTool *manager;
    dispatch_once(&once, ^{
        manager =[QYStudentMgrTool new];
        //创建学生记录表
        [manager createTable];
        NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]);
    
    });
    return manager;
    }
-(NSString *)documentPath
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

-(BOOL)openDB
{
    if (_db) {
        return YES;
    }
 int  resurt =  sqlite3_open([[[self documentPath] stringByAppendingPathComponent:kdbFile] UTF8String], &_db);
    if (resurt !=SQLITE_OK) {
        NSLog(@"%s",sqlite3_errmsg(_db));
        return NO;
    }
    return YES;
}
-(BOOL)closeDB
{
    if ((sqlite3_close(_db)!=SQLITE_OK)) {
        return NO;
    }
    //数据库连接句柄清零，是为了open链接是的判断
    _db=NULL;
    return YES;
}

-(BOOL)createTable
{
    //1打开数据库
    if (![self openDB]) {
        return NO;
    }
    //2编写sql语句
    NSString *sql =@"CREATE TABLE IF NOT EXISTS student(number  INTEGER PRIMARY KEY,name TEXT NOT NULL ,age INTEGER,sex TEXT,icon BLOB)";
    
    //NSString *sql =@"create table if not exists  student(number integer primary key,name text not null,age integer,sex text,icon blob)";
    
    //3执行sql语句
    char * errmsg;//出参
  int result =  sqlite3_exec(_db, [sql UTF8String], NULL, NULL, &errmsg);
    if (result !=SQLITE_OK) {
        [self closeDB];
        //释放存放失败字符串的内存
        sqlite3_free(errmsg);
        return NO;
    }
    //关闭数据库
    [self closeDB];
    return YES;
}

-(BOOL)insertStudent:(QYstudentModel *)student
{
    //打开数据库（创建数据库连接对象）
    if (![self openDB]) {
        return NO;
    }
    //编写sql语句
   NSString *sql =@"INSERT INTO student(number,name,age,sex,icon ) VALUES (?,?,?,?,?)";
    //  NSString *sql=@"insert into student (number,name,age,sex,icon) values(?,?,?,?,?)";
    //编译sql语句（生成预编译的语句对象）
    sqlite3_stmt *stmt;
   
    //第三个参数 -1意味著用sql字符窜的全部
    //第5个参数 NULL 不用关心 sql字符窜的地址
    int result = sqlite3_prepare_v2(_db, [sql UTF8String], -1, &stmt, NULL);
    if (result!=SQLITE_OK) {
        [self closeDB];
        return NO;
    }
    
    //绑定参数
    
    sqlite3_bind_int(stmt, 1, student.number);
    sqlite3_bind_text(stmt, 2, [student.name UTF8String], -1, NULL);
    sqlite3_bind_int(stmt, 3, student.age);
    sqlite3_bind_text(stmt, 4, [student.sex UTF8String], -1, NULL);
  //  sqlite3_bind_blob(stmt, 5, [NSData ui], int n, void (*)(void *))
    //执行step
    result =sqlite3_step(stmt);
    if (result!=SQLITE_DONE) {
        sqlite3_finalize(stmt);
        [self closeDB];
        NSLog(@"失败");
        return NO;
    }
    //销毁预编译的语句对象
     sqlite3_finalize(stmt);
    //关闭数据库（销毁数据库的连接对象）
    [self closeDB];
    NSLog(@"插入成功");
    return YES;
}

@end
