# A demo illustrating how to dynamically add buttons to a view controller's view based on a tree data structure #

This is just a small project I set up to demonstrate something for stack overflow. Note I might delete this repository anytime.
The project was created with Xcode 8.3.2 and is written in Swift 3.1.

Its purpose is to show how you can traverse scenes in a storyboard based on a data structure, a tree, that is given at runtime.
I prepare a demo tree in the first view controller, but that is just for the example at hand, in a real project you'd get that from somewhere else, maybe a server.

The general idea is to illustrate the following: 

 * For trees that are completely defined during runtime (including their depth), you more or less just rely on a storyboard as a "repository" of view controllers you instantiate on demand for each depth level.
 * If you know beforehand how deep the tree will be (i.e. this is constant for each data tree set you get), you use a pretty complete storyboard and rely on concrete segues to follow.

The crux of the issue is that for the first case you don't have to programmatically recreate a segue structure but just rely on a plain old navigation view controller. It *can* be done with segues, but I'd advise against that, see below.

The second case is merely illustrating a "traditional" setup, relying on previous knowledge about what level of the tree requires what view controller. Basically it is simple: All nodes on one level will always have the same view controller.

Obviously the tree is the same (and thus completely known) in my example here, but it should be easy to see that it works with arbitrary tree depth.
I also use the same view controller for each level, but only because I was too lazy to actually implement any more classes. It should be easy to see that *what* view controller to load for a given child is decided just as said child is tapped. **That could be any view controller.** 
You should be careful not to accidentally instantiate the wrong one, though (for example by mixing up their identifiers), see below.
I provided commented out code showing how to load one of the other view controllers to play around with, but keep in mind this is plain *ugly* to do.

## Some notes about using segues for the first approach ##

As a matter of fact, you *could* also use segues in the first case, however, there are two further subcases to be distinguished then:

 1. You always want to show the same view controller class, mimicking the example I gave in code
 2. You want to decide which view controller to load at run time, depending on the node value

Modifying subcase 1 into 2 is not as trivial as it is in my example (which is why I chose not to show it in code).
To understand this, I must remind of the basically two types of segues you can have in regards to how they're triggered by the UI:

 * Either they are just part of the view controller, so called "manual" segues. Those you trigger programmatically by using their identifyer.
 * Or they are, in Interface Builder, already linked to a UI element, such as a button or a table view cell. Those are triggered automatically by the framework once the element is tapped/selected. In code you are merely informed in `prepare(for:sender:)`.

Manual segues are created by control-dragging from one scene's view controller to another scene's view controller, the other segues by control-dragging from their UI-element to another scene's view controller.

Subcase 1 can be easily realized with non-manual segues: Control-drag from the UI element to the view controller that controls this scene. You basically create a self-targeting scene. However I should mention that the graphical representation of this in Interface Builder looks like it was not really thought of doing so by Apple (I'm guessing, though). It looks ugly and can actually be hard to see (in my case the line went behind the scene).

Now, when trying to realize subcase 2, I originally thought "Let's just use several manual segues and trigger them programmatically", but this was not possible. I can establish manual segues to other scenes, but not to the scene they start in. I'm sure I could create them in code, but that's beside the point: Interface Builder obviously doesn't allow this.

The left options for subcase 2 are then to create several prototype cells and give them their own segues, some of those might even specify their own scene as target, others might not.
In code, this would lead to the decision which data node in the tree leads to which view controller being made earlier: Not when the node's cell is clicked, but rather when it's loaded. You'd have to decide which prototype cell to use based on the node and this would then define the segue. 

Alternatively, you could define unused prototype cells to establish the scenes, give them identifiers, and always use a cell without a segue to display the node, then programmatically trigger the right segue based on the node's content.

All this looks plain ugly to me, even with the "decide early" solution you'd not gain much, since you could still have need to prepare the next view controller after the tap happened (then in `prepare(for:sender:)` again). Or you have a bunch of prototype cells you don't really need...

## General notes on storyboard design & dynamic decisions about scene transitions ##

There's a lot you can do with storyboards and even without them (I didn't even go into using plain old xibs when instantiating view controllers). However, that doesn't mean you *should* do everything. 
Personally, I always took their name quite literally. I want my storyboards to help understand the program's UI-flow when I look at them. 
A segue is automatic as much as it is possible in my storyboards. 
Once I even added a segue that I didn't use just to make clear that there would be a transition from here to there (the overhead is tiny, as it is just a small entry in the storyboard and would never do anything).

If I want to have "utility" scenes/view controllers that I instantiate from code I make that clear (sadly, I can't add comments to storyboards, that would be neato IMO), for example I group them, maybe even use a different storyboard, or I go with the xib solution in the first place.

It is important to consider readability of the entire project, and carelessly mixing instantiation via identifiers and regular segues transitions can lead to confusion down the road and hard to track down bugs.
In this example project, in `DynamicLevelController`'s `tableView(_:didSelectRowAt:)` I provided an example of what not to do in my opinion.

I have encountered projects with code like this, which directly results in the storyboard being misleading:
The Storyboard looks like there's a certain path the scenes go with a single "floating" scene you might at first think is a utility that can be accessed from anywhere.
The code in this utility controller then all of a sudden leads to a random point in what originally looked like a regular, nice path of scenes.
To figure that out you have to look into several places in code, compare identifiers and so forth. That's not helpful.

There might be cases, as always, when you need to do something like this, but if there's no real need to do so, then don't.

### License ###
I provide this code under the MIT license, because these days apparently you have to chose a license...
See the added LICENSE file.

On a *completely unrelated* note, here's a joke: 

__Q__: *What are 1.000 lawyers on the bottom of the see?*

__A__: *A good start...*
