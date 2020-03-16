Config{
    "prefix":"JC2_"
}
message Person {
    desc Person 第一行 注释
    desc Person 第二行 注释
    optional dict addressInfo =    [NSMutableDictionary      dictionary]  ;
    optional string name = @"张三"; //  aa  姓名
    optional list likes = nil; //这是我的喜好
    optional Person person = nil;
    optional CarType carType = bieke; //我有一辆汽车
    optional Sex sex = male;
}
message Student extends Person {
    optional string studentNo = @"0001"; //学号
    optional string address = @"上海市公安局";
    optional Person teacher = nil;
}
message Student2 extends Student {
    optional string studentNo = @"0002"; //学号
}
enum Sex {
    desc 这是性别枚举
    desc Sex 第二行 注释
    desc Sex 第三行 注释
    male = 1,     //    家居
    female = 2, //ajjda 
}
enum CarType {
    desc 骑车类型
    desc Sex 第二行 注释
    desc Sex 第三行 注释
    bwm = 1, //aaaa
    bieke = 2, //ddddd
}