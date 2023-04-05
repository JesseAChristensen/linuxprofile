// Prelude
use std::io;
/* we could just `use` std and call `io::stdin()` and like python it appears that
   all of std is available.
   Rust calls `stdin()` an "associated function" of io, just as `new()` is an
   associated function of `String`.
*/
use std::cmp::Ordering;


use rand::Rng;
/* This is an oddity coming from python. `Rng` must be in scope to call `rand::thread_rng()`
 * presumably doing a `use rand` isn't enough.
 * `Rng` is called a "trait"...
*/


fn main() {
    println!("Guess the number!");
    let secret_number = rand::thread_rng().gen_range(1..=100);
    println!("The secret number is {secret_number}");


    
    loop {
        println!("Please input your guess.");
        let mut guess = String::new(); // in rust variables are immutable unless specified by adding `mut`.
        io::stdin()
            .read_line(&mut guess)  // in python we'd say `guess = io::readline()` but in rust we pass `guess` to readline
            .expect("Failed to read line"); // `expect` looks at the return of `read_line()` for `Ok` which contains
                                            // the `Result` of the function, or `Err` which contains why
                                            // the function failed.
                                            // Functions return enums with "varients" of `Ok` or `Err`.
                                            // Worth mentioning that we pass (a refrence) `&mut guess` to
                                            // `read_line` because our `guess` variable is mutable.

        // let guess: i32 = guess.trim()
        //     .parse()
        //     .expect("please type a number");
        /* We're creating a "shadow" of the mutable `guess` variable. It appears to let us use the
         * initial `guess` variable and modify it to be an i32.
         * `trim()` removes any whitespace (including the newline from when the user presses <enter>).
         * `parse()` is a method for strings that converts them to another type.
         * `expect()` is checking if the result of `parse()` fails.
        */

        // the following is a better implementation for parsing `guess` to a string by handling
        // all errors in the parsing

        let guess: i32 = match guess.trim().parse() {
            Ok(num) => num,
            //Err(_) => continue,
            Err(_) => {
                println!("please enter only digits");
                continue;
            }
        };

        println!("You guessed: {guess}");  // in python we'd make this an f-string, in rust that's not needed for `String` types.

        match guess.cmp(&secret_number) {
            Ordering::Less => println!("too small"),
            Ordering::Greater => println!("too big"),
            Ordering::Equal => {
                println!("Winner winner chicken dinner");
                break;
            }

        }
    }
}
