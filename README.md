Events Manager v1.0
======
An **iOS** app for Cornell students to find events. The **Android** branch can be found [here](https://github.com/cornell-dti/events-manager-android).

Getting Started
------
You will need **Xcode 9.2** to run the latest version of this app, which uses Swift 4 compiled for iOS 11. Xcode can be downloaded from the Mac App Store. Make sure you are not running a beta version of macOS, as Apple will prevent you from publishing to the App Store if you do.

Design Choices
------
 * Document every function and at the start of every class/enum/protocol. [Here](http://nshipster.com/swift-documentation) are the guidelines for documentation.
 * Syntax:
   * Indent with tabs.
   * If a statement fits in a single line, curly braces don't have to go on a new line, like so:
   ```swift
   if (blah) {
      doSomething();
   }
   ```
   This is especially true for <code>get</code> and <code>guard</code> statements, where the curly braces aren't allowed to be on a new line.
   * ClassesShouldBeNamedLikeThis, as should enums and protocols. (upper camel case)
   * functionsShouldBeNamedLikeThis, as should non-static variables or let constants. (lower camel case)
   * STATIC_VARS_SHOULD_BE_NAMED_LIKE_THIS, as should any let constants (or variables whose values shouldn't be changed).
 
Used Libraries
------
Unlike Android, which manages its dependencies through Gradle, iOS requires CocoaPods and the editing of the Podfile in the main project directory. If you don't have CocoaPods installed on your computer, follow the instructions [here](https://cocoapods.org/) under the tabs **Install** and **Get Started**.
 * [Library name](https://github.com/PureLayout/PureLayout) blah blah comments about why we use this

Contributors
------
2017
 * **Julia Kruk** - Product Manager
 * **David Chu** - Product Manager
 * **Amanda Ong** - Front-End Developer
 * **Jagger Brulato** - Front-End Developer
 * **Qichen (Ethan) Hu** - Front-End Developer
 * **Arnav Ghosh** - Back-End Developer
 * **Adit Gupta** - Back-End Developer
 * **Cedric Castillo** - Designer
 * **Lisa LaBarbera** - Designer
 * **Justin Park** - Designer
 
2016
 * **Julia Kruk** - Product Manager
 * **Juhwan Park** - Product Manager
 * **David Chu** - Front-End Developer
 * **Vicente Caycedo** - Front-End Developer
 * **Arnav Ghosh** - Back-End Developer
 
We are a team within **Cornell Design & Tech Initiative**. For more information, see its website [here](http://cornelldti.org/).
<img src="http://cornelldti.org/img/logos/cornelldti-dark.png">
