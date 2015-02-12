#Development

Don't hand edit bluey.js! This is what is generated from compiling bluey.es6.js
using 6to5.

What is 6to5? This is a transpiler that converts ECMAScript 6 code (the next
version of JavaScript) to ECMAScript 5 which is what modern browsers 
understand.

If you have io.js installed or even node.js then install 6to5 using npm.

Make a change to bluey.es6.js and then open a command prompt to this directory.
Use 6to5 to transpile the ES6 code.

```
6to5 bluey.es6.js > bluey.js
```
