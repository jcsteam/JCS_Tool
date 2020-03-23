Config{
    "prefix":"JCUser",
    "responseModel":"CommonResponse"
}

enum Sex {
    desc 这是性别枚举
    male = 1,   //男
    female = 2, //女
}

message Person {
    desc 用户信息实体类
    optional string name = @"张三"; //姓名
    optional Sex sex = male; //性别
}

request get getPersonInfoById Person /getUserInfo.action {
    desc 获取用户信息
    optional int userId = 0; //用户ID
}
