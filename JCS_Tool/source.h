Config{
    "prefix":"JC2_",
    "responseModel":"CommonResponse"
}

//message A extends B{
//
//}
//
//message B extends C{
//
//}
//
//message B2 extends C{
//
//}
//
//message C extends D{
//
//}
//
//message C2 extends D{
//
//}
//
//message D{
//
//}

message Person {
    desc Person 第一行 注释
    desc Person 第二行 注释
    optional dict addressInfo =    [NSMutableDictionary      dictionary]  ;
    optional string name = @"张三"; //  aa  姓名
    optional list likes = nil; //这是我的喜好
    optional Person person = nil;
    optional CarType carType = bieke; //我有一辆汽车
    optional Sex sex = male;
//    optional Object obj = nil;
}


message Student extends Person {
    /* yyyyy **/

    /* eeeee **/
    optional string studentNo = @"0001"; //学号
    optional string address = @"上海市公安局";
    optional Person teacher = nil;

    /* rrrrr **/

}

/**
 asdfajslsd
 asdfjakld
 adsfjlkasdf
 asdfaj
 */
message Student2 extends Student {
    optional string studentNo = @"0002"; //学号
    /* qqqqqq **/



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

//获取用户信息接口
request post getUserInfo list<Person> /getUserInfo.action {
    desc 获取用户信息接口
}

request get getBannerList Student2 /getBannerList.action {
    desc 获取用户信息接口2
}

request get getBannerList2 dict /getBannerList.action {
    desc 获取用户信息接口3
}

request get getBannerList3 nil /getBannerList.action {
    desc 获取用户信息接4
}


/* pppppppppp **/
/* pppppppppp **/
/* pppppppppp **/
/* pppppppppp **/
/* pppppppppp **/
