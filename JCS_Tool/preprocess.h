Config{
    "prefix":"HKUser",
    "responseModel":"CommonResponse",
    "signalRequest":true
}
import.class = Person
import.lib = Person/Person
import.lib = Student/Student.h
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
request post getUserInfo list<Person> /getUserInfo.action {
    desc 获取用户信息接口
}
request post getUserInfo2 list /getUserInfo.action {
    desc 获取用户信息接口-list
}
message GoodsTypeInfo {
    desc 商品类型信息
    optional int id = 0;
    optional bool isDisabled = false;
    optional string title = nil;
}
request post getGoodsTypeList list /flyfish/goodstype/getList.action {
    desc 获取商品类型列表
}
request get getGoodsTypeListGet list /flyfish/goodstype/getList-get.action {
    desc 获取商品类型列表
}
message AboutApp {
    desc AboutApp
    optional string companyName = nil; //公司名称
    optional string fullAppLogo = nil; //logo全地址
    optional string appName = nil; //appName
    optional string appIntroduction = nil; //app介绍
    optional string appCustomerService = nil; //客服电话
    optional string website = nil; //公司网址
}
request post getAboutApp AboutApp /flyfish/params/aboutApp.action {
    desc 获取关于App
}