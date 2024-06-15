module SPA exposing (main)

import Browser
import Html exposing (..)
import Html.Events exposing (onClick)


type Page
    = Home
    | Login
    | About


type alias Flags =
    {}


type alias Model =
    { currentPage : Page
    }


init : flags -> ( Model, Cmd Msg )
init flags =
    ( Model Home, Cmd.none )


# implement url navigation


-- UPDATE

type Msg
    = GoHome
    | GoLogin
    | GoAbout


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GoHome ->
            ( { model | currentPage = Home }, Cmd.none )

        GoLogin ->
            ( { model | currentPage = Login }, Cmd.none )

        GoAbout ->
            ( { model | currentPage = About }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "SPA application" ]
        , render_menu model
        , render_page model
        ]


render_menu : Model -> Html Msg
render_menu model =
    div []
        [ button [ onClick GoHome ] [ text "Home" ]
        , button [ onClick GoLogin ] [ text "Login" ]
        , button [ onClick GoAbout ] [ text "About" ]
        ]


render_page : Model -> Html Msg
render_page model =
    let
        page_content =
            case model.currentPage of
                Home ->
                    text "Home"

                Login ->
                    text "Login"

                About ->
                    text "About"
    in
    div [] [ page_content ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
