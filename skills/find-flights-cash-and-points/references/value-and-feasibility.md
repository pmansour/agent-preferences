# Value and feasibility

## Two comparisons

1. **Redemption value:** paying points versus cash for the same dated flights, party, cabins, and practical inclusions. Compare this with the user's chosen threshold, if any.
2. **Practical trip choice:** this trip versus the best acceptable complete cash itinerary, even on different flights/dates/cabins. Show comfort/schedule differences instead of calling this same-itinerary CPP.

Use the lowest verified cash price the user can actually buy for the matched product, including eligible direct/portal discounts. Do not use inaccessible fares, one-person teasers, inflated portal/list prices, or a costly refundable fare when a usable cheaper fare exists. Disclose differences in cancellation conditions without silently assigning them dollar values.

## Normalize first

- Price the entire party and specify one-way/return/multi-city scope.
- Retain original currencies; convert with a cited, dated rate before totaling. State material spread/fee assumptions.
- Include award taxes/surcharges, mandatory booking/partner fees, transfer fees, purchased top-up miles, and needed bags/seats. Include positioning, ground and overnight costs in trip comparisons. Do not count fees twice.
- Use quoted totals. Estimates support leads/sensitivity analysis, not a verified threshold verdict.
- Keep raw cash due and points visible. Show earned rewards, elite progress or usable credits separately, only when eligibility/value are known. Do not deduct sunk annual fees or generic lounge/upgrade values.
- Apply eligible companion privileges, discounts and included services consistently to both cash and award comparisons. A benefit also usable on the cash booking is not extra value created by redeeming points.

## One currency

With same-itinerary cash total `C` (in the chosen comparison currency), all cash still due under the points option `A`, and points consumed `P`:

`value per point = (C − A) / P` in comparison-currency units. For a currency with 100 cents per unit, `CPP = 100 × (C − A) / P`; always state the currency.

If the user specifies valuation `v` in comparison-currency units per point, `benchmark cost = A + v × P`.

Compare unrounded value against the user's chosen strict or inclusive boundary. If no minimum is supplied, show value and practical tradeoffs without inventing a pass/fail rule. Show sufficient precision near a chosen boundary. Zero points means a cash purchase, not infinite CPP; negative savings means points make the purchase worse.

For fully transfer-funded awards, report airline miles required and bank points debited separately. Use bank points in the main CPP, including transfer rounding, without crediting leftover miles as immediate savings.

For existing miles plus a bank top-up, show both consumed balances. Never divide the full saving by only the top-up. Program-mile CPP may use the complete award mileage; bank-only CPP needs an explicit allocation assumption and is normally omitted.

## Transfers

Verify issuer logged-in offers or official terms: source/target, normal ratio, bonus applicability/expiry/timezone, caps, minimum/increment, timing, eligibility and fee. Separate base miles posting promptly from bonus miles posting later. Expected or expired bonuses cannot fund today's booking.

For a simple proportional bonus paid in time, use award miles `M`, existing usable miles `B`, target miles per source point `r`, bonus fraction `b`, and transfer increment `k`:

`shortfall = max(0, M − B)`

`source points = k × ceil(shortfall / (r × (1 + b) × k))`

Apply a minimum transfer only for a positive shortfall. Verify actual credited miles, issuer rounding, cap, timing and source balance. Tiered/stacked bonuses need their actual rules, not blind multiplication. Compute accounts separately where pooling is unavailable.

Track existing miles used, bank points transferred, credited miles, award miles spent and leftovers separately. They are not all costs to add. Allocate balances over all tickets in the proposal.

## Multiple currencies and hybrids

Show each consumed bank-points and airline-miles balance separately alongside cash. If the user supplies valuation `v_i` for each consumed quantity `P_i`, an explicit planning benchmark is `A + sum(v_i × P_i)`. Label this a convention, not market valuation. Without supplied valuations, retain the cash and points vector without manufacturing a combined cost.

Do not calculate each currency's CPP against the entire saving. Show independently matched components where valid, or clearly label any blended metric as a per-unit convention rather than attributing it to one points currency. Retain transfer rounding costs and explain treatment of leftover transferred miles.

Price a cash+award round trip as one complete choice. Compare to complete cash round trips; summing two expensive cash one-ways can grossly inflate apparent savings. Never halve a return fare to invent a one-way comparison. If a matched complete cash quote is missing, show CPP only for genuinely matched components and leave trip CPP unavailable.

Do not add CPPs or average without weighting by points. Total savings divided by same-currency points is valid when all components match and no cheaper bundled cash fare changes the baseline.

## Portal value

Show nominal portal rate separately from real value against the matched best cash price. A more expensive portal cash price must not inflate redemption value.

Compare cash+points sliders using actual quotes; cohort rates or offer eligibility can differ. Treat rebates as conditional and require enough points for the gross debit.

## Access and comfort

For awards unavailable for cash, record where matched cash was checked and why it is unavailable. Use `CPP: N/A — access opportunity`, never infinity or savings from another route. Cash that is expensive or above budget is still available: report price and affordability separately.

A luxury sticker price does not establish willingness to pay. Show incremental cost over the practical economy/premium-economy choice, time saved/lost, sleep impact, and long-haul legs improved. A short business connector with economy long-haul is not a business-class trip.

## Arithmetic checks (synthetic examples)

These illustrate calculations, not a traveler's balances, quotes, or valuation preferences. Cash figures use one hypothetical comparison currency.

| Case | Correct result |
|---|---|
| Same flights cost 2,100; award costs 150,000 points plus 300 | Value is 0.012 currency units per point; compare with the traveler's chosen threshold. |
| 90,000 miles needed, no existing miles, timely 25% bonus at 1:1, 1,000-point increments | Transfer 72,000 bank points to obtain 90,000 miles; do not add both as separate costs. |
| Same award with 20,000 existing miles | Consume 56,000 bank points plus 20,000 existing miles; avoid top-up-only CPP. |
| 90,001 miles needed, no existing miles, same bonus | Transfer 73,000 bank points to obtain 91,250 miles, leaving 1,249; no arbitrary buffer. |
| Three travelers; only one seat shows at 50,000 miles | Re-search for three; this is not a 150,000-mile party quote. |
| Cash search fails at login | Comparison is unknown; this is not an access opportunity. |

Recalculate after changes in party, flights, cabins, fares, currencies, bonuses, fees, or positioning.
