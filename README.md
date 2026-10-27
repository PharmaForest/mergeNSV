# mergeNSV
mergeNSV is a SAS package with one macro, %merge_nsv(), that merges the non-standard variables (NSVs) of an SDTM domain onto that domain from whichever representation the study provides: SUPP<domain> as defined by SDTMIG 3.x, or NS<domain> as defined by SDTM v3.0 / SDTMIG v4.0. A program calls it the same way for a 3.x study and a 4.0 study, and keeps the call when a study collected no non-standard variable at all.

The package has no dependency on any other macro or package.
### This repository is an adapted version of Saikrishnareddy Yengannagari’s original package [https://github.com/kusy2009/mergeNSV] tailored for the SAS Package Framework, and the original license remains the property of Saikrishnareddy Yengannagari.


<img width="240" height="240" alt="mergeNSV_small" src="https://github.com/user-attachments/assets/0ce840a8-611e-4492-bbd1-d27ddc071e09" />

# mergeNSV (Latest version 0.1.0 on 05October2026)

mergeNSV is a SAS package with one macro, `%merge_nsv()`, that merges the non-standard variables (NSVs) of an SDTM domain onto that domain from whichever representation the study provides: `SUPP<domain>` as defined by SDTMIG 3.x, or `NS<domain>` as defined by SDTM v3.0 / SDTMIG v4.0. A program calls it the same way for a 3.x study and a 4.0 study, and keeps the call when a study collected no non-standard variable at all.

The package has no dependency on any other macro or package.

---

## `%merge_nsv()`

### Purpose

Merge an SDTM domain's non-standard variables onto the domain. The macro looks in the input library for `SUPP<domain>` and `NS<domain>`, takes the one that exists, and copies the domain through unchanged when neither contributes a row.

### Parameters

| Parameter | Required | Default | Description |
|---|---|---|---|
| `inlib` | No | `SDTM` | Input library holding the domain and its SUPP-- or NS-- dataset. |
| `domain` | Yes | — | SDTM domain to merge onto, e.g. `AE`, `DM`, `LB`, `FAMH`. |
| `outdset` | Yes | — | Output dataset, specified with a one- or two-level name. |
| `nsvvars` | No | All | Space-separated list of non-standard variables to merge, e.g. `AESOSP AETRTEM`. Leave blank to merge all. |
| `debug` | No | `N` | `Y` keeps the `work._nsv_*` intermediate datasets, including orphan-row datasets; `N` deletes them. |

### Example usage

```sas
/* Every non-standard variable of AE, from SDTM.SUPPAE or SDTM.NSAE */
%merge_nsv(domain=AE, outdset=work.ae1);

/* Only the named non-standard variables */
%merge_nsv(domain=AE, outdset=work.ae1, nsvvars=AESOSP AETRTEM);

/* A domain with no sequence variable */
%merge_nsv(domain=DM, outdset=work.dm1);

/* A domain read from another library, retaining intermediate datasets */
%merge_nsv(inlib=sdtmv4, domain=LB, outdset=work.lb1, debug=Y);
