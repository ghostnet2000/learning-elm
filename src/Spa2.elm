module Spa2 exposing (main)

import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Navbar as Navbar
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)


main : Program Flags Model Msg
main =
    Browser.element
        { view = view
        , update = update
        , subscriptions = subscriptions
        , init = init
        }


view : Model -> Html Msg
view model =
    div []
        [ CDN.stylesheet
        , menu model
        , mainContent
        ]


type alias Flags =
    {}


type alias Model =
    { navState : Navbar.State
    }


init : flags -> ( Model, Cmd Msg )
init flags =
    let
        ( navState, navCmd ) =
            Navbar.initialState NavMsg
    in
    ( { navState = navState }, navCmd )


type Msg
    = NavMsg Navbar.State


subscriptions : Model -> Sub Msg
subscriptions model =
    Navbar.subscriptions model.navState NavMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NavMsg state ->
            ( { model | navState = state }
            , Cmd.none
            )


menu : Model -> Html Msg
menu model =
    Navbar.config NavMsg
        |> Navbar.withAnimation
        |> Navbar.container
        |> Navbar.brand [ href "#" ] [ text "Elm Bootstrap" ]
        |> Navbar.items
            [ Navbar.itemLink [ href "#" ] [ text "Item 1" ]
            , Navbar.itemLink [ href "#" ] [ text "Item 2" ]
            ]
        |> Navbar.view model.navState


mainContent : Html Msg
mainContent =
    Grid.container [] <|
        [ h1 [] [ text "content" ] ]
