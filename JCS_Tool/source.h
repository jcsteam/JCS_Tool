Config{
    "prefix":"HKUser",
    "responseModel":"CommonResponse",
    "signalRequest":true
}

message Person {
}

//get方式请求用户信息，data类型为NSDictionary
request get getUserInfo1 nil /getUserInfo.action {
    desc 获取用户信息接
    optional int userId; // 用户ID
}

//post方式请求用户信息，data类型为Person
request get getUserInfo2 Person /getUserInfo.action { }

// post方式获取用户列表，data类型为NSArray
request post getUserList1 list /getUserList.action {}

// post方式获取用户列表，data类型为NSArray<Person>
request post getUserList2 list<Person> /getUserList.action {}
