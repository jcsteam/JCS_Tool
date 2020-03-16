Config{
    "prefix":"JC_"
}

//这是第一个Model
//message Car {
//    optional string name = nil; //这是姓名
//    optional string color = nil; //这是颜色
//}
//
////这是第一个Model
//message Person {
//    desc 这是第一行备注
//    desc 这是第二行备注
//    desc 这是第三行备注
//
//    // 这是顶部备注
//    optional string name  =     nil; //这是行内备注
//
//    optional string address = @"上海市公安局";
//    optional int age=0;
//    optional float money=0;
//    optional double money2=0;
//    optional bool male = true;
//    optional model Car car = nil;
//    optional list<string> likes = nil;
//    optional dict<string,bool> addressInfo =    [NSMutableDictionary      dictionary]  ; //这是地址，带默认值的
//    optional Car car = nil; //我的汽车
//}

message Student extends Person {
    
}
