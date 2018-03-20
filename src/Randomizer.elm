import Html exposing (Html, div, h1, button, text)
import Html.Attributes exposing (style)
import Html.Events exposing (..)
import Random

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL

type alias Model =
  {
    dieFace : Int,
    min : Int,
    max : Int
  }

init : (Model, Cmd Msg)
init =
  (Model 1 0 100, Cmd.none)

-- UPDATE

type Msg
  = Roll
  | NewFace Int

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace (Random.int model.min model.max))

    NewFace newFace ->
      (Model newFace model.min model.max, Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- VIEW

view : Model -> Html Msg
view model =
  div [ containerStyle ]
    [
      div [ contentStyle ]
        [
          h1 [ numberStyle ] [ text (toString model.dieFace) ],
          button [ btnStyle, onClick Roll ] [ text "Generate" ]
        ]
    ]

containerStyle =
  style
    [
      ("width", "100%"),
      ("height", "100%"),
      ("padding", "20px"),
      ( "display", "flex"),
      ("align-items", "center"),
      ("background", "#FFC107"),
      ("justify-content", "center")
    ]

contentStyle =
  style
    [
      ("text-align", "center")
    ]

numberStyle =
  style
    [
      ("font-size", "66px"),
      ("margin-bottom", "30px")
    ]

btnStyle =
  style
    [
      ("color", "#fff"),
      ("border", "none"),
      ("outline", "none"),
      ("font-size", "24px"),
      ("cursor", "pointer"),
      ("padding", "20px 30px"),
      ("background", "#673AB7"),
      ("border-radius", "10px"),
      ("border-bottom", "7px solid #512DA8")
    ]
