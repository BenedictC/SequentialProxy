SequentialProxy
===============
Sequential proxy is a little idea I had for providing thread safe access to an object. I haven't yet decided if this is
a smart idea or too naive to be useful. I typed this up to help me decide. Feedback is much appreciated!

The main use case I envisage is when concurrent access is required to a class that doesn't support it, for example
NSMutableDictionary.

The proxy works by intercepting method invocations and executing them on a synchronous serial queue. 

Pros & cons
-----------
+ Pro: Little code required to create, thus easy to use as a drop in fix.

+ Pro: Easy to use interface.

- Con: Doesn't guarantee thread safety. If a reference to the object is held by an object other than the proxy then the this 
  object can still perform concurrent access.

- Con: Message ordering issues can still occur. For example, thread A makes 2 sequential calls, but a call by thread B is  
  performed between the 2 calls from thread A.

- Con: Slow compared to a specialised solutions.
