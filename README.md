# Library Management System

#### [](https://github.com/balasubramanian1612s/library-management-system)An web portal for automating various manual processes done by librarian.


## [](https://github.com/balasubramanian1612s/library-management-system)Abstract

[![Library Management System](https://camo.githubusercontent.com/b0b27c0370b1e5703414256e9600171519dd0821a14490bcd4adb8bc6d0db48f/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f6c6962726172792d2d6d616e6167656d656e742d73797374656d2d6f72616e67652e7376673f7374796c653d666c61742d737175617265)](https://camo.githubusercontent.com/b0b27c0370b1e5703414256e9600171519dd0821a14490bcd4adb8bc6d0db48f/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f6c6962726172792d2d6d616e6167656d656e742d73797374656d2d6f72616e67652e7376673f7374796c653d666c61742d737175617265)  [![DBMS Project](https://camo.githubusercontent.com/53f339485c37034683c8e900ed2fa019ded3ef3a4f2b9eee0a39336f39c5fe9a/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f44424d532d70726f6a6563742d79656c6c6f77677265656e2e7376673f7374796c653d666c61742d737175617265)](https://camo.githubusercontent.com/53f339485c37034683c8e900ed2fa019ded3ef3a4f2b9eee0a39336f39c5fe9a/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f44424d532d70726f6a6563742d79656c6c6f77677265656e2e7376673f7374796c653d666c61742d737175617265)  [![Open Source Programming](https://camo.githubusercontent.com/ec4284a371fa5de0e05f04fce5282b2d555160425257e80b3f2eda7971829e6d/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f6f70656e2d2d736f757263652d70726f6772616d6d696e672d6666363962342e7376673f7374796c653d666c61742d737175617265)](https://camo.githubusercontent.com/ec4284a371fa5de0e05f04fce5282b2d555160425257e80b3f2eda7971829e6d/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f6f70656e2d2d736f757263652d70726f6772616d6d696e672d6666363962342e7376673f7374796c653d666c61742d737175617265)

## [](https://github.com/balasubramanian1612s/library-management-system)Introduction
Manual process of keeping book records, account details is very difficult. There are various problems also faced by the student in library such as finding any particular book, information whether book is available or not, for what time this book will be available. To eliminate this manual system,  **Library Management System**  has been developed.

A college library management is a project that manages and stores books information electronically according to students' needs. The system helps both students and library managers to keep a constant track of all the books available in the library.

 It becomes necessary for colleges to keep a continuous check on the books issued and returned and even calculate fines. This task if carried out manually will be tedious and includes chances of mistakes. These errors are avoided by allowing the system to calculate fine.

Thus this system reduces manual work to a great extent allows smooth flow of library activities by removing chances of errors in the details.



## [](https://github.com/balasubramanian1612s/library-management-system)Core Features

[![admin](https://camo.githubusercontent.com/fb20841677a146800726d23dba4b2db5402bb33f24f095d3675f9e005c78a889/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f61646d696e2d6c6f67696e2d7465616c2e7376673f7374796c653d666c61742d737175617265)](https://camo.githubusercontent.com/fb20841677a146800726d23dba4b2db5402bb33f24f095d3675f9e005c78a889/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f61646d696e2d6c6f67696e2d7465616c2e7376673f7374796c653d666c61742d737175617265)  [![search](https://camo.githubusercontent.com/7ff70ea9269f9bc05f4f75080ae95dabeca6479e658456483479ac74b9f715b0/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f7365616372682d626f6f6b732d79656c6c6f77677265656e2e7376673f7374796c653d666c61742d737175617265)](https://camo.githubusercontent.com/7ff70ea9269f9bc05f4f75080ae95dabeca6479e658456483479ac74b9f715b0/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f7365616372682d626f6f6b732d79656c6c6f77677265656e2e7376673f7374796c653d666c61742d737175617265)   
-   **Searching**  of books
-   **view** return and borrow history
-   Librarian can track the books issued by a particular student (borrow entry & return entry)
-   Librarian can  **view books issued** 
-   Librarian can search for books


    

## [](https://github.com/balasubramanian1612s/library-management-system)Modules

-   Admin login
-   Student login

## [](https://github.com/balasubramanian1612s/library-management-system)Technology Stack Used


-   Front End -  **Flutter**
-   Processing -  **Python**
-   Database -  **Firebase - Firestore**

## [](https://github.com/balasubramanian1612s/library-management-system)File Wise Description
**/model** - contains database and class models

 &nbsp; **/hive** - blueprints for local database implemented using HIVE
 
   &nbsp;&nbsp; book_model.dart - model to store a book
   
   &nbsp;&nbsp; borrow_model.dart - model to store a borrow entry
   
   &nbsp;&nbsp; return_model.dart - model to store a return entry
  
   &nbsp; book.dart - class-model to store a book retrieved from the DB
   
   &nbsp; side_bar_menu_model.dart - change-notifier model for functioning of the sidebar

**/util** - contains utility widgets (or) components	

 	data_fetch.dart -  page for initial data fetch and seeding of the local database.
	
	 my_image.dart - custom widget to display a network image 
	 
responsive.dart - custom widget to render different pages for different display sizes and display orientations

**/view** - contains all pages in the application

	**/admin** - contains all the pages available for the admin to use
	
		**/widgets** - contains the custom widgets designed for various purposes.
		
    dashboard_item.dart - widget to render a tile in the  admin_dashboard.dart page
    
    text_dialog_widget.dart - widget to display a overlay dialog with some text in it
    
  admin_borrow.dart - page to borrow a book and add the corresponding entry to DB
  
  admin_dashboard.dart - page to display the admin dashboard
  
  admin_home_screen.dart - scaffold page upon which the dashboard page is constructed
  
  admin_return.dart - page to return a book and add the corresponding entry to DB
  
  admin_side_bar.dart - widget to render a side-bar in the application. Integrated into the admin_home_screen.dart page
  
  data_borrowers.dart - page to display the record of borrowed books. 
  
  data_page.dart - page to display the books available to borrow from the library
  
  data_returners.dart - page to display the record  of returned books.

**/onboard** - contains the pages to be rendered during the onboarding procedure

		login_screen.dart - page for login process

**main.dart** - contains the root widget, starting from where, the entire application is configured & run


## [](https://github.com/balasubramanian1612s/library-management-system)Demo Video
https://bit.ly/3nasF7o
