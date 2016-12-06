import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- Model

heroes : List Hero
heroes = [
  { id= 11, name= "Mr. Nice" },
  { id= 12, name= "Narco" },
  { id= 13, name= "Bombasto" },
  { id= 14, name= "Celeritas" },
  { id= 15, name= "Magneta" },
  { id= 16, name= "RubberMan" },
  { id= 17, name= "Dynama" },
  { id= 18, name= "Dr IQ" },
  { id= 19, name= "Magma" },
  { id= 20, name= "Tornado" }
 ]

type alias Model = {
  hero: Hero
}

type alias Hero = {
  id: Int,
  name: String
 }

windstorm : Hero
windstorm = {
  id = 1,
  name = "Windstorm"
 }

model : Model
model = {
  hero = windstorm
 }

-- View

title : String
title = "Tour of Heroes"

heroDetails : Hero -> List (Html Msg)
heroDetails hero = [
  h2 [] [(text (hero.name ++ " details!")) ],
  div [class "form-horizontal"] [
    div [class "form-group"] [
      label [for "id", class "col-sm-2 control-label"] [(text "Id")],
      div [class "col-sm-2"] [
        input [id "id", class "form-control", disabled True, value (toString hero.id)] []
      ]
    ],
    div [class "form-group"] [
      label [for "name", class "control-label col-sm-2"] [(text "Name")],
      div [class "col-sm-6"] [
        input [
          id "name",
          class "form-control",
          value hero.name,
          placeholder "Name",
          onInput Change
        ] []
      ]
    ]
  ]
 ]

heroList : List Hero -> List (Html Msg)
heroList heroes = [
  h2 [] [(text "My Heroes")],
  ul [class "heroes"] [
    li [] [text "a hero"]
  ]
 ]

view : Model -> Html Msg
view model =
  div [class "container main"] [
    div [class "jumbotron"]
      ([h1 [class "text-center"] [(text title)]]
        ++ heroList heroes
        ++ heroDetails model.hero)
  ]

-- Update

type alias HeroName = String

type Msg = Change HeroName

update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newHeroName ->
      let
        hero = model.hero
        newHero = { hero | name = newHeroName }
      in
        { model | hero = newHero }

-- App

main : Program Never Model Msg
main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }
