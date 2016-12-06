import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onClick )

-- Model

type alias Model = Int

model : number
model = 0

-- View

type alias Hero =
  { id: Int
  , name: String
  }

title = "Tour of Heroes"
hero =
  { id = 1
  , name = "Windstorm"
  }

renderHero hero =
  [ h2 [] [(text (hero.name ++ " details!"))]
  , div [class "row"]
      [ label [class "col-xs-2"] [(text "id:")]
      , span [class "col-xs-10"] [(text (toString hero.id))]
      ]
  , div [class "row"]
      [ label [class "col-xs-2"] [(text "name:")]
      , span [class "col-xs-10"] [(text hero.name)]
      ]
  ]

view : Model -> Html Msg
view model =
  div [class "container"]
    [ div [ class "jumbotron" ]
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
