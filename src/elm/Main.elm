import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- Model

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

view : Model -> Html Msg
view model =
  div [class "container"] [
    div [class "jumbotron"]
      ([h1 [class "main"] [(text title)]] ++ heroDetails model.hero)
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
