# Grocery Manager
The Grocery Manager application is written in Flutter to be cross-compatible with iOS and android.
The purpose of the application is to be an assistant in managing grocery lists and grocery shopping.
It does this by exposing 3 main functionalities: Items, Dinners, and Lists.

## Items
Items are the core of the grocery manager application. An item represents any singular purchase
made within the grocery store. An item has a name, an aisle (location in store), a price, and a flag
to denote it should be included on checklists (See: Lists).

## Dinners
Dinners are a level of abstraction/grouping overtop of items. They are designed to make dinner planning
easy and simple, but at the core they could be used to make any collection of items such that
you can add them to a grocery list together easily. A dinner has a name and a collection of
items attached to it.

## Lists
Lists are the main focal point of the grocery manager application. The idea behind a list is to represent
a singular trip to the grocery store, helping you both identify the items you need before leaving the house
and to help you track the items you've purchased while at the store, and finally calculating estimated
total expenditures as you go. New Lists are created in 3 stages to make life easier, the Checklist stage,
the Dinners stage, and the final Items stage. The Checklist stage is based on the flag attached to items,
and for every item that has that flag set, it will ask you if you need that item to be on this list?
It is designed as an easy organization tool to remind you to check the items you need from the store
on a regular basis. The Dinner stage allows you to choose from the dinners you've created, which will
add their respective items to the list. The Dinner stage respects things chosen in the checklist stage
and will not add duplicates to the list. As of writing this, there are no additional checks on items to
ensure that, i.e., you have enough eggs to make everything you specify. The final stage allows you to see
and edit the list you've created via the first two stages and add any additional items as well.
