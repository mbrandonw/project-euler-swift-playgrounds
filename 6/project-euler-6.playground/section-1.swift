import Foundation

/*========================================================
  ================= Problem #6 ===========================
  ========================================================
  https://projecteuler.net/problem=6

The sum of the squares of the first ten natural numbers is,

12 + 22 + ... + 102 = 385
The square of the sum of the first ten natural numbers is,

(1 + 2 + ... + 10)2 = 552 = 3025
Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.

Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.

========================================================
========================================================
======================================================== */



let n = 100

/*
 NB: Fun fact:

 1 + 2 + ... + n = n * (n+1) / 2

 Supposedly Gauss used this fact when he was just a child:
 http://en.wikipedia.org/wiki/Carl_Friedrich_Gauss#Anecdotes
*/
let squareOfSum = n * n * (n+1) * (n+1) / 2 / 2

/*
 NB: Another fun fact

 1^2 + 2^2 + ... + n^2 = n * (n+1) * (2n+1) / 6
*/
let sumOfSquares = n * (n+1) * (2*n+1) / 6

squareOfSum - sumOfSquares
