import Html exposing (Html, div, text, img)
import Html.Attributes exposing (style, src)
import Html.Events exposing (onClick)
import Json.Decode as Decode
import Http

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
    url : String
  }

init : (Model, Cmd Msg)
init =
  (Model "", getRandomImg)

-- UPDATE

type Msg
  = Generate
  | NewImg (Result Http.Error String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Generate ->
      (model, getRandomImg)

    NewImg (Ok newUrl) ->
      ( { model | url = newUrl }, Cmd.none)

    NewImg (Err _) ->
      (model, Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- VIEW

view : Model -> Html Msg
view model =
  div [ containerStyle ]
    [
      img [ imgStyle, src model.url ] []
    ]

containerStyle =
  style
    [
      ("width", "100%"),
      ("padding", "70px 25px"),
      ("text-align", "center")
    ]

imgStyle =
  style
    [
      ("width", "300px")
    ]

getRandomImg : Cmd Msg
getRandomImg =
  let
    url = "https://dog.ceo/api/breeds/image/random"

    request =
      Http.get url decodeImgUrl
  in
    Http.send NewImg request

decodeImgUrl : Decode.Decoder String
decodeImgUrl =
  Decode.at ["message"] Decode.string
