import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onClick )

-- Model

type alias Model = Int

model : number
model = 0

-- View

type alias Hero = {
  id: Int,
  name: String
 }

title : String
title = "Tour of Heroes"

hero : Hero
hero = {
  id = 1,
  name = "Windstorm"
 }

renderHero : Hero -> List (Html msg)
renderHero hero = [
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
        input [id "name", class "form-control", value hero.name] []
      ]
    ]
  ]
 ]

view : Model -> Html Msg
view model =
  div [class "container"] [
    div [class "jumbotron"]
      ([h1 [class "main"] [(text title)]] ++ renderHero hero)
  ]

-- Update

type Msg = NoOp | Increment

update : Msg -> Model -> Model
update msg model =
  case msg of
    NoOp -> model
    Increment -> model + 1

-- App

main : Program Never Int Msg
main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }
