module Bootstrap.Carousel.SlideInternal exposing (..)

{-| Config type
-}

import Html.Styled exposing (Html, div, img, text)
import Html.Styled.Attributes as Attributes exposing (class)


type Config msg
    = Config
        { attributes : List (Html.Styled.Attribute msg)
        , content : SlideContent msg
        , caption : Maybe { attributes : List (Html.Styled.Attribute msg), children : List (Html msg) }
        }


type SlideContent msg
    = Image { attributes : List (Html.Styled.Attribute msg), src : String }
    | Custom { html : Html msg }


{-| Function to add extra attributes to an existing slide. Used to put the proper classes for css transitions
on a slide in a carousel.
-}
addAttributes newAttributes (Config settings) =
    Config { settings | attributes = settings.attributes ++ newAttributes }


{-| Convert a slide config to html

Not exposed because it does not make sense to have a standalone slide outside of a carousel.

-}
view : Config msg -> Html msg
view (Config { attributes, content, caption }) =
    let
        captionHtml =
            case caption of
                Nothing ->
                    text ""

                Just { attributes, children } ->
                    div (attributes ++ [ class "carousel-caption d-none d-md-block" ]) children
    in
        div (attributes ++ [ class "carousel-item" ]) <|
            case content of
                Image { attributes, src } ->
                    [ img (attributes ++ [ class "d-block img-fluid", Attributes.src src ]) []
                    , captionHtml
                    ]

                Custom { html } ->
                    [ html
                    , captionHtml
                    ]
