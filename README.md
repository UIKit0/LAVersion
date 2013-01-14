LAVersion
==========

Luis Ascorbe

Tweet me [@LuisEAM](http://twitter.com/luiseam)

`LAVersion` automatically check if there is a new version for your app in the App Store.

![Screenshot of LAVersion](https://raw.github.com/Lascorbe/LAVersion/master/captura.png  "LAVersion Screenshot")


Example
==========
Build and run the `LAVersionExample` project in Xcode to see `LAVersion` in action.


Requeriments
==========

`LAVersion` can be used in iOS5 and iOS6. Work with ARC and non-ARC projects.

· Xcode 4.5 or higher

· Apple LLVM compiler

· iOS 5.0 or higher


Instructions
==========

Just drag and drop the project files to your project, then add the following libraries:

AFNetworking:
- SystemConfiguration.framework 
- MobileCoreServices.framework 

Note: If you are not using ARC in your project, add `-fobjc-arc` as a compiler flag for the `AFNetworking` classes.


Usage
==========

Init with two modes:

- First mode (just check for new version):
``` objective-c
    [[LAVersion sharedInstance] checkAppVersion:YES];
```

- Second mode (delegate):
``` objective-c
    laVersion = [LAVersion sharedInstance];
    laVersion.delegate = self;
    [laVersion checkAppVersion:YES];
```
NOTE: using `sharedInstance` you don't need to release it


Actions
==========
``` objective-c
- (void) checkAppVersion:(BOOL)showMessage;
```


Credits
==========

Mattt Thompson and Scott Raymond creators of [AFNetworking](https://github.com/AFNetworking/AFNetworking)


License
=======

`LAVersion` is distributed under the terms and conditions of the MIT license. 

Copyright (c) 2012 Luis Ascorbe

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
