options nonotes; 
options mprint mprintnest mlogic symbolgen; 

%let CURRFILEPATH = &_SASPROGRAMFILE ; 
%let CURRFOLDERPATH = %substr(&CURRFILEPATH., 1, %length(&CURRFILEPATH.) - %length(%SCAN(&CURRFILEPATH., -1, "/")) - 1) ; 
%put CURRFOLDERPATH = &CURRFOLDERPATH. ; 
 
data _null_ ; 
 rc = dlgcdir("&CURRFOLDERPATH.") ; 
run ; 
 
filename _pj_top "./" ; 
%let STUDY = %sysfunc(pathname(_pj_top)) ; 
%put STUDY = &STUDY. ; 
 
/* setup */ 
*%inc "./setup.sas"; 
%inc "./rwd_git_push.sas";
 
options notes; 
options compress=yes; 
options msglevel=i; 
options mprint mprintnest mlogic symbolgen; 
 
proc printto log = "&CURRFOLDERPATH./Table_2.log" new;
run ;
quit ;
 
data WORK.CLASS2;
set SASHELP.CLASS;
run;
 
proc datasets library=WORK KILL nolist; 
run ; 
quit ; 
 
proc printto; 
run ; 
quit ; 
 
/*--- Push to Git repository ---*/ 
%rwd_git_push; 
 
 
quit ; 
