module Text where

class Printable t
    where textOf :: t -> String
