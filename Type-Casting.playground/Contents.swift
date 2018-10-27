//
//  Type-Casting.playground
//  Swift
//
//  Created by Mahesh Gahlot <gahlotmahesh8@gmail.com>
//

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String){
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String){
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Venom", director: "Ruben Fleischer"),
    Movie(name: "Walking Dead", director:"Preston A. Whitmore II"),
    Song(name: "Closer", artist:"Chainsmokers"),
    Song(name: "Rap God", artist: "Eminem")
]

let movie = library[0]
//print(movie.director)    // error: value of type 'MediaItem' has no member 'director'
//
// Here type of library and movie constants is MovieType.
//This is similar to upcasting in java(subclass object can be stored into superclass object and it is implicitly done)

//but by doing so we are not able to access the propeties which are defined by subclasses so we need to explicitly downcast to access those properties
//

//      Checking Type
//Using The type check operator

var movieCount = 0, songCount = 0

for item in library {
    if item is Movie{
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Media Library contains \(movieCount) movies and \(songCount) songs")

//      DownCasting
//
/*
 
 A constant or variable of a certain class type may actually refer to an instance of a subclass behind the scenes. Where you believe this is the case, you can try to downcast to the subclass type with a type cast operator (as? or as!).
 for Example: In Above code [line 38] Constant 'movie' type  is 'MediaItem' class but it refers to an instance of 'Movie' class behined the scenes
Because downcasting can fail, the type cast operator comes in two different forms. The conditional form, as?, returns an optional value of the type you are trying to downcast to. The forced form, as!, attempts the downcast and force-unwraps the result as a single compound action.
 
 */

for item in library{
    if let _movie = item as? Movie{
        print("Movie: \(_movie.name), director: \(_movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
    
}

// Type Casting for any and AnyObject
//
/*
 
 Swift provides two special types for working with nonspecific types:
        :-> Any can represent an instance of any type at all, including function types.
        :-> AnyObject can represent an instance of any class type.
 
 Use Any and AnyObject only when you explicitly need the behavior and capabilities they provide.
 It is always better to be specific about the types you expect to work with in your code.
 
 */

var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}

