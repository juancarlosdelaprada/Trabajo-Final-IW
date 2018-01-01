# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Reviewer.destroy_all
reviewers = Reviewer.create! [
    { name: "Joe", password: "abc123" },    
    { name: "Jim", password: "123abc" }
]

Book.destroy_all
Book.create! [
    { name: "Eloquent Ruby", author: "Russ Olsen", reviewer: reviewers.sample },
    { name: "Beginning Ruby", author: "Peter Cooper", reviewer: reviewers.sample },
    { name: "Metaprogramming Ruby", author: "Paolo Perrotta", reviewer: reviewers.sample },
    { name: "Design Patterns in Ruby", author: "Russ Olsen", reviewer: reviewers.sample },
    { name: "The Ruby Programming Language", author: "David Flanagen", reviewer: reviewers.sample }
]

b = Book.find_by(name: "Eloquent Ruby")
b.notes.create! [
    { title: "Wow", note: "Gran libro para aprender Ruby" },
    { title: "Greate", note: "Perfecto para iniciarte" }
]