import Foundation

/**
https://projecteuler.net/problem=7

By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.

What is the 10,001st prime number?
 */


// A sequence to generate prime numbers.
struct PrimeSequence : SequenceType {
  func generate() -> GeneratorOf<Int> {
    var knownPrimes: [Int] = []
    return GeneratorOf<Int>() {
      if let lastPrime = knownPrimes.last {
        var possiblePrime = lastPrime == 2 ? 3 : lastPrime + 2
        while true {
          let sqrtPossiblePrime = Int(sqrtf(Float(possiblePrime)))
          var somePrimeDivides = false
          for prime in knownPrimes {

            // Sieve of Eratosthenes
            if prime > sqrtPossiblePrime {
              break
            }
            if possiblePrime % prime == 0 {
              somePrimeDivides = true
              break
            }
          }
          if somePrimeDivides {
            possiblePrime += 2
          } else {
            break
          }
        }

        knownPrimes.append(possiblePrime)
        return possiblePrime
      } else {
        knownPrimes.append(2)
        return 2
      }
    }
  }
}


var primes = PrimeSequence().generate()
var lastPrime: Int?
for i in 1...1000 {
  println("\(i) prime = \(lastPrime)")
  lastPrime = primes.next()
}
println(lastPrime)





"done"
