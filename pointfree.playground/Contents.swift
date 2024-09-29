import Foundation

func incr(_ x: Int) -> Int {
    return x+1
}

func square(_ x: Int) -> Int {
    return x * x
}


precedencegroup ForwardApplication {
    associativity: left
}

infix operator |>: ForwardApplication

func |> <A, B>(a: A, f: (A) -> B) -> B {
    return f(a)
}


2 |> incr |> square
