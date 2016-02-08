# Concerns Demo

__Purpose__

concerns_demo is a simple Ruby application that demonstrates how concerns (here called "abilities") can be implemented as Ruby modules and included by a Ruby class with minimal impact on the including class. The demo, which implements a set of vehicle classes, illustrates how both inheritance and the use of concerns can concisely implement a set of related classes with unrelated abilities.

The demo also illustrates the use of some metaprogramming techniques, particularly those which make RSpec tests more concise.

Note: The output from the 160+ RSpec test cases is available in _spec/rspec_output.txt_

__Problem Statement__

Create a repo that contains these classes:
* Car
* Motorcycle
* Vehicle
* Tank
* Helicopter
* QuadCopter
* Plane
* Person
* ElectricCar
* ElectricMotorcycle
* ElectricTank

 Add additional classes or modules as necessary.
 Where appropriate, each class should have a combination of class and
 instance methods:
* wheelnum
* max_passengers
* electric?
* age
* manufacturer
* model_num
* weapons?
 
If weapons? returns true, it should also implement:
* shoot!
* reload!
* remaining_ammo
* max_ammo

__Design Decisions__
* _Allow a person to be mobile and have weapons_ -- While in other contexts, a Person may be totally unrelated to a vehicle, a person can actually move, carry at least a small passenger, and bear arms. Therefore, an ArmedMobilePerson class is implemented that represents a person with these potential capabilities. While other required classes inherit from Vehicle, ArmedMobilePerson obtains its weapon and mobile capabilities through the use of mixins.
* _All class instances respond to electric? & weapons?_ without producing an unknown method exception. The best way to do this is to "monkey-patch" the Object class to implement these methods. In order to generalize this feature, the specific methods are renamed is_electric? and has_weapons?. A method_missing method is added to Object that returns false for any method of the form /is\w+\?/ or /has\w+\?/, and invokes super otherwise. In that manner, these format method invocations return false unless specifically implemented by class or module definitions.
* _The two major abilities, mobility and weapons, are implemented as concerns_. In this pure Ruby implementation a concern is implemented as a Ruby Module and included into a class which uses that concern. The implementing class need only
* _The electric ability is specially implemented._ While it could also be implemented as a concern, its scope is so limited, that it is implemented specially as an _is\_electric?_ method in the Vehicle class for use by it and its subclasses.
* _Only Class instances respond to the is_*? or has_*? methods._ With a bit more effort, classes themselves could also respond to these methods.
