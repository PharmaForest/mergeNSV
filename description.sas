Type : Package
Package : mergeNSV
Title : mergeNSV
Version : 1.0.0
Author : Saikrishnareddy Yengannagari
Maintainer : Saikrishnareddy Yengannagari
Yutaka Morioka(sasyupi@gmail.com)
License : MIT
Encoding : UTF8
Required : "Base SAS Software"
ReqPackages :  

DESCRIPTION START:
mergeNSV is a SAS package with one macro, %merge_nsv(), that merges the non-standard variables (NSVs) of an SDTM domain onto that domain from whichever representation the study provides: SUPP<domain> as defined by SDTMIG 3.x, or NS<domain> as defined by SDTM v3.0 / SDTMIG v4.0. A program calls it the same way for a 3.x study and a 4.0 study, and keeps the call when a study collected no non-standard variable at all.

The package has no dependency on any other macro or package..
DESCRIPTION END:
