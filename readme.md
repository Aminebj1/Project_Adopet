## AdoPet: une application d´adoption des chiens
on veut implémenter AdoPet. les principales fonctionnalités sont:
- Afficher la liste de dogs
- En cliquqnt sur chaque ligne on accede au detail de chaque chien
la classe dog est caractérisée par 
class Dog(
    id: Int,
    name: String,
    age: Double,
    gender: String,
    color: String,
    weight: Double,
    location: String,
    image: Int,
    about: String,
     owner:Owner
) 

la classe Owner est caractérisée par data Owner(name: String, bio: String, image: Int)
