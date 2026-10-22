# Provenance and design choices

This skill is an independently written synthesis of flight-search methods. It bundles no upstream browser scripts, credentials, account data, API clients, datasets, or hosted tools. External repositories are background research, not instructions governing this skill or evidence of a traveler's memberships.

Public references informing the workflow include [Travel Hacking Toolkit](https://github.com/borski/travel-hacking-toolkit), [Award Travel Finder](https://github.com/AwardTravelFinder/mcp), and [Flights Points Tool](https://github.com/andrew-demers/flights-points-tool). Their current behavior is not a dependency or a guarantee of search accuracy.

The workflow retains calendar discovery, partner mapping, complete-trip comparisons, transfer arithmetic, whole-party repricing, and verification before booking. It avoids fixed issuer portfolios, universal point valuations, stale rules, vendor-specific tool ordering, and required paid services.

## Design principles

- Obtain personal context from the current traveler and private memory. Keep shared instructions free of populated profiles and private documents.
- Calculate redemption value against matched cash prices, including eligible discounts. Apply only the traveler's chosen threshold.
- Reprice complete trips; expensive cash one-ways are not automatically the right comparator for a return trip.
- Keep source points, existing miles, transferred miles, rounding leftovers, and cash fees distinct.
- Verify all seats together. Do not multiply a teaser or combine aggregate minimum price with aggregate maximum seats.
- Treat fares, transfer partners, bonuses, stopovers, and holds as live rules.
- Treat the actual seller/program quote as authoritative for tickets it can sell.
- Distinguish verified quotes, search leads, failed searches, and actual ticket issuance.
- Use a portable browser procedure with optional discovery tools.

Unrelated hotels, restaurants, card applications, and status-match work remain outside scope unless separately requested.
