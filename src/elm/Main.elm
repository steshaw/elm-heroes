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

heroes =
  [ h1 [] [(text title)]
  , h2 [] [(text (hero.name ++ " details!"))]
  ]

view : Model -> Html Msg
view model =
  div [ class "container main" ] [
    div [ class "jumbotron" ]
      heroes
{-
      [ hello model
      , p [] [ text "Elm Tour of Heroes" ]
      , button [ class "btn btn-primary btn-lg", onClick Increment ]
          [ span [ class "glyphicon glyphicon-star" ] []
          , span [] [ text "FTW!" ]
          ]
      , br [] []
      , br [] []
      , img [ src "static/img/elm.jpg", style imgStyles ] []
    ]
-}
  ]

-- Update

type Msg = NoOp | Increment

update : Msg -> Model -> Model
update msg model =
  case msg of
    NoOp -> model
    Increment -> model + 1

imgStyles : List (String, String)
imgStyles =
  [ ( "width", "33%" )
  , ( "border", "4px solid #337AB7")
  ]

-- App

main : Program Never Int Msg
main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }
