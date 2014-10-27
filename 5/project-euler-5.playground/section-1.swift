import Foundation

/**
 https://projecteuler.net/problem=5

 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
 What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
 */



/**
 Naive solution:

 The playground has trouble with plugging in 20, so
 use at your own risk.
*/
func naiveEuler5 (n: Int) -> Int {
  var answer = 0

  while true {
    answer += n

    var allDivisible = true
    for d in 2..<n {
      if answer % d != 0 {
        allDivisible = false
        break
      }
    }

    if allDivisible {
      return answer
    }
  }
}


/**
 Smarter solution:

 The problem is essentially asking for the least common multiple
 of 1 through 20. The easy way to do this is probably to factor
 each of the numbers (since they are so small) and gather all
 of their prime factors. We can also use the observation that

   lcm(1, 2, ..., 20) = lcm(10, 11, ..., 20)

 since all of the numbers in the first half of the range [1, 20]
 appear as factors in the numbers in the second half of the range.
 */


// Truncates a sequence by using a predicate.
func takeWhile <S: SequenceType> (p: S.Generator.Element -> Bool) -> S -> [S.Generator.Element] {
  return {sequence in
    var taken: [S.Generator.Element] = []
    for s in sequence {
      if p(s) {
        taken.append(s)
      } else {
        break
      }
    }
    return taken
  }
}

// A sequence to generate prime numbers.
struct PrimeSequence : SequenceType {
  func generate() -> GeneratorOf<Int> {
    var knownPrimes: [Int] = []
    return GeneratorOf<Int>() {
      if let lastPrime = knownPrimes.last {
        var possiblePrime = lastPrime+1
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
            possiblePrime++
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

// Easy integer exponentiation
infix operator ** {}
func ** (lhs: Int, rhs: Int) -> Int {
  return Int(pow(Float(lhs), Float(rhs)))
}

// Returns a dictionary mapping primes to powers in an 
// integer's factorization.
func primeFactorization (n: Int) -> [Int:Int] {

  let primes = takeWhile { $0 <= n } (PrimeSequence())
  let sqrtN = Int(sqrtf(Float(n)))

  return primes.reduce([Int:Int]()) { accum, prime in
    var r = accum
    for power in 1...n {
      if n % (prime ** power) != 0 {
        if power != 1 {
          r[prime] = power-1
        }
        break
      }
    }

    return r
  }
}

func smartEuler5 (n: Int) -> Int {
  let a = Int(n/2) + 1

  // Prime/power factors of LCM of 11-20
  let factors = Array(a...n)
    .map { primeFactorization($0) }
    .reduce([Int:Int]()) { accum, factorization in
      var r = accum
      for (prime, power) in factorization {
        if let currentPower = accum[prime] {
          r[prime] = max(power, currentPower)
        } else {
          r[prime] = power
        }
      }
      return r
  }

  return Array(factors.keys).reduce (1) { accum, prime in accum * (prime ** factors[prime]!) }
}

smartEuler5(10)
naiveEuler5(10)

smartEuler5(20)
//naiveEuler5(20) // <-- takes too long, use at your own risk

// Let's go crazy and solve the problem for 42! This
// is the biggest number we can plug into `smartEuler5`
// before we get an integer overflow
smartEuler5(42)



"done"
