/*:
## Control Flow
 
 * Much of the control flow in Swift is similar to C-like languages, but there are some key
   differences. For example, switch-case constructs are much more flexible and powerful as well
   as extensions to break and continue statements.
 
 ### Looping Constructs
 Swifts loops consist of `for`, `repeat` and `while`
 
 ### For-in loops

 For loops loop over all elements of type Sequence.  We'll study sequences later, but for now
 lets just say that there are many types, one of which is a Range.  Range has special syntax
 support in Swift in form of `...` and `..<`.
 
 In the loop below, `index` is a sequence value and is automatically declared as part of the for-in
 construct.
*/
for index in 1...5 {
	"This will print 5 times"
    // Being a constant, the following line won't compile:
    // index = 99
}

/*:
 If you don't need the value from the sequnce inside the loop you can ignore it
 by using `_` as the loop variable.
*/
var mantissa = 2, exponent = 8, product = 1
for _ in 1...exponent { product *= mantissa }
product

/*:
 The constant `index` from the previous loop is scoped only to the loop. As a result, you cannot
 access it beyond the loop. The following line will not compile:

 ```
 index = 0
```
 We can loop through ranges using the half-closed range operator ("..<")

 We can also reuse the name 'index' because of the scoping noted previously.
*/
for _ in 1 ..< 5 { "This will print 4 times" }
/*:
 Apple's "Swift Programming Language" book states the following, which I find in practice to be
 incorrect:
```
 “The index constant exists only within the scope of the loop. If you want to check the value of
 index after the loop completes, or if you want to work with its value as a variable rather than
 a constant, you must declare it yourself before its use in the loop.”
```
 *Important Note* Unlike in C, Swift
 for-in loops _ALWAYS_ define their own loop index
 which does not effect anything outside the loop. So, in the code
 below, indx inside the loop is actually a different variable than 
 indx outside the loop.
*/
var indx = 3999
for indx in 1...5 {
	indx //: This ranges from 1 to 5, inclusive
    //	 `indx` is still acting like a constant, so this line won't compile:
    // indx += 1
}
/*: 
 After the loop, we find that 'indx' still contains the original value 
 of 3999. indx could have been of a completely different type, say String
 and the loop would have been unaffected.
*/
indx
/*: 
 You can use an underscore if you don't need access to the loop constant:
*/
for _ in 1...10 { print("do something") }
/*: 
 We can iterate over arrays, which are also a type of Sequence
*/
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names { name }
/*: 
 We can iterate over a Dictionary's key/value pairs because Dictionaries are also a Sequence
 of tuples, i.e. in the key/value pairs.
 */
let numberOfLegs = ["Spider":8, "Ant":6, "Cat":4]
for (animalName, legs) in numberOfLegs { animalName; legs }
/*: 
 We can iterate over characters in a String because, you guessed it, String is also a Sequence.
 *Important Note*, there is nothing special about the Sequences we are using here, you can write
 your own and if you do, you can use it in a for-in loop just like all the ones we've used so far.
*/
for character in "Hello" {
	character
    print(type(of:character))
}
/*:
 Variables are scoped to the For-Condition-Increment construct. To alter this, pre-declare index
*/
var index = 3000
for index in 0 ..< 3 {
	index
}
index // Index holds 3 after running through the loop
/*:
 ### While loops

 While loops resemble other C-like languages. They perform the condition before each iteration
 through the loop:
*/
while index > 0 {
	index -= 1
}
/*:
 Repeat-While loops also resemble their C-like language counterparts. They perform the condition
 after each iteration through the loop. As a result, they always execute the code inside the
 loop at least once:
*/
repeat {
	index += 1
} while (index < 3)
/*:
 ###  Conditional Statements
 Swift's conditional statements are if and switch
 
 ### If
 The if statement is very similar to C-like languages, except that the parenthesis are optional.
 You can also chain multiple conditions with 'else' and 'else if' statements:
*/
if (index > 0) {
	"Index is positive"
}
else if index == 0 {
	"index is zero"
}
else {
	"index is negative"
}
/*:
 ### Switch
 Switch statements in Swift are far more powerful than their 
 C-like counterparts. Here are a few of those differences to get us started:

 *Important Point* Unlike C-like languages, switch statements do not require a 
 "break" statement to prevent falling  through to the next case.

 Additionally, multiple conditions can be separated by a comma for a single case to match
 multiple conditions.

 Switch statements must also be exhaustive and include all possible values, or the compiler will
 generate an error.

 There are many more differences, but let's start with a simple switch statement to get our feet
 wet:
*/
let someCharacter: Character = "e"
switch someCharacter {
	case "a", "e", "i", "o", "u":
		"a vowel"
	
	case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "z":
		"a consonant"

	// Necessary because switch statements must be exhaustive in order to capture all Characters
	default:
		"not a vowel or consonant"
}
/*:
 Each case clause must have a statement of some kind. A comment will not suffice.

 Otherwise you will get a compilation error. The following won't compile because there is an
 empty case statement:
```
 let anotherCharacter: Character = "a"
 switch anotherCharacterb{
		case "a":
		case "A":
			"the letter a"
		default:
			"not the letter a"
 }
```
 We can perform range matching for cases:
*/
let count = 3_000_000_000_000
switch count {
	case 0:
		"no"
	case 1...3:
		"a few"
	case 4...9:
		"several"
	case 10...99:
		"tens of"
	case 100...999:
		"hundreds of"
	case 1000...999999:
		"thousands of"
	default:
		"millions and millions of"
}
/*:
 ### Matching against tuples

 In addition to matching Tuples, we can also use ranges inside Tuple values and even match
 against partial Tuple values by using an "_" to ignore matches against a specific value within
 the Tuple.
*/
let somePoint = (1,1)
switch somePoint {
	case (0,0):
		"origin"
	
	// Match only against y=0
	case (_, 0):
		"On the X axis"
	
	// Match only against x=0
	case (0, _):
		"On the y axis"
	
	// Match x and y from -2 to +2 (inclusive)
	case (-2...2, -2...2):
		"On or inside the 2x2 box"
	
	// Everything else
	default:
		"Outisde the 2x2 box"
}
/*:
 ### Value bindings in switch statements
*/
var anotherPoint = (2, 8)
switch anotherPoint {
	// Bind 'x' to the first value (matching any x) of the tuple and match on y=0
	case (let x, 0):
		"On the x axis with an x value of \(x)"
	
	// Bind 'y' to the second value (matching any y) of the tuple and match against x=0
	case (0, let y):
		"On the y axis with an y value of \(y)"
	
	// Bind both values of the tuple, matching any x or y. Note the shorthand of the 'let'
	// outside of the parenthesis. This works with 'var' as well.
	//
	// Also notice that since this matches any x or y, we fulfill the requirement for an exhaustive
	// switch.
	case let (x, y):
		"Somewhere else on \(x), \(y)"
}
/*:
 We can also mix let/var for case statements. The following code block is the same as the
 previous except that the final case statement, which mixes variable and constants for 
 the x and y components of the Tuple.
*/
switch anotherPoint {
	case (let x, 0):
		"On the x axis with an x value of \(x)"
	
	case (0, let y):
		"On the y axis with an y value of \(y)"
	
	case (var x, let y):
		x += 1 // We can modify the variable 'x', but not the constant 'y'
		"Somewhere else on \(x), \(y)"
}
/*:
 Where clauses allow us to perform more detailed conditions on case conditions. The where clauses
 work on the values declared on the case line:
*/
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    "On the line of x == y"
    
case let (x, y) where x == -y:
    "On the line of x == -y"
    
case (_, _):
    "Just some arbitrary point"
}
/*:
 ### Control transfer statements

 Swift supports extended versions of continue and break as well as an additional 'fallthrough'
 statement for switch-case constructs.

 Since swift doesn't require a break statement to avoid falling through to the next case, we can
 still use them to early-out of the current case without continuing work. The first statement
 after the 'break' will be the next statement following the entire switch construct.
*/
let someValue = 9000
switch someValue {
	case let x where (x & 1) == 1:
		if someValue < 100 {
			"Odd number less than 100"
			break
		}
		"Odd number greater or equal to 100"
		
	case let x where (x & 1) == 0:
		if someValue < 100 {
			"Even number less than 100"
			break
		}
		"Even number greater or equal to 100"
	
	default:
		"Unknown value"
}
/*:
 Since each case must have a statement and since we must have an exhaustive switch, we can use
 the break statement to effectively nullify the use of a case:
*/
switch someValue {
	case Int.min...100:
		"Small number"
	
	case 101...1000:
		break // We don't care about medium numbers
	
	case 1001...100_00:
		"Big number"
	
	default:
		break // We don't care about the rest, either
}
/*:
 Since we don't need to break out of cases to avoid falling through automatically, we must
 specifically express our intention to fall through using the 'fallthrough' keyword
*/
let integerToDescribe = 5
var integerDescription = "\(integerToDescribe) is"
switch integerToDescribe {
	case 2, 3, 5, 7, 11, 13, 17, 19:
		integerDescription += " a prime number, and also"
		fallthrough
	
	default:
		integerDescription += " an integer."
}
/*:
 Continue and Break statements have been extended in Swift to allow each to specify which
 switch or loop construct to break out of, or continue to.

 To enable this, labels are used, similar to labels used by C's goto statement.

 The following will print each name until it reaches the letter 'a' then skip to the next name
*/
var result = ""
nameLoop: for name in names {
	characterLoop: for character in name {
		theSwitch: switch character {
			case "a":
				// Break out of the theSwitch and characterLoop
				break characterLoop
			
			default:
				result += String(character)
		}
	}
}
result
//: Similarly, this prints all names without the letter 'a' in them:
result = ""
nameLoop: for name in names {
	characterLoop: for character in name {
		theSwitch: switch character {
			case "a":
                // Continue directly to the character loop, bypassing this character in this name
				continue characterLoop
			
			default:
				result += String(character)
		}
	}
}
result
/*:
 Similarly, this prints all names until the letter 'x' is found, then aborts all processing by
 breaking out of the outer loop:
*/
result = ""
nameLoop: for name in names {
	characterLoop: for character in name {
		theSwitch: switch character {
			case "x":
                // Break completely out of the outer name loop
                break nameLoop
			
			default:
				result += String(character)
		}
	}
}
result

/*:
 ### Other Control Transfer Statements
 
 In addition to `continue`, `break`, and `fallthrough`, Swift has two other control transfer statements:
 `return` and `throw`.  Use of `return` is shown in the Functions playground, `throw` is detailed in Try, Catch, Defer, Throws
 */

/*:
 ### Labelled Statements
 
 Suppose we have a nested control structure and under some condition inside
 the inner structure, we want to continue to the outer structure.  
 Here's an example of that
 */
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0

gameLoop: while square != finalSquare {
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    switch square + diceRoll {
    case finalSquare:
        // diceRoll will move us to the final square, so the game is over
        break gameLoop
    case square + diceRoll where (square + diceRoll) > finalSquare:
        // diceRoll will move us beyond the final square, so roll again
        continue gameLoop
    default:
        // this is a valid move, so find out its effect
        square += diceRoll
        square += board[square]
    }
}
print("Game over!")
/*:
 _(Excerpt From: Apple Inc. “The Swift Programming Language (Swift 3.0.1).” iBooks.)_

 Note that in this case the `break` and `continue` statements, do not apply
 just to the `switch` statement they are embedded in, the apply to the outer
 while loop.
 
 ### Early Exit and the `guard` statement
 
 One very important construct in Swift is the `guard` statement.  
 It's use is covered in the Functions playground.
 */

