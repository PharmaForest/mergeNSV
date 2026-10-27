# mergeNSV
mergeNSV is a dependency-free SAS macro package that merges SDTM non-standard variables from either SUPP&lt;domain> (SDTMIG 3.x) or NS&lt;domain> (SDTM v3.0/SDTMIG v4.0) into a domain through one consistent %merge_nsv() call. If no NSVs exist, it passes the domain through unchanged.
