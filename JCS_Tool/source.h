Config{
    "prefix":"HKUser",
    "responseModel":"CommonResponse",
    "signalRequest":true
}

import.class = Person
import.class = Dog
//import.lib = Person/Person
//import.lib = Student/Student.h

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
    optional Dog dog = nil; //宠物
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

request get getBannerList Student2 /getBannerList.action {
    desc 获取用户信息接口-Student2
    desc 获取用户信息接口-Student2-2
    desc 获取用户信息接口-Student2-3
    optional string classNo = nil; //班级号
    optional int bannerType = nil; //banner号
    optional CarType carType = 0; //卡车类型
}

request get getBannerList2 dict /getBannerList.action {
    desc 获取用户信息接口-dict
}


request get getBannerList3 nil /getBannerList.action {
    desc 获取用户信息接-nil
}

//获取用户信息接口
request post getUserInfo list<Person> /getUserInfo.action {
    desc 获取用户信息接口
}

//获取用户信息接口2
request post getUserInfo2 list /getUserInfo.action {
    desc 获取用户信息接口-list
}


message GoodsTypeInfo {
    desc 商品类型信息
    optional int id = 0;
    optional bool isDisabled = false;
    optional string title = nil;
}

/// 获取商品类型列表
request post getGoodsTypeList list /flyfish/goodstype/getList.action {
    desc 获取商品类型列表
}

/// 获取商品类型列表
request get getGoodsTypeListGet list /flyfish/goodstype/getList-get.action {
    desc 获取商品类型列表
}


message AboutApp {
    desc AboutApp
    
//    "appCustomerService": "18206419950",
//    "appIntroduction": "https://www.jiakeniu.com/company-introduce.html",
//    "appName": "",
//    "companyName": "南通千石环保科技有限公司",
//    "fullAppLogo": "http://static.jiakeniu.com/FifBx43lSjzT3UGeKoeSGNv31qU1",
//    "website": "https://www.jiakeniu.com"
    
    optional string companyName = nil; //公司名称
    optional string fullAppLogo = nil; //logo全地址
    optional string appName = nil; //appName
    optional string appIntroduction = nil; //app介绍
    optional string appCustomerService = nil; //客服电话
    optional string website = nil; //公司网址
}

/// 获取关于App
request post getAboutApp AboutApp /flyfish/params/aboutApp.action {
    desc 获取关于App
}


/* pppppppppp **/
/* pppppppppp **/
/* pppppppppp **/
/* pppppppppp **/
/* pppppppppp **/
