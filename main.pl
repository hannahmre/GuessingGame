/*Author: Hannah Moore
Date Created: April 24th, 2020*/

type(rabbit,animal).
type(dog,animal).
type(snake,animal).
type(fish,animal).
type(whale,animal).
type(dinosaur,animal).
type(chicken,animal).
type(eagle,animal).
type(ant,animal).
type(starfish,animal).
type(carrot,plant).
type(orange,plant).
type(seaweed,plant).
type(rose,plant).
type(tree,plant).
type(computer,object).
type(car,object).
type(boat,object).
type(submarine,object).
type(cup,object).
type(pencil,object).

alive(rabbit).
alive(dog).
alive(snake).
alive(fish).
alive(whale).
alive(chicken).
alive(eagle).
alive(ant).
alive(starfish).
alive(orange).
alive(seaweed).
alive(rose).
alive(tree).

dead(dinosaur).

class(rabbit,mammal).
class(dog,mammal).
class(whale,mammal).
class(chicken,bird).
class(eagle, bird).
class(snake,reptile).
class(ant,insect).
class(fish,fish).
class(starfish,fish).

where(seaweed,water).
where(carrot,land).
where(orange,land).
where(rose,land).
where(tree,land).
where(boat,water).
where(submarine,water).
where(computer,land).
where(car,land).
where(cup,land).
where(pencil,land).

grow(carrot,ground).
grow(orange,tree).
grow(rose,bush).
grow(tree,ground).
grow(seaweed,water).

operate(computer,type).
operate(car,drive).
operate(cup,drink).
operate(pencil,write).

found(boat,above).
found(submarine,under).

vegatable(carrot,yes).
vegatable(tree,no).
vegatable(orange,no).
vegatable(rose,no).
vegatable(seaweed,no).

locomotion(rabbit,hop).
locomotion(dog,walk).
locomotion(whale,swim).
locomotion(chicken,walk).
locomotion(eagle,fly).
locomotion(starfish,walk).
locomotion(fish,swim).
locomotion(ant,walk).
locomotion(snake,slither).


/*Purpose: Asks a series of questions depending on users answers*/
guess(Thing) :- ask_type(Type),
    ((Type==animal)-> ask_alive(Life), ((Life==alive)-> ask_class(Class), 
     ((Class==bird)-> ask_locomotion2(Locomotion),report(Thing,Type,Life,Class,Locomotion);
     (Class==mammal)->  ask_locomotion1(Locomotion),report(Thing,Type,Life,Class,Locomotion);
     (Class==fish)-> ask_locomotion3(Locomotion),report(Thing,Type,Life,Class,Locomotion);
     (Class==insect)-> ask_locomotion4(Locomotion), report(Thing,Type,Life,Class,Locomotion);
     (Class==reptile)-> ask_locomotion5(Locomotion), report(Thing,Type,Life,Class,Locomotion));
    report(Thing,Type,Life,null,null));
    (Type==plant)-> ask_where(Where), ((Where==water)->  report2(Thing,Type,Where,null,null); 
     (Where==land)-> ask_grow(Grow), ask_veggie(Veggie), report2(Thing,Type,Where,Grow,Veggie));
    (Type==object)-> ask_where(Where), ((Where==land)->  ask_operate(Operate), report3(Thing,Type,Where,Operate,null);
    ask_found(Found), report3(Thing,Type,Where,null,Found)))
    .
	
/*Purpose: Questions are called inside guess(Thing). Narrows down what the Thing is.*/
ask_type(Type) :- write("Is it an animal, plant, or object? \n"), read(Type).
ask_alive(Life) :- write("Is it alive or dead? \n"), read(Life).
ask_class(Class) :- write("What a mammal, bird, reptile, insect or fish? \n"), read(Class).
ask_locomotion1(Locomotion) :- write("Does the mammal walk, hop or swim? \n"), read(Locomotion).
ask_locomotion2(Locomotion) :- write("Does the bird walk or fly? \n"), read(Locomotion).
ask_locomotion3(Locomotion) :- write("Does the fish walk or swim? \n"), read(Locomotion).
ask_locomotion4(Locomotion) :- write("Does the insect walk or fly? \n"), read(Locomotion).
ask_locomotion5(Locomotion) :- write("Does the reptile walk or slither? \n"), read(Locomotion).
ask_where(Where) :- write("Is it found in water or on land? (water or land) \n"), read(Where).
ask_grow(Grow) :- write("Does the plant grow from the ground, on a bush or on a tree? (ground, bush or tree) \n"), read(Grow).
ask_veggie(Veggie) :- write("Is it a vegatable? (yes or no) \n"), read(Veggie).
ask_operate(Operate) :- write("Do you type, drive, drink or write with this object? \n"), read(Operate).
ask_found(Found) :- write("Is it found above water or under water? (above or under) \n"), read(Found).

    
/*Purpose: Used if the Type equals Animal
Returns: The Thing of type Animal*/

report(Thing,Type,Life,Class,Locomotion) :-
    type(Thing,Type),
    ((Life==alive)->  alive(Thing),
    class(Thing,Class), locomotion(Thing,Locomotion);dead(Thing)).

/*Purpose: Used if the Type equals Plant
Returns: The Thing of type Plant*/

report2(Thing,Type,Where,Grow,Veggie) :-
    type(Thing,Type),
    ((Where==land)->  where(Thing,Where),
    grow(Thing,Grow), vegatable(Thing,Veggie); where(Thing,water)).

/*Purpose: Used if the Type equals Object
Returns: The Thing of type Object*/   

report3(Thing,Type,Where,Operate,Found) :-
    type(Thing,Type),
    ((Where==land)->  where(Thing,Where),
    operate(Thing,Operate); where(Thing,Where), found(Thing,Found)).