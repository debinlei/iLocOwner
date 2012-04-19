//
//  constants.h
//  iOwner
//
//  Created by ldb on 4/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#ifndef iOwner_constants_h
#define iOwner_constants_h

//the api for user registation 
//parameter is
//email, password, name all are needed
#define REST_API_REGISTER   @"http://mysquare.jelastic.servint.net/Application/Jregister?email=%@&password=%@&name=%@"

#define REST_API_LOGIN   @"http://mysquare.jelastic.servint.net/Application/Jlogin?email=%@&password=%@"

#define REST_API_ONETAKE   @"http://mysquare.jelastic.servint.net/Users/JOneTake?x=%d&y=%d"


#endif
