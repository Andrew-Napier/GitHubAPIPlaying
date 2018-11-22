# YouFoodzTest

Some short notes:
- Data persistence is achieved using JSON serialisation/deserialisation techniques added
in Swift 4.  (This was released just as I was moving off the iOS project and was the only feature 
I specifically remember as being in that version!)
- I chose _not_ to use `CoreData` as I've only used it once...
- I've used the persistence layer as a way of demonstrating a **Decorator** pattern. 
(A way of extending functionality without using inheritence or adding extra responsibilities to 
a given class)
- I've used a **Facade** pattern to transform the data provided by the GitHub API into a 
model more useful to the Application.  (Specifically: turning the creation-date, into a "human
readable" age string )
- I did a small number of unit-tests that helped me confirm / debug the "repository age" 
of the Facade class.

I have not spent time making the app look very pretty, rather choosing to spend the time 
concentrating on demonstrating some coding techniques.  The table-cells should obey the 
Accessability settings for text sizes - although you will have to restart the app when changing
the size.  (I know there's a way of "listening" out for the System font size changes, but didn't 
get around to Googling / implementing it)


Unfortunately, I can't really afford to spend more time on it at this point in time.  It's been an 
interesting exercise, and I might keep tweaking it in weeks and months to come, just to keep
my hand in!

