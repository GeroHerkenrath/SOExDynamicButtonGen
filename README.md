# A demo illustrating how to dynamically add buttons to a view controller's view based on a tree data structure #

This is just a small project I set up to demonstrate something for stack overflow. Note I might delete this repository anytime.
The project was created with Xcode 8.3.2 and is written in Swift 3.1.

The general idea is to illustrate the following: 
 * For trees that are completely defined during runtime (including their depth), you more or less just rely on a storyboard as a "repository" of view controllers you instantiate on demand for each depth level.
 * If you know beforehand how deep the tree will be, you use a pretty complete storyboard and rely on concrete segues to follow.

The crux of the issue is that for the first case you don't have to programmatically recreate a segue structure but just rely on a plain old navigation view controller.

### License ###
I provide this code under the MIT license, because these days apparently you have to chose a license...
See the added LICENSE file.

On a *completely unrelated* note, here's a joke: 

__Q__: *What are 1.000 lawyers on the bottom of the see?*

__A__: *A good start...*
