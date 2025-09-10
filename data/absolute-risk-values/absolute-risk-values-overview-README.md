<div align="center">
  <img src="https://raw.githubusercontent.com/Harrison-Healthcare/Risk-Calculator/main/assets/harrison-logo.jpg" alt="Harrison Healthcare Logo" width="150">
</div>

---

# Age-Stratified Baseline Survival (S₀): Overview & Outputs

## What is S₀ (Short Version)
We convert **age-specific incidence rates** into **baseline survival**:

- Annual hazard: `λ₀(age) = rate_per_100k / 100000`  
- Cumulative hazard over `T` years (attained ages): `H_T(age) = Σ_{k=0..T-1} λ₀(age+k)`  
- Baseline survival: `S₀,T(age) = exp(−H_T(age))`

> **Notation.** `S0_1`, `S0_3`, `S0_5`, `S0_10` are baseline survival over the next 1, 3, 5, and 10 years, respectively, from the person’s current (attained) age.  
*Example: for a 62-year-old, `S0_10` is the probability of remaining free of the incident condition from age 62 up to (but not including) 72, absent additional risk modifiers.*

We publish `S0_1`, `S0_3`, `S0_5`, `S0_10` for each Disease × Sex × 5-year AgeGroup, except:
- Top age bin (85+ or 90+) → **S0_1 only**  
- Mental health workbooks (e.g., Depression, GAD) → **S0_1 only**

> Because S₀ is **age-stratified**, **age effects are already encoded**. Do **not** apply an additional “age RR” on top of these baselines. Apply only non-age multipliers.

## Inputs (Sources)
- **SEER** (cancers): age-specific incidence per 100k, 5-year bands, by sex.  
- **CCDSS** (chronic conditions): crude incidence per 100k, 5-year bands, by sex.  
- **NSDUH/MHACS** (mental health): prevalence-based S₀ (1-year only).

## How S₀ is computed
- Normalize age labels (handle dashes, “to”, “and over”, `<1`, NBSP).  
- Convert incidence → hazard; expand age bands to single ages.  
- Compute rolling sums for `T = 1, 3, 5, 10` (attained-age windows), then average single-age `S₀,T` back to 5-year AgeGroup.  
- Guardrails:
  - Enforce `S0_1 ≥ S0_3 ≥ S0_5 ≥ S0_10`.  
  - Flag adult bands that are flat over short horizons when 10-year risk is non-trivial.

> **Availability of horizons:** Some outputs are S0_1 only by design:
> - **Top age bin (85+ or 90+)** — source tables use an open-ended age interval; we avoid extrapolating hazards over multiple years, so we report the 1-year baseline.
> - **Mental health workbooks (e.g., Depression, GAD)** — inputs are prevalence snapshots (not incidence), which support a 1-year baseline S₀ but not multi-year horizons.


## Output Workbooks (this repo)

### `SEER_S0_absoluterisk_multiyears.xlsx`
- From SEER (cancers).  
- Columns: `Disease, Sex, AgeGroup, S0_1, S0_3, S0_5, S0_10`.  
- One sheet per cancer. *(Top bin: S0_1 only.)*

### `CCDSS_S0_absoluterisk_multiyears.xlsx`
- From **CCDSS** (chronic diseases).  
- Same columns/structure as SEER workbook; one sheet per condition. *(Top bin: S0_1 only.)*

### `Depression_NSDU_S0_absoluterisk_1year.xlsx`
- Prevalence-based (NSDUH): S0_1 only by age/sex (where available).  
- Columns: `AgeGroup, Sex, S0_1` (and source % if included).

### `GAD_MHACS_S0_absoluterisk_1year.xlsx`
- Prevalence-based (MHACS): S0_1 only for GAD.  
- Same structure as Depression S0_1.

## Using the outputs
- User-facing 1-,3-,5-,or 10-year absolute risk: `AbsoluteRisk_10y = 1 − S0_10(age, sex)`  
- Optional age-RR gut check:compute `λ(age) = −ln(S0_1(age))`, then `RR(age) = λ(age) / λ(ref_age)` and compare to source incidence RR.
> see further information in our `methodology.md` in section Absolute Risk Calculation
## Notes / Edge Cases
- Pediatric bands often have S₀ ≈ 1 across horizons (expected when risk ≈ 0).  
- UI teams may choose to hide multi-year values in the top bin since only S0_1 is published there.

---
