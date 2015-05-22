# Contributing to Hyle

Thanks for your interest in contributing to Hyle! Here are the steps to prepare your development setup.

1. First, clone the repo with:
    
    `git clone --recursive git@github.com:hyle/hyle.git`

2. Second, ensure you have [Coffeescript](http://coffeescript.org) installed:
    
    `coffee -v`

3. Run the cake script. 
    
    `cd hyle; cake watch`

You should now see your edit to files placed in `src` reflected in `lib`.

## Where to Go from There?

You can start coding! Make sure the coffeescript keeps compiling and all should be good. 

Make sure also to run `hyle.js` (do not confuse it with `hyle.jsx`). There are important differences between both those files. `hyle.js` as you will see, is only including external files. `hyle.jsx` is the compiled file, the one we want users to download. I would advise you to run it from Adobe ExtendScript Toolkit.

When debugging (Hyle looks for `hyle.debug`, which is set to `true` in `hyle.js` but to `false` in `hyle.jsx`), Hyle will run what is in `core/debugger.coffee`. There are already a number of test files available in the `data` folder. You may create more if you think that would help. If just wanna hack around, you can throw that in `data/temp.hyle`.

### Continuous Compilation

Everytime you run hyle from the Adobe ExtendScript Toolkit, Hyle compiles itself from `hyle.js` to `hyle.jsx`. During this compile:

- The `$.debug` and `hyle.debug` variables are set to false.
- All `# include` statements are replaced by the file they are including.

The important thing to remember is that `hyle.jsx` will be compiled only on a run of `hyle.js`. So make sure to run it before sending a pull request.

### Pull Requests

You've improved something existent or added something new? Great! You are an awesome human being. Just make sure that:

1. `hyle.jsx` has been compiled with your latest changes.
2. I would like to write here, “make sure the tests pass”. Though there is no test suite for the moment, so try to make sure with your best knowledge that you are not breaking something. And, if you, rare butterfly, are the kind of person who knows how to implement a test suite into this, well let's join arms and hearts over this and try to make something worthy of 2015 together.

### Why Coffeescript?

Although Javascript is rapidly moving toward a brighter future with EcmaScript 6, and the need for Coffeescript might lessen as time goes, the Javascript engine bundled Adobe’s software (under the name of ExtendScript) is far from up to date. That is the reason why, in order to have a clean, yet performant, object-oriented codebase, Coffeescript appeared as the reasonable solution. 

## Bugs

### Where to Find Known Issues

We will be using GitHub Issues for our public bugs. It's worth checking there before reporting your own issue.

### Reporting New Issues

Always try to provide a minimal test case that reproduces the issue.
