# First-use traveler profile and memory

## Find or establish the profile

On first invocation, check the host's supported private user memory for an existing flight-travel profile. Do not infer ownership from a brand mentioned in a question, public example, or previous quote. Missing facts are unknown.

If no profile exists, ask one compact setup question:

> Which travel cards and points/miles programs do you have? Include card variants and issuing countries, rough balances, and any airline status or useful companion benefits. Also tell me your usual departure airport, comparison currency, and any minimum value you want from points. Unknown is fine; no account numbers are needed. I'll save the confirmed non-secret details in private memory where this app supports it, so you won't need to repeat them next time.

Adapt this to known facts. Do not require a complete inventory when only a few programs matter. Let the user provide partial information, decline storage, or begin with the current trip. Start independent route/date research while waiting. Ask about household pooling or another traveler's cards only when relevant, without collecting identity or assuming permission to use their balances.

Useful profile fields:

| Field | What to record |
|---|---|
| Cards | Issuer, exact product/variant, issuing country, confirmed relevant benefits |
| Bank points | Program names and optional approximate usable balances |
| Airline miles | Program names and optional approximate usable balances |
| Status | Program, tier, expiry if supplied |
| Benefits | Relevant companion privileges, credits, expiry, eligibility if known |
| Preferences | Home/nearby airports, comparison currency, typical cabin/stops, minimum point value with currency and strict/inclusive boundary |
| Evidence | User-reported or account-verified, date checked, unresolved fields |

Never save passwords, security codes, card or loyalty account numbers, passport data, legal passenger names, booking references, session tokens, or payment details. Exact balances are unnecessary for setup; retain them only if the user specifically wants them remembered. Keep passenger counts, child ages, trip dates, and transaction authorizations within the current trip unless the user explicitly asks to retain an appropriate preference.

## Persist privately

Save confirmed non-secret profile details through the host's supported persistent user-memory mechanism and its storage/consent rules. This skill cannot override those rules. If storage is declined, use the information only for the current conversation.

Keep the populated profile outside the skill folder, publishing repository, shared workspaces, ZIPs, examples, and notes intended for sharing. Do not hard-code an operating-system path or assume every agent exposes a memory API. In team environments, use a user-private store, never team-wide memory.

When permitted, save a concise profile rather than a transcript, under a stable label such as `flight-travel-profile`. Read it back or inspect a confirmed saved result before saying it was remembered. If saving fails, report that the profile is available only in the current conversation.

If persistent private memory is unavailable, explain that and offer a profile file in a user-approved private location outside the distribution. Create it only when location and storage are authorized. Never silently use a shared skill file as fallback. A local profile file is not automatic cross-device memory.

## Reuse and refresh

On later invocations, load the profile and ask only for consequential missing or changed facts. Do not repeat onboarding every trip. Briefly state relevant assumptions when they affect the search.

Saved balances, status, benefits, transfer menus, and promotions are dated snapshots. Recheck current funding and eligibility before presenting transfers as feasible or booking. Mark unknown funding conditional.

Update only facts the user changes or newly confirms, retaining unrelated preferences. Honor requests to forget fields through supported host controls; do not claim deletion without confirmation. Remembering a profile never authorizes transfers, purchases, or cancellations.
