Console.log("Welcome to ReScript!")

let greeting = Common.Demo.greet("Starter Package")
Console.log(greeting)

Console.log("Shared value: " ++ Common.Demo.sharedValue->Int.toString)
