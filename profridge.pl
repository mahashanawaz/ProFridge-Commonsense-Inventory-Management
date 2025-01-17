
% Name: Maha Shanawaz Syeda
% NetID: dal043833
%--------------------FACTS------------------------

% Food items in ProFridge
% food(Item, Quantity, ExpirationDays).
food(milk, 1, 3).        
food(eggs, 6, 3).        
food(broccoli, 2, 4).     
food(cheese, 1, 5).       
food(bread, 1, 1).

% Item priority
% priority(Item, degree).
priority(milk, high).     
priority(eggs, high).     
priority(broccoli, medium).
priority(cheese, low).   
priority(bread,medium). 

% -------------------RULES-------------------------

% Restocking priority items
needs_restock(Item) :- priority(Item, high), food(Item, Quantity, _), Quantity < 3.
needs_restock(Item) :- priority(Item, medium), food(Item, Quantity, _), Quantity < 2.


% Remainder before expiration prior 3 days.
expiring_soon(Item) :- food(Item, _, ExpirationDays), ExpirationDays =< 3.


% Add product to grocery list if it expires in 1 day or less without considering its priority.
add_to_grocery_list(Item) :- food(Item, _, ExpirationDays), ExpirationDays =< 1.

   
% Use the items with fewer expiration days first.
use_fresher(Item1, Item2) :- food(Item1, _, ExpirationDays1), food(Item2, _, ExpirationDays2), ExpirationDays1 < ExpirationDays2.


% Recipe suggestions with the availability, priority and expiration days of products.

recipe_smart_suggestion(egg_sandwich) :-
    % Check for availability of eggs, cheese and bread.
    food(eggs, Eggs, _), Eggs >= 2, food(cheese, Cheese, _), Cheese >= 1, food(bread, Bread, _), Bread >= 1, 
    % Eggs must meet high priority and expiration condition
    (priority(eggs, high), food(eggs, _, ExpirationDaysEggs), ExpirationDaysEggs =< 3),
    % Bread must meet medium priority and expiration condition
    (priority(bread, medium), food(bread, _, ExpirationDaysBread), ExpirationDaysBread =< 3).

recipe_smart_suggestion(roasted_broccoli) :-
    % Check for availability of broccoli and cheese.
    food(broccoli, Broccoli, _), Broccoli >= 1, food(cheese, Cheese, _), Cheese >= 1,
    % If broccoli expires within 3 days
    food(broccoli, _, ExpirationDays), ExpirationDays =< 3.
