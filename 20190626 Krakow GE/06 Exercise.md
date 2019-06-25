# Airbnb in Berlin

After a successful career in GE, you are ready to retire and enjoy some passive income. You are considering buying a flat to rent for Airbnb in Berlin, but would like to use data to understand:
1. How much money can you expect to make?
	a) On which neighbourhood group should your flat be? 
    b) How many people should you accommodate? Which room type?
2. Flat prices listed vary throughout the year. In which time of the year should you rent your place? (higher price).

---
## Estimating revenue
- There is no raw transaction data, so you will try to do an educated guess.
- Monthly Occupancy Rate: 
	- `AvgStay` $\times$ (`Reviews per Month` / `ReviewRate`).
- For Berlin in 2017, `AvgStay` = 4.2.
- Yearly income can then be estimated by:
 `Monthly Occupancy Rate`$\times$`Price`$\times$ 12
- The `ReviewRate` is unknown. A modest estimate is 50%, and an optimistic estimate (from Airbnb itself) is 72%.


---
## Hints
- You will use `calendar_summary`, `listings`, `listings_summary`. 
- You need to set up the right index structure and consider using compression for text columns.
