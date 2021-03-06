import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Json
import Process
import Task

-- Services

url = "http://localhost:8080/heroes"

decodeHero : Json.Decoder Hero
decodeHero =
  Json.map2 Hero (Json.field "id" Json.int) (Json.field "name" Json.string)

decodeHeroes : Json.Decoder (List Hero)
decodeHeroes =
  Json.list decodeHero

{-
getHeroesByHttp : Cmd Msg
getHeroesByHttp =
  Http.send Heroes (Http.get url decodeHeroes)
-}

getHeroesFake : Cmd Msg
getHeroesFake =
  Process.sleep 3000
    |> Task.andThen (always <| Task.succeed <| Heroes heroes)
    |> Task.perform identity

getHeroes : Cmd Msg
getHeroes = getHeroesFake

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
  heroes: Maybe (List Hero)
}

type alias Hero = {
  id: Int,
  name: String
}

model : Model
model = {
  hero = Nothing,
  heroes = Nothing
 }

-- View

title : String
title = "Tour of Heroes"

-- heroList : List Hero -> List (Html Msg)
heroList model = [
  h2 [] [(text "My Heroes")],
  case model.heroes of
    Nothing ->
      span [] [
        i [class "glyphicon glyphicon-refresh glyphicon-spin"] [],
        text " Loading..."
      ]

    Just heroes ->
      ul [class "heroes list-group"]
        (heroes |> List.map (\hero ->
          li [
            classList [
              ("list-group-item", True),
              ("active", (Maybe.withDefault False (model.hero |> Maybe.map (\modelHero ->
                modelHero.id == hero.id
              ))))
            ],
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
  | Heroes (List Hero)

switchHero : Hero -> List Hero -> List Hero
switchHero hero heroes =
  heroes |> List.map (\h ->
    if h.id == hero.id then hero else h
  )

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  (case msg of
    Select hero ->
      ({ model | hero = Just hero }, Cmd.none)

    Change newHeroName ->
      case model.heroes of
        Nothing -> Debug.crash "Cannot change hero name when there are no heroes"

        Just heroes ->
          case model.hero of
            Just hero ->
              let
                newHero = { hero | name = newHeroName }
              in
                ({ model |
                  hero = Just newHero,
                  heroes = Just <| switchHero newHero heroes
                }, Cmd.none)

            Nothing ->
              (model, Cmd.none) |> Debug.crash "This should not happen"

    Heroes heroes ->
      ({model | heroes = Just heroes }, Cmd.none)

  ) |> Debug.log ("update msg=" ++ (toString msg))

-- App

main : Program Never Model Msg
main =
  Html.program
    { init = (model, getHeroes)
    , view = view
    , update = update
    , subscriptions = always Sub.none
    }
