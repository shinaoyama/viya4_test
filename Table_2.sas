%put _global_;

%put &_sasprogramfile.;

data _NULL_;
 fullpath="&_sasprogramfile.";
 
 n=find(fullpath,"/",-1000);
 path=substr(fullpath,1, n);
 call symputx("EXECUTE_PATH", path);
run;

%PUT &EXECUTE_PATH.;