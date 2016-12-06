import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- Model

heroes : List Hero
heroes = [
  { id = 1,  name = "Windstorm" },
  { id = 11, name = "Mr. Nice" },
  { id = 12, name = "Narco" },
  { id = 13, name = "Bombasto" },
  { id = 14, name = "Celeritas" },
  { id = 15, name = "Magneta" },
  { id = 16, name = "RubberMan" },
  { id = 17, name = "Dynama" },
  { id = 18, name = "Dr IQ" },
  { id = 19, name = "Magma" },
  { id = 20, name = "Tornado" }
 ]

type alias Model = {
  hero: Maybe Hero,
  heroes: List Hero
}

type alias Hero = {
  id: Int,
  name: String
 }

model : Model
model = {
  hero = Nothing,
  heroes = heroes
 }

-- View

title : String
title = "Tour of Heroes"

-- heroList : List Hero -> List (Html Msg)
heroList model = [
  h2 [] [(text "My Heroes")],
  ul [class "heroes list-group"]
    (model.heroes |> List.map (\hero ->
      li [
        class (Maybe.withDefault "list-group-item" (model.hero |> Maybe.map (\modelHero ->
          if modelHero.id == hero.id then "active list-group-item" else "list-group-item"
        ))),
        onClick (Select hero)
      ] [
        span [class "badge"] [
          text (toString hero.id)
        ],
        text hero.name
      ]
    ))
 ]

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
  div [class "container main"] ([
    div [class "jumbotron text-center"] [
      h1 [] [(text title)],
      i [] [(text "with "), a [href "http://elm-lang.org/"] [(text "Elm")]]
    ]
  ] ++ heroList model ++ (Maybe.withDefault [] (Maybe.map heroDetails model.hero)))

-- Update

type alias HeroName = String

type Msg
  = Select Hero
  | Change HeroName

switchHero hero heroes =
  heroes |> List.map (\h ->
    if h.id == hero.id then hero else h
  )

update : Msg -> Model -> Model
update msg model =
  (case msg of
    Select hero ->
      { model | hero = Just hero }

    Change newHeroName ->
      case model.hero of
        Just hero ->
          let
            newHero = { hero | name = newHeroName }
          in
            { model |
              hero = Just newHero,
              heroes = switchHero newHero model.heroes
            }

        Nothing ->
          model |> Debug.crash "This should not happen")
    |> Debug.log ("update msg=" ++ (toString msg))

-- App

main : Program Never Model Msg
main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }
