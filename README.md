# YouFoodzTest

At this stage, the test project meets _most_ of the requirements specified.
The missing part is the data persistence.  I've only used `CoreData` once and 
I was hoping to avoid it, by implementing the persistence and streaming out the array 
of repository models using JSON serialisation/deserialisation.

This is currently not-done, although the skeleton is in place.  I've used this
feature to demonstrate the *Decorator* pattern.  Also used is the *Facade* pattern
to change the data provided by the API into something more useful to the Application.

I did a small number of unit-tests that helped me confirm / debug the "repository age" 
that is shown on the table view cell.

Aside from that, there's some `TODO`s left in the code.  I have not spent time making
the app look pretty, rather choosing to spend the time concentrating on demonstrating
some coding techniques.  

Unfortunately, I have prior commitments tomorrow night, preventing me from further work 
on the app until Thursday at the earliest.
