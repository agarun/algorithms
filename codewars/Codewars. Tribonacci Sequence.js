// Well met with Fibonacci bigger brother, AKA Tribonacci.
//
// As the name may already reveal, it works basically like a Fibonacci,
// but summing the last 3 (instead of 2) numbers of the sequence to generate the next.
//
// So, if we are to start our Tribonacci sequence with [1,1,1] as a starting input
// (AKA signature), we have this sequence:
// {1,1,1,3,5,9,17,31,...}
//
// But what if we started with [0,0,1] as a signature?
// As starting with [0,1] instead of [1,1] basically shifts the common Fibonacci sequence by once place,
// you may be tempted to think that we would get the same sequence shifted by 2 places,
// but that is not the case and we would get:
// {0,0,1,1,2,4,7,13,24,...}
//
// Well, you may have guessed it by now, but to be clear:
// you need to create a fibonacci function that given a signature array/list,
// returns the first n elements - signature included of the so seeded sequence.
//
// Signature will always contain 3 numbers; n will always be a non-negative number;
// if n==0, then return an empty array and be ready for anything else which is not clearly specified ;)
//
// If you enjoyed this kata more advanced and generalized version of it can be found in the Xbonacci kata

function tribonacci(signature, n){
  const tribonacci = signature.slice(0, n); // slice to handle when args len < 3
  let [a, b, c] = tribonacci;

  while (tribonacci.length < n) {
    let x = a;
    let y = b;
    let z = c;
    a = b;
    b = c;
    c = x + y + z;
    tribonacci.push(c);
  }

  return tribonacci;
};

// shorter solution can use slice(-3) instead of keeping a, b, c
function tribonacci2(signature, n) {
  const tribonacci = signature.slice(0, n); // slice to handle when args len < 3

  while (tribonacci.length < n) {
    let last3Sum = tribonacci.slice(-3).reduce((sum, n) => {
      return sum + n;
    }, 0);
    tribonacci.push(last3Sum);
  }

  return tribonacci;
};

// or omit arrow functions and use function sum(a, b) { return a + b; }
// and call .reduce(sum) instead
