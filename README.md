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
```

### Behaviour worth knowing

- **SUPP--** (vertical; one row per value) may link records to the parent using different IDVARs. Each distinct IDVAR is transposed and merged as its own group. IDVARVAL is converted to the type of its linked parent variable. Rows with a blank IDVAR (for example, DM) link by `STUDYID` and `USUBJID` alone. Only populated QVAL rows are used. `QNAM`, `QLABEL`, `QVAL`, `IDVAR`, `IDVARVAL`, and `RDOMAIN` do not reach the output.

- **NS--** (horizontal; one row per parent record) merges without a transpose. IDVAR is read from the data, so both a split domain such as `NSFAMH` keyed by `FASEQ` and a domain with a null IDVAR such as `NSDM` are handled. IDVARVLN is renamed onto the parent key. `RDOMAIN`, `IDVAR`, and `IDVARVLN` are dropped as linkage metadata.

- A study carries one representation. If both exist, NS-- is used and an `ALERT` is written. A representation with no populated values counts as absent.

- Rows that do not match a parent record are not merged. They are counted, reported as an `ALERT`, and retained in `work._nsv_orph<n>` for SUPP-- or `work._nsv_orphan` for NS-- when `debug=Y`. A non-unique key in NS-- is also reported as an `ALERT`, because the merge repeats the parent record.

- The macro merges non-standard variables only; it does not perform a subject-level merge.

Author: Saikrishnareddy Yengannagari  
Latest update date: 2026-10-05

## version history
- **0.1.0 (05Oct2026):** Initial version.
  - Original repository created: 05Oct2026
  - Migrated to PharmaForest: 27Oct2026

## What is SAS Packages?

The package is built on top of **SAS Packages Framework(SPF)** developed by Bartosz Jablonski.

For more information about the framework, see [SAS Packages Framework](https://github.com/yabwon/SAS_PACKAGES).

You can also find more SAS Packages (SASPacs) in the [SAS Packages Archive(SASPAC)](https://github.com/SASPAC).

## How to use SAS Packages? (quick start)

### 1. Set-up SAS Packages Framework

First, create a directory for your packages and assign a `packages` fileref to it.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
filename packages "\path\to\your\packages";
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Secondly, enable the SAS Packages Framework.
(If you don't have SAS Packages Framework installed, follow the instruction in 
[SPF documentation](https://github.com/yabwon/SAS_PACKAGES/tree/main/SPF/Documentation) 
to install SAS Packages Framework.)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
%include packages(SPFinit.sas)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### 2. Install SAS package

Install SAS package you want to use with the SPF's `%installPackage()` macro.

- For packages located in **SAS Packages Archive(SASPAC)** run:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
  %installPackage(packageName)
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- For packages located in **PharmaForest** run:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
  %installPackage(packageName, mirror=PharmaForest)
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- For packages located at some network location run:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
  %installPackage(packageName, sourcePath=https://some/internet/location/for/packages)
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  (e.g. `%installPackage(ABC, sourcePath=https://github.com/SomeRepo/ABC/raw/main/)`)


### 3. Load SAS package

Load SAS package you want to use with the SPF's `%loadPackage()` macro.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
%loadPackage(packageName)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### Enjoy!

