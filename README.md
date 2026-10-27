# mergeNSV
mergeNSV is a SAS package with one macro, %merge_nsv(), that merges the non-standard variables (NSVs) of an SDTM domain onto that domain from whichever representation the study provides: SUPP<domain> as defined by SDTMIG 3.x, or NS<domain> as defined by SDTM v3.0 / SDTMIG v4.0. A program calls it the same way for a 3.x study and a 4.0 study, and keeps the call when a study collected no non-standard variable at all.

The package has no dependency on any other macro or package.
### This repository is an adapted version of Saikrishnareddy Yengannagari’s original package [https://github.com/kusy2009/mergeNSV] tailored for the SAS Package Framework, and the original license remains the property of Saikrishnareddy Yengannagari.


<img width="240" height="240" alt="mergeNSV_small" src="https://github.com/user-attachments/assets/0ce840a8-611e-4492-bbd1-d27ddc071e09" />
