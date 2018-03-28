import Html exposing (Html, div, h1, input, span, button, text)
import Html.Attributes exposing (style, placeholder, value)
import Html.Events exposing (onClick, onInput)
import String
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
  (Model 1 0 100, Random.generate NewFace (Random.int 0 100))

-- UPDATE

type Msg
  = Generate
  | NewFace Int
  | Min String
  | Max String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Generate ->
      (model, Random.generate NewFace (Random.int model.min model.max))

    NewFace newFace ->
      (Model newFace model.min model.max, Cmd.none)

    Min newMin ->
      (Model model.dieFace (Result.withDefault 0 (String.toInt newMin)) model.max, Cmd.none)

    Max newMax ->
      (Model model.dieFace model.min (Result.withDefault 0 (String.toInt newMax)), Cmd.none)

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
          div [] [
            span [ textStyle ] [ text "from" ],
            input [ inputStyle, placeholder "Min", onInput Min, value (toString model.min) ] [],
            span [ textStyle ] [ text "to" ],
            input [ inputStyle, placeholder "Max", onInput Max, value (toString model.max) ] []
          ],
          h1 [ numberStyle ] [ text (toString model.dieFace) ],
          button [ btnStyle, onClick Generate ] [ text "Generate" ]
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

textStyle =
  style
    [
      ("font-size", "20px"),
      ("font-family", "Helvetica")
    ]

inputStyle =
  style
    [
      ("border", "none"),
      ("outline", "none"),
      ("margin", "0 10px"),
      ("color", "#757575"),
      ("font-size", "24px"),
      ("max-width", "100px"),
      ("border-radius", "5px"),
      ("padding", "10px 15px")
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
