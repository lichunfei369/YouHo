//
//  FMDBDataBase.m
//  国通合众BIDemo
//
//  Created by 李荣建 on 2016/11/3.
//  Copyright © 2016年 李荣建. All rights reserved.
//

#import "FMDBDataBase.h"

@implementation FMDBDataBase
+ (FMDatabase *)sharedManager
{
    static FMDatabase *db = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        //1.获得数据库文件的路径
        NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
        NSString *fileName = [doc stringByAppendingPathComponent:@"GTBI.sqlite"];
        NSLog(@"%@",fileName);
        //2.获得数据库
        db = [FMDatabase databaseWithPath:fileName];
    });
    return db;
}
/*
 //版本迁移
 FMDBMigrationManager *manager = [FMDBMigrationManager managerWithDatabaseAtPath:fileName  migrationsBundle:[NSBundle mainBundle]];
 Migration * migration_1=[[Migration alloc]initWithName:@"新增USer表" andVersion:1 andExecuteUpdateArray:@[@"CREATE TABLE  if not exists User (Name text, age integer)"]];
 Migration * migration_2=[[Migration alloc]initWithName:@"USer表新增字段email" andVersion:2 andExecuteUpdateArray:@[@"alter table User add email text"]];
 Migration * migration_3=[[Migration alloc]initWithName:@"USer表新增字段phone" andVersion:3 andExecuteUpdateArray:@[@"alter table User add phone text",@"alter table User add sex text"]];
 Migration * migration_4=[[Migration alloc]initWithName:@"book表新增字段hh" andVersion:4 andExecuteUpdateArray:@[@"alter table book add hh text"]];
 
 [manager addMigration:migration_1];
 [manager addMigration:migration_2];
 [manager addMigration:migration_3];
 [manager addMigration:migration_4];
 
 BOOL resultState=NO;
 NSError * error=nil;
 if (!manager.hasMigrationsTable) {
 resultState=[manager createMigrationsTable:&error];
 }
 
 resultState=[manager migrateDatabaseToVersion:UINT64_MAX progress:nil error:&error];
 [migration_1 migrateDatabase:self.db error:&error];
 [migration_2 migrateDatabase:self.db error:&error];
 [migration_3 migrateDatabase:self.db error:&error];
 [migration_4 migrateDatabase:self.db error:&error];
 NSLog(@"Has `schema_migrations` table?: %@", manager.hasMigrationsTable ? @"YES" : @"NO");
 NSLog(@"Origin Version: %llu", manager.originVersion);
 NSLog(@"Current version: %llu", manager.currentVersion);
 NSLog(@"All migrations: %@", manager.migrations);
 NSLog(@"Applied versions: %@", manager.appliedVersions);
 NSLog(@"Pending versions: %@", manager.pendingVersions);
 */


@end
