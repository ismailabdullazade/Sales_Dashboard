# Feel Clothing: 2025 Sales Analysis (SQL Server + Power BI)

An end-to-end analytics project for a clothing retailer, built from a CEO-style brief. I loaded the raw data into SQL Server, checked its quality, answered 14 business questions in SQL, modeled it in Power BI and built a 3-page interactive dashboard with a one-page executive summary.

**Live interactive version:** _add your link here_

## Data

| Table | Content | Rows |
|---|---|---|
| `Fact_Sales` | One row per order: date, product, color, size, quantity, price, discount, delivery, gift wrap, revenue, cost, profit | 1,500 |
| `Dim_Customers` | Customer, city, gender, segment (New / Regular / VIP) | 1,000 |
| `Dim_Products` | Category (T-shirt, Polo, Sweatshirt, Hoodie), unit cost, unit price | 4 |

Headline numbers: revenue 65,496.75, net profit 42,140.75 (64.3% margin), 1,500 orders, 2,362 units, average order value 43.66.

## Business questions answered

**Executive Overview**
- Is the business growing or flat? *Flat: H1 32,981 vs H2 32,516 (-1.4%).*
- Which month is weakest and why? *February (111 orders) and August (101 orders) against an average of 125. Order value and margin stayed stable, so fewer orders, not lower prices.*

**Product & Pricing**
- Is T-shirt the top earner? *Yes: top in units (941), revenue (29.7%) and margin (66.1%), but the cheapest item.*
- Where should more stock go? *T-shirt first. Hoodie sells less but earns the most profit per unit (25.07 vs 13.66).*
- Which colors and sizes can we drop? *XXL is only 5.8% of units; White, Gray and Black XXL sold under 22 units each.*
- How much do discounts cost? *Discounted orders earn 24% less profit per order and have smaller baskets.*

**Customers & Delivery**
- Which cities deserve investment? *Sheki and Shirvan lead on revenue. Baku has a high order value but few buyers.*
- Do VIP customers really spend more? *No: order value and revenue per customer are about the same in all segments.*
- Do gift wrap and delivery add revenue? *Only a little: gift wrap adds about 2.29 per order; courier orders are not larger.*
- How many customers come back? *57.5% of buyers ordered more than once (445 of 774). 226 customers never bought.*

## What is in this project

**1. SQL Server**
- Database with primary and foreign keys, text dates converted to `DATE`, ER diagram
- Data-quality checks: nulls, duplicate orders, orphan keys, revenue and profit formula checks, name-gender mismatches
- 14 documented analytical queries (`GROUP BY`, `LAG()`, `RANK()`, `ROW_NUMBER() OVER (PARTITION BY)`, CTEs, `CASE WHEN`)
- Reporting view `vw_Sales_Enriched`

**2. Power BI**
- Star schema: `Fact_Sales` with `Dim_Customers`, `Dim_Products` and a DAX `Dim_Date`
- Measures table: revenue, profit, margin %, orders, units, average order value, discount %, YTD, MoM %, unique and repeat customers, gift wrap and courier share
- All numbers reconciled between SQL and Power BI

**3. Dashboard**
- 3 pages with slicers, tooltips, page navigation, a reset button and a phone layout
- A short "what this tells me" note under every chart

**4. Executive summary**
- One page with 5 findings and a recommendation for each

## Recommendations (short)

1. Reactivate the 226 customers who never bought.
2. Run T-shirt campaigns in February and August.
3. Give T-shirt the most stock, pilot a small price increase, cut XXL.
4. Tie discounts to a minimum basket value.
5. Redefine the VIP segment by actual spend and test an acquisition campaign in Baku.

## Limitations

- Net profit does not include courier (delivery) cost, so margins are likely overstated.
- The gender field has name-gender mismatches (for example, female names marked "Male"), so I did not use it in the analysis.

## Tools

SQL Server, T-SQL, Power BI, DAX, Power Query
