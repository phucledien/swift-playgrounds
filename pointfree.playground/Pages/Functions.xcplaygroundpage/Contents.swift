import Foundation

func incr(_ x: Int) -> Int {
    return x+1
}

func square(_ x: Int) -> Int {
    return x * x
}

// Functional way

// |> Pipe forward operator

precedencegroup ForwardApplication {
    associativity: left // left to right
}

infix operator |>: ForwardApplication

func |> <A, B>(a: A, f: (A) -> B) -> B {
    return f(a)
}


2 |> incr |> square // 9

// >>> Forward compose | right arrow | Function composition operator

precedencegroup ForwardComposition {
    associativity: left // left to right
    higherThan: ForwardApplication // have higher priority than ForwardApplication |> operator
}

infix operator >>>: ForwardComposition

func >>> <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return {
        g(f($0))
    }
}


2 |> incr >>> square // 9

// point free style -> apply fn to value without specify arguments
[1,2,3]
    .map(incr)
    .map(square)
// [4, 9, 16]


[1,2,3].map(incr >>> square) // [4, 9, 16]



// Method way

// equivalent to |>
extension Int {
    func incr() -> Int {
        return self + 1
    }
    
    func square() -> Int {
        return self * self
    }
}

2.incr().square() // 9

// equivalent to >>>
extension Int {
    func incrAndSquare() -> Int {
        return self.incr().square()
    }
}

// valid
2.incrAndSquare() // 9

// not valid
// .incr().square()
// incr().square()

// With methods, we can’t refer to them or their composition without a value at hand.


/// functions compose in ways that methods cannot.
/// Composing functionality with methods requires a lot more work and boilerplate, and trying to see that composition afterwards requires filtering that noise.
/// With just a couple operators, we unlock a world of composition that we didn’t have before, and we retain a lot of the readability we expect!
