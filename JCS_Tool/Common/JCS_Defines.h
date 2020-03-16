//
//  JCS_Defines.h
//  JCS_Tool
//
//  Created by 永平 on 2020/3/16.
//  Copyright © 2020 yongping. All rights reserved.
//

#ifndef JCS_Defines_h
#define JCS_Defines_h

#define kConfigRegex @"Config(\\s*)\\{([\\s\\S]*?)\\}"

#define kDescRegex @"(desc)(?:\\s+)([\\s\\S]*)"
#define kCommentBlockRegex @"\\/\\*(\\s|.)*?\\*\\/"
#define kLineCommentRegex @"(?:\\s*)\\/\\/(?:\\s*)([\\s\\S]*)(?:\\s*)"

#define kMessageRegex @"message(?:\\s*)(\\S*)(?:\\s*)\\{([\\s\\S]*?)\\}(?:\\s*?)"
#define kMessageExtendsRegex @"message(?:\\s*)(\\S*)(?:\\s*)(?:extends)(?:\\s*)(\\S*)(?:\\s*)\\{([\\s\\S]*?)\\}(?:\\s*?)"
#define kMessagePropertyRegex @"(optional)(?:\\s+)(\\S*)(?:\\s*)(\\S*)(?:\\s*)=(?:\\s*)([\\s\\S\\[\\]]*)(?:\\s*);([\\s\\S]*)"

#define kEnumRegex @"enum(?:\\s*)(\\S*)(?:\\s*)\\{([\\s\\S]*?)\\}(?:\\s*?)"
#define kEnumPropertyRegex @"(?:\\s+)(\\S*)(?:\\s*)=(?:\\s*)([\\s\\S]*)(?:\\s*),([\\s\\S]*)"
#endif /* JCS_Defines_h */
